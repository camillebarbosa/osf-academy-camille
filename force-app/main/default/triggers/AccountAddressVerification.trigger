/**
 * @description Trigger to validate Account Billing Postal Code before saving.
 */
trigger AccountAddressVerification on Account (before insert, before update) {
    
    for (Account acc : Trigger.new) {
        // We only validate if the postal code is provided or changed
        if (!AccountAddressService.isValidPostalCode(acc.BillingPostalCode)) {
            acc.BillingPostalCode.addError('The Billing Postal Code is not in the correct format.');
        }
    }
}