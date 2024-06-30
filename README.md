# SFDC Exercise

# Pre-Requisites
Create an empty SFDX project on Visual Studio Code and make sure you are connected to a trailhead playground

# Scenario
A company wants to ensure that whenever an Account record is created or updated, the billing address is verified against an external address verification service. For the purpose of this exercise, we will simulate the verification by checking if the Billing Postal Code is in either one of 2 specific country formats: Romanian or Brazilian

# Requirements
- Create a trigger on the Account object.
- The trigger should fire before insert and before update events.
- If the Billing Postal Code is not in the correct format, add an error to the record preventing the operation.
- Assume the external service verification is a simple method that checks the format of the postal code (you can mock this).
- Extra: use regular expressions to validate the postal codes

# Instructions
- Create an Apex class named AccountAddressVerificationTest.cls and paste the contents of the AccountAddressVerificationTest.cls from this repo in it.

- Create a new Apex class named AddressVerificationService. This class should have a single method named **isPostalCodeValid**.

- Create a new Apex trigger named AccountAddressVerification which should invoke your AddressVerificationService class method.

- Deploy the code to your Org

- Using Visual Studio Code Testing Tab, run all tests

# Minimum Test Coverage: 100%
The test class AccountAddressVerificationTest.cls contains 100% test coverage if your solution is correctly implemented. You should try to achieve the 100% coverage.