/**
 * @description Batch class to archive contacts with no email not modified in the last 6 months.
 */
public with sharing class ArchiveOldContactsBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        DateTime sixMonthsAgo = System.now().addMonths(-6);
        
        return Database.getQueryLocator([
            SELECT Id, Is_Archived__c 
            FROM Contact 
            WHERE Email = null 
            AND LastModifiedDate < :sixMonthsAgo
        ]);
    }

    
    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        for (Contact con : scope) {
            con.Is_Archived__c = true;
        }
        update scope;
    }

   
    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Archive process completed.');
    }
}