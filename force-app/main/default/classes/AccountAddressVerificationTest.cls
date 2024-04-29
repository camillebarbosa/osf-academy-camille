@isTest
private class AccountAddressVerificationTest {
    
    @isTest
    static void testValidRomanianPostalCode() {
        // Setup test data
        Account acc = new Account(Name = 'Test Account RO', BillingPostalCode = '123456');
        
        // Perform test
        Test.startTest();
        insert acc;
        Test.stopTest();
        
        // Verify results
        Account result = [SELECT BillingPostalCode FROM Account WHERE Id = :acc.Id];
        System.assertEquals('123456', result.BillingPostalCode);
    }
    
    @isTest
    static void testValidBrazilianPostalCode() {
        // Setup test data with hyphen
        Account accWithHyphen = new Account(Name = 'Test Account BR', BillingPostalCode = '12345-678');
        // Setup test data without hyphen
        Account accWithoutHyphen = new Account(Name = 'Test Account BR', BillingPostalCode = '12345678');
        
        // Perform test with hyphen
        Test.startTest();
        insert accWithHyphen;
        // Test.stopTest();
        
        // // Perform test without hyphen
        // Test.startTest();
        insert accWithoutHyphen;
        Test.stopTest();
        
        // Verify results with hyphen
        Account resultWithHyphen = [SELECT BillingPostalCode FROM Account WHERE Id = :accWithHyphen.Id];
        System.assertEquals('12345-678', resultWithHyphen.BillingPostalCode);
        
        // Verify results without hyphen
        Account resultWithoutHyphen = [SELECT BillingPostalCode FROM Account WHERE Id = :accWithoutHyphen.Id];
        System.assertEquals('12345678', resultWithoutHyphen.BillingPostalCode);
    }
    
    @isTest
    static void testInvalidPostalCode() {
        // Setup test data with an invalid postal code
        Account acc = new Account(Name = 'Test Account Invalid', BillingPostalCode = 'ABCDE');
        
        // Perform test and expect an error
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
        
        // Verify that an error was thrown
        System.assert(errorThrown, 'An error should have been thrown for the invalid postal code.');
    }
}
