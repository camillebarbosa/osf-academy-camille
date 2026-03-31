/**
 * @description Service class to handle Address and Postal Code logic.
 */
public with sharing class AccountAddressService {
    
    /**
     * @description Validates if the postal code matches Brazilian or Romanian formats.
     * @param postalCode The string to validate.
     * @return Boolean true if valid, false otherwise.
     */
    public static Boolean isValidPostalCode(String postalCode) {
        if (String.isBlank(postalCode)) {
            return false;
        }

        
        String romaniaPattern = '^[0-9]{6}$';
        String brazilHyphenPattern = '^[0-9]{5}-[0-9]{3}$';
        String brazilNoHyphenPattern = '^[0-9]{8}$';

        return Pattern.matches(romaniaPattern, postalCode) || 
               Pattern.matches(brazilHyphenPattern, postalCode) || 
               Pattern.matches(brazilNoHyphenPattern, postalCode);
    }
}