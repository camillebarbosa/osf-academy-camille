/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-06-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class DiscountCalculator {

    public static Decimal calculateDiscount(Decimal amount, String discountCode) {

        if (amount == null) {
            return null;
        }

        Decimal finalAmount = amount;

        if (amount < 100) {
            finalAmount = amount;
        }
        else if (amount >= 100 && amount <= 200) {
            finalAmount = amount * 0.9;
        }
        else if (amount > 200 && amount < 500) {
            finalAmount = amount * 0.85;
        }
        else if (amount >= 500) {
            finalAmount = amount * 0.8;
        }

        if (discountCode == 'OSF5') {
            finalAmount = finalAmount * 0.95;
        }

        return finalAmount;
    }
}