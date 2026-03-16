/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-16-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ArchiveOldContactsBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        Date sixMonthsAgo = Date.today().addMonths(-6);
        
        
        return Database.getQueryLocator([
            SELECT Id, Is_Archived__c 
            FROM Contact 
            WHERE Email = null 
            AND (LastModifiedDate < :sixMonthsAgo OR CreatedDate < :sixMonthsAgo)
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        for (Contact con : scope) {
            con.Is_Archived__c = true;
        }
        update scope;
    }

    public void finish(Database.BatchableContext bc) {}
}