@isTest
private class DiscountCalculatorTest {
    @isTest static void testCalculateDiscount() {
        DiscountCalculator calculator = new DiscountCalculator();

        // Test amount with no discount
        Decimal noDiscountAmount = calculator.calculateDiscount(50);
        System.assertEquals(50, noDiscountAmount);

        // Test amount with discount
        Decimal discountAmount = calculator.calculateDiscount(200);
        System.assertEquals(180, discountAmount);

        // Test null amount
        Decimal nullAmount = calculator.calculateDiscount(null);
        System.assertEquals(0, nullAmount);
    }
}
