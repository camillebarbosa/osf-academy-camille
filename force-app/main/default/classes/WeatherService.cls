public class WeatherService {
  @AuraEnabled(cacheable=true)
  public static WeatherResponseWrapper getWeatherData(String city) {
    String encodedCity = EncodingUtil.urlEncode(city, 'UTF-8');

    HttpRequest req = new HttpRequest();
    req.setEndpoint(
      'https://api.openweathermap.org/data/2.5/weather?q=' +
        encodedCity +
        '&units=imperial&appid=74f1a566657e4cd26c671828961bc56a'
    );
    req.setMethod('GET');

    Http http = new Http();

    try {
      HttpResponse res = http.send(req);

      if (res.getStatusCode() == 200) {
        WeatherResponseWrapper results = (WeatherResponseWrapper) JSON.deserialize(
          res.getBody(),
          WeatherResponseWrapper.class
        );

        System.debug('Resultados: ' + results);
        return results;
      } else {
        throw new AuraHandledException('Erro API: ' + res.getBody());
      }
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  // 🔥 WRAPPER COMPLETO
  public class WeatherResponseWrapper {
    @AuraEnabled
    public coordDTO coord { get; set; }
    @AuraEnabled
    public List<weatherDTO> weather { get; set; }
    @AuraEnabled
    public mainDTO main { get; set; }
    @AuraEnabled
    public windDTO wind { get; set; }
  }

  public class coordDTO {
    @AuraEnabled
    public Double lon { get; set; }
    @AuraEnabled
    public Double lat { get; set; }
  }

  public class weatherDTO {
    @AuraEnabled
    public Integer id { get; set; }
    @AuraEnabled
    public String main { get; set; }
    @AuraEnabled
    public String description { get; set; }
    @AuraEnabled
    public String icon { get; set; }
  }

  public class mainDTO {
    @AuraEnabled
    public Double temp { get; set; }
    @AuraEnabled
    public Double feels_like { get; set; }
    @AuraEnabled
    public Integer humidity { get; set; }
  }

  public class windDTO {
    @AuraEnabled
    public Double speed { get; set; }
  }
}
