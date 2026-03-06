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

        // No discount (<100)
        Decimal noDiscountAmount = DiscountCalculator.calculateDiscount(50, null);
        System.assertEquals(50, noDiscountAmount);

        // 10% discount (100–200)
        Decimal discount10 = DiscountCalculator.calculateDiscount(200, null);
        System.assertEquals(180, discount10);

        // 15% discount (>200 <500)
        Decimal discount15 = DiscountCalculator.calculateDiscount(300, null);
        System.assertEquals(255, discount15);

        // 20% discount (>=500)
        Decimal discount20 = DiscountCalculator.calculateDiscount(500, null);
        System.assertEquals(400, discount20);

        // Additional 5% code
        Decimal extraCodeDiscount = DiscountCalculator.calculateDiscount(200, 'OSF5');
        System.assertEquals(171, extraCodeDiscount);

        // Null amount
        Decimal nullAmount = DiscountCalculator.calculateDiscount(null, null);
        System.assertEquals(null, nullAmount);
    }
}