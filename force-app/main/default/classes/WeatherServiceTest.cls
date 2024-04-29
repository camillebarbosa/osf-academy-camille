@isTest
private class WeatherServiceTest {

    @isTest static void testGetWeatherForCity() {
        // Set up the mock response
        String mockResponse = '{"weather":[{"description":"clear sky"}],"main":{"temp":288.55},"wind":{"speed":1.5}}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(mockResponse));

        Test.startTest();
        // Call the method to test
        Weather__c result = WeatherService.getWeatherForCity('San Francisco');
        Test.stopTest();

        // Perform the test logic
        System.assertNotEquals(null, result, 'The result should not be null');
        System.assertEquals(288.55, result.Temperature__c, 'The temperature should match the mock response');
        System.assertEquals('clear sky', result.Description__c, 'The weather description should match the mock response');
        System.assertEquals(1.5, result.Wind_Speed__c, 'The wind speed should match the mock response');
    }

    // Mock class implementation
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        private final String responseBody;

        public MockHttpResponseGenerator(String mockResponseBody) {
            this.responseBody = mockResponseBody;
        }

        public HTTPResponse respond(HTTPRequest request) {
            // Create a fake response
            HttpResponse response = new HttpResponse();
            response.setBody(this.responseBody);
            response.setStatusCode(200);
            response.setStatus('OK');
            return response;
        }
    }
}
