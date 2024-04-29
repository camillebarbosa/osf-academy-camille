import { createElement } from 'lwc';
import WeatherApp from 'c/weatherApp';
import getWeatherForCity from '@salesforce/apex/WeatherService.getWeatherForCity';

function flushPromises() {
    // eslint-disable-next-line @lwc/lwc/no-async-operation
    return new Promise((resolve) => setTimeout(resolve, 0));
}



// Mocking the getWeatherForCity Apex call
jest.mock(
  '@salesforce/apex/WeatherService.getWeatherForCity',
  () => {
    return {
      default: jest.fn()
    };
  },
  { virtual: true }
);

describe('c-weather-app', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
        // Clearing any mock calls
        jest.clearAllMocks();
    });

    it('gets weather data correctly', async () => {
        // Arrange
        const ELEMENT = createElement('c-weather-app', {
            is: WeatherApp
        });
        document.body.appendChild(ELEMENT);
    
        // Mock the Apex method response
        getWeatherForCity.mockResolvedValue({
            Temperature__c: 285,
            Description__c: 'Partly cloudy',
            Wind_Speed__c: 5
        });
    
        // Act - simulate entering the city name and clicking the button
        const inputElement = ELEMENT.shadowRoot.querySelector('lightning-input');
        inputElement.value = 'San Francisco';
        inputElement.dispatchEvent(new CustomEvent('change'));
    
        const buttonElement = ELEMENT.shadowRoot.querySelector('lightning-button');
        buttonElement.click();
    
        // Flush any pending promises (wait for them to resolve)
        await flushPromises();
    
        // Re-query the DOM for rendered elements after promises have resolved
        const temperatureElement = ELEMENT.shadowRoot.querySelector('p:nth-of-type(1)');
        const descriptionElement = ELEMENT.shadowRoot.querySelector('p:nth-of-type(2)');
        const windSpeedElement = ELEMENT.shadowRoot.querySelector('p:nth-of-type(3)');
    
        // Assert - check if the values are displayed correctly
        expect(temperatureElement.textContent).toContain('285 K');
        expect(descriptionElement.textContent).toContain('Partly cloudy');
        expect(windSpeedElement.textContent).toContain('5 m/s');
    });
    
    // Include the previously defined flushPromises function here

    it('shows error message when getWeatherForCity Apex call fails', async () => {
        // Arrange
        const ELEMENT = createElement('c-weather-app', {
            is: WeatherApp
        });
        document.body.appendChild(ELEMENT);

        // Setup the mock function to reject the promise
        getWeatherForCity.mockRejectedValue({
            message: 'No data available', // Simulate error message property
            body: {
                message: 'No data available' // Mock might need different properties based on how your component handles errors
            }
        });

        // Act
        const inputElement = ELEMENT.shadowRoot.querySelector('lightning-input');
        inputElement.value = 'Invalid City';
        inputElement.dispatchEvent(new CustomEvent('change'));

        ELEMENT.shadowRoot.querySelector('lightning-button').click();

        // Flush any pending promises (wait for them to resolve)
        await flushPromises();

        // Query the DOM for the error element
        const errorElement = ELEMENT.shadowRoot.querySelector('.slds-text-color_error');

        // Assert
        console.log(JSON.stringify(errorElement.textContent))
        expect(errorElement).not.toBeNull();
        expect(errorElement.textContent).toContain('No data available');
        });
});
