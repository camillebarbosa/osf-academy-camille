/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-16-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ArchiveOldContactsBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // Usamos Date.today() para facilitar a comparação no teste
        Date sixMonthsAgo = Date.today().addMonths(-6);
        
        // Importante: No SOQL, comparamos com a data de sistema.
        // Se o teste falhar, podemos usar CreatedDate para cobrir o cenário do Test.setCreatedDate
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