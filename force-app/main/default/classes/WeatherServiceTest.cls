@isTest
private class WeatherServiceTest {
  @isTest
  static void testGetWeatherDataSuccess() {
    // 1. Configurar o Mock para sucesso (200)
    Test.setMock(HttpCalloutMock.class, new WeatherServiceMock(200));

    Test.startTest();
    WeatherService.WeatherResponseWrapper result = WeatherService.getWeatherData(
      'Sao Paulo'
    );
    Test.stopTest();

    // 2. Validações (Asserts)
    System.assertNotEquals(null, result, 'O resultado não deveria ser nulo');
    System.assertEquals(
      75.5,
      result.main.temp,
      'A temperatura deve corresponder ao Mock'
    );
    System.assertEquals(
      'céu limpo',
      result.weather[0].description,
      'A descrição deve corresponder ao Mock'
    );
    System.assertEquals(-46.6, result.coord.lon);
    System.assertEquals(10.2, result.wind.speed);
  }

  @isTest
  static void testGetWeatherDataFailure() {
    // 1. Configurar o Mock para erro (404)
    Test.setMock(HttpCalloutMock.class, new WeatherServiceMock(404));

    Test.startTest();
    try {
      WeatherService.getWeatherData('CidadeInexistente');
      System.assert(false, 'Uma exceção deveria ter sido lançada');
    } catch (AuraHandledException e) {
      // No teste, o getMessage() de uma AuraHandledException
      // geralmente retorna "Script-thrown exception".
      // Apenas confirmamos que a exceção chegou aqui.
      System.assertNotEquals(
        null,
        e.getMessage(),
        'A exceção deve conter uma mensagem'
      );
    }
    Test.stopTest();
  }

  @isTest
  static void testGetWeatherDataEmptyCity() {
    // Teste de borda para garantir que caracteres especiais ou espaços funcionem (EncodingUtil)
    Test.setMock(HttpCalloutMock.class, new WeatherServiceMock(200));

    Test.startTest();
    WeatherService.WeatherResponseWrapper result = WeatherService.getWeatherData(
      'New York'
    );
    Test.stopTest();

    System.assertNotEquals(null, result);
  }
}
