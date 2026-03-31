@isTest
global class WeatherServiceMock implements HttpCalloutMock {
  private Integer statusCode;

  // Construtor para definir se queremos simular sucesso (200) ou erro (ex: 404)
  global WeatherServiceMock(Integer statusCode) {
    this.statusCode = statusCode;
  }

  global HTTPResponse respond(HTTPRequest req) {
    HttpResponse res = new HttpResponse();
    res.setHeader('Content-Type', 'application/json');
    res.setStatusCode(statusCode);

    if (statusCode == 200) {
      // JSON simulando a estrutura do seu WeatherResponseWrapper
      res.setBody(
        '{"coord":{"lon":-46.6,"lat":-23.5}, "weather":[{"id":800,"main":"Clear","description":"céu limpo","icon":"01d"}], "main":{"temp":75.5,"feels_like":74.0,"humidity":60}, "wind":{"speed":10.2}}'
      );
    } else {
      res.setBody('{"cod": "404", "message": "city not found"}');
    }
    return res;
  }
}
