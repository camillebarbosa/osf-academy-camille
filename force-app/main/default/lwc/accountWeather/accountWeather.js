import { LightningElement, wire, api, track } from "lwc";
import { getRecord } from "lightning/uiRecordApi";
import BILLING_CITY_FIELD from "@salesforce/schema/Account.BillingCity";
import getWeatherData from "@salesforce/apex/WeatherService.getWeatherData";

export default class AccountWeather extends LightningElement {
  @api recordId;
  @track weather;
  @track error;

  temperature = 0;
  description = "";
  feelsLike = 0;
  humidity = 0;
  wind = 0;
  weatherIcon = "";

  @wire(getRecord, { recordId: "$recordId", fields: [BILLING_CITY_FIELD] })
  accountData({ data, error }) {
    if (data) {
      const city = data.fields.BillingCity.value;
      if (city) {
        this.callWeatherAPI(city);
      } else {
        this.error =
          "Este cliente não possui uma Cidade de Faturamento cadastrada.";
      }
    } else if (error) {
      this.error = "Erro ao carregar dados da conta.";
    }
  }

  callWeatherAPI(city) {
    getWeatherData({ city: city })
      .then((result) => {
        this.weather = result;
        this.error = undefined;
        this.temperature = Math.round(result.main.temp);
        this.feelsLike = Math.round(result.main.feels_like);
        this.humidity = result.main.humidity;
        this.wind = result.wind.speed;
        this.description = result.weather[0].description;
        this.weatherIcon = `https://openweathermap.org/img/wn/${result.weather[0].icon}@2x.png`;
      })
      .catch((err) => {
        this.weather = undefined;
        // Extrai a mensagem de erro de forma robusta
        this.error = err.body ? err.body.message : err.message;
      });
  }

  // Getter para simplificar a exibição do erro no HTML
  get errorMessage() {
    return this.error;
  }

  // ... Seus getters de estilo (isHot, isRain, etc) continuam iguais
  get cardClass() {
    if (this.isHot) return "card hot";
    if (this.isSnow) return "card cold";
    if (this.isRain) return "card rainCard";
    if (this.isCloudy) return "card cloudyCard";
    return "card rainCard";
  }

  get isHot() {
    return this.temperature >= 82;
  }
  get isRain() {
    return this.description.toLowerCase().includes("rain");
  }
  get isSnow() {
    return (
      this.description.toLowerCase().includes("snow") || this.temperature <= 32
    );
  }
  get isCloudy() {
    return this.description.toLowerCase().includes("clouds");
  }
  get isSunny() {
    return (
      this.description.toLowerCase().includes("sun") ||
      (this.temperature > 82 && !this.isRain)
    );
  }
}
