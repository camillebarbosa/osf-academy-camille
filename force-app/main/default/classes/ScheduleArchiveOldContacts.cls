/**
 * @description Schedulable class to trigger the ArchiveOldContactsBatch.
 */
public with sharing class ScheduleArchiveOldContacts implements Schedulable {

    public void execute(SchedulableContext sc) {
        ArchiveOldContactsBatch batch = new ArchiveOldContactsBatch();
        Database.executeBatch(batch);
    }
}