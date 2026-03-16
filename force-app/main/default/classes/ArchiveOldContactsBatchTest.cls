/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-16-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class ArchiveOldContactsBatchTest {

    @isTest static void testBatchProcess(){
        
        Contact testContact = new Contact(LastName = 'Testerson', Email = null);
        insert testContact;
        
        
        Test.setCreatedDate(testContact.Id, Date.today().addMonths(-7));
        
       
        Database.emptyRecycleBin(new List<Contact>{testContact});
        
       
        Test.startTest();
        Database.executeBatch(new ArchiveOldContactsBatch());
        Test.stopTest();
        
       
        testContact = [SELECT Id, Is_Archived__c FROM Contact WHERE Id = :testContact.Id];
        System.assert(testContact.Is_Archived__c, 'The Is_Archived__c field should be true');
    }
}
