# Pre-Requisites

# Scenario
A company wants to ensure that discounts are automatically applied to Opportunities based on their sales stage. This helps in maintaining consistent pricing strategies throughout the sales process. The discount rates vary depending on the stage of the Opportunity.

# Requirements
- Create a trigger on the Opportunity object.
- The trigger should fire before the insert event.
- Apply discounts based on the Opportunity's stage:
    - Prospecting: 5% discount
    - Qualification: 10% discount
    - Negotiation/Review: 15% discount
    - Other Stages: No discount
- Implement the discount logic in a separate Apex class for better maintainability.

# Instructions
- **Create an Apex Class**:
    - Name it OpportunityDiscountAssigner.
    - Implement a method to apply discounts based on the Opportunity stage.

- **Create an Apex Trigger**:
    - Name it OpportunityTrigger.
    - The trigger should invoke the discount logic from the OpportunityDiscountAssigner class before inserting an Opportunity.

- **Testing**:
    - Use the provided test class OpportunityDiscountAssignerTest to ensure all scenarios are covered.
    - Achieve a minimum test coverage of 100% by running all tests using the Salesforce Developer Console or Visual Studio Code.