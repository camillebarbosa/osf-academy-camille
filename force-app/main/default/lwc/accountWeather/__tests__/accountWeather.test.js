import { createElement } from "lwc";
import AccountWeather from "c/accountWeather";
import getWeatherData from "@salesforce/apex/WeatherService.getWeatherData";
import { getRecord } from "lightning/uiRecordApi";

// Função utilitária para esperar a renderização
async function flushPromises() {
  return Promise.resolve();
}

jest.mock(
  "@salesforce/apex/WeatherService.getWeatherData",
  () => ({ default: jest.fn() }),
  { virtual: true }
);

describe("c-account-weather", () => {
  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  it("displays weather data when API returns success", async () => {
    const element = createElement("c-account-weather", { is: AccountWeather });
    document.body.appendChild(element);

    const mockData = {
      main: { temp: 85, feels_like: 80, humidity: 50 },
      weather: [{ description: "sunny", icon: "01d" }],
      wind: { speed: 10 }
    };

    getWeatherData.mockResolvedValue(mockData);

    // Dispara o wire da cidade
    getRecord.emit({
      fields: { BillingCity: { value: "New York" } }
    });

    // PRECISAMOS DE DOIS FLUSHES: Um para a Promise do Apex e outro para a renderização do DOM
    await flushPromises();
    await flushPromises();

    const tempDiv = element.shadowRoot.querySelector(".temp");
    // Usamos .toContain para evitar problemas com espaços ou caracteres especiais
    expect(tempDiv.textContent).toContain("85");
  });

  it("displays error message when API fails", async () => {
    const element = createElement("c-account-weather", { is: AccountWeather });
    document.body.appendChild(element);

    getWeatherData.mockRejectedValue({
      body: { message: "City not found" }
    });

    getRecord.emit({
      fields: { BillingCity: { value: "InvalidCity" } }
    });

    await flushPromises();
    await flushPromises();

    // Verifica se o elemento de erro aparece (ajuste o seletor conforme seu HTML de erro)
    const errorMsg = element.shadowRoot.querySelector(
      ".slds-text-heading_small"
    );
    expect(errorMsg).not.toBeNull();
  });
});
