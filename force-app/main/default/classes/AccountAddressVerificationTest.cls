@isTest
private class AccountAddressVerificationTest {
    
    // Utility method to create a test Account with a specified postal code
    private static Account createTestAccount(String postalCode) {
        return new Account(Name = 'Test Account', BillingPostalCode = postalCode);
    }

    @isTest
    static void testValidRomanianPostalCode() {
        Account acc = createTestAccount('123456');
        Test.startTest();
        insert acc;
        Test.stopTest();
        Account result = [SELECT BillingPostalCode FROM Account WHERE Id = :acc.Id];
        System.assert(result.BillingPostalCode == '123456', 'The Billing Postal Code should be valid for Romanian format.');
    }
    
    @isTest
    static void testValidBrazilianPostalCodeWithHyphen() {
        Account acc = createTestAccount('12345-678');
        Account accWithHyphen = new Account(Name = 'Test Account BR With Hyphen', BillingPostalCode = '12345-678');
        Test.startTest();
        insert accWithHyphen;
        Test.stopTest();
        Account resultWithHyphen = [SELECT BillingPostalCode FROM Account WHERE Id = :accWithHyphen.Id];
        System.assert(resultWithHyphen.BillingPostalCode == '12345-678', 'The Billing Postal Code should be valid with a hyphen for Brazilian format.');
    }
    
    @isTest
    static void testValidBrazilianPostalCodeWithoutHyphen() {
        Account acc = createTestAccount('12345678');
        Test.startTest();
        insert acc;
        Test.stopTest();
        Account resultWithoutHyphen = [SELECT BillingPostalCode FROM Account WHERE Id = :acc.Id];
        System.assert(resultWithoutHyphen.BillingPostalCode == '12345678', 'The Billing Postal Code should be valid without a hyphen for Brazilian format.');
    }
    
    @isTest
    static void testInvalidPostalCode() {
        Account acc = createTestAccount('ABCDE');
        Boolean errorThrown = false;
        try {
            Test.startTest();
            insert acc;
            Test.stopTest();
        } catch (DmlException e) {
            errorThrown = true;
            String expectedError = 'The Billing Postal Code is invalid';
            System.assert(e.getMessage().contains(expectedError), 'Expected error message to contain: ' + expectedError);
        }
        System.assert(errorThrown, 'An error should have been thrown for the invalid postal code.');
    }

    @isTest
    static void testNullPostalCode() {
        Account acc = createTestAccount(null);
        Exception caughtException = null;
        Test.startTest();
        try {
            insert acc;
        } catch (DmlException e) {
            caughtException = e;
        }
        Test.stopTest();
        System.assertNotEquals(null, caughtException, 'An exception should have been thrown for the null postal code.');
        System.assert(caughtException.getMessage().contains('The Billing Postal Code is invalid'), 'The error message should indicate the null postal code.');
    }
}
