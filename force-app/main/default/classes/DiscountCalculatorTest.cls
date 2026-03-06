/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-06-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class DiscountCalculatorTest {

    @isTest static void testCalculateDiscount() {

        // Test amount with no discount
        Decimal noDiscountAmount = DiscountCalculator.calculateDiscount(50);
        System.assertEquals(50, noDiscountAmount);

        // Test amount with discount
        Decimal discountAmount = DiscountCalculator.calculateDiscount(200);
        System.assertEquals(180, discountAmount);

        // Test null amount
        Decimal nullAmount = DiscountCalculator.calculateDiscount(null);
        System.assertEquals(0, nullAmount);
    }
}