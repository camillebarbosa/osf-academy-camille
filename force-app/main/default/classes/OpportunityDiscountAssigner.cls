/**
 * @description Service class to apply discounts to Opportunities based on their Stage.
 */
public with sharing class OpportunityDiscountAssigner {
    
    /**
     * @description Iterates through opportunities and applies discounts to the Amount field.
     * @param oppList List of Opportunities from the trigger (Trigger.new).
     */
    public static void applyStageDiscounts(List<Opportunity> oppList) {
        for (Opportunity opp : oppList) {
           
            if (opp.Amount != null) {
                
                Decimal discountRate = 0;

                switch on opp.StageName {
                    when 'Prospecting' {
                        discountRate = 0.05; // 5%
                    }
                    when 'Qualification' {
                        discountRate = 0.10; // 10%
                    }
                    when 'Negotiation/Review' {
                        discountRate = 0.15; // 15%
                    }
                    when else {
                        discountRate = 0; // No discount
                    }
                }

                
                if (discountRate > 0) {
                    opp.Amount = opp.Amount * (1 - discountRate);
                }
            }
        }
    }
}