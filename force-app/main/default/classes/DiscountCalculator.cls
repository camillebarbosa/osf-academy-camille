/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-06-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class DiscountCalculator {

    public static Decimal calculateDiscount(Decimal amount) {

        if (amount == null) {
            return 0;
        } 
        else if (amount > 100) {
            return amount * 0.9;
        } 
        else {
            return amount;
        }
    }
}