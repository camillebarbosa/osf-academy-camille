/**
 * @description Trigger on Opportunity to handle automation before record commit.
 */
trigger OpportunityTrigger on Opportunity (before insert, before update) {
    OpportunityDiscountAssigner.applyStageDiscounts(Trigger.new);
}