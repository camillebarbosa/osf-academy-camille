/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-07-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class InventoryManagerTest {

    @isTest static void testAddingNewItem() {
        InventoryManager manager = new InventoryManager();
        manager.addItem('Laptop', 5);
        System.assertEquals(5, manager.getQuantity('Laptop'), 'The quantity of Laptops should be 5 after adding.');
    }

    @isTest static void testAddingToExistingItem() {
        InventoryManager manager = new InventoryManager();
        manager.addItem('Laptop', 3);
        manager.addItem('Laptop', 2);
        System.assertEquals(5, manager.getQuantity('Laptop'), 'The quantity of Laptops should be 5 after adding more.');
    }

    @isTest static void testRemovingItem() {
        InventoryManager manager = new InventoryManager();
        manager.addItem('Laptop', 5);
        manager.removeItem('Laptop', 2);
        System.assertEquals(3, manager.getQuantity('Laptop'), 'The quantity of Laptops should be 3 after removing some.');
    }

    @isTest static void testRemovingMoreThanCurrentQuantity() {
        InventoryManager manager = new InventoryManager();
        manager.addItem('Mouse', 10);
        manager.removeItem('Mouse', 15);
        System.assertEquals(0, manager.getQuantity('Mouse'), 'The quantity of Mice should be 0 after removing more than the current quantity.');
    }

    @isTest static void testAddingWithNullName() {
        InventoryManager manager = new InventoryManager();
        manager.addItem(null, 1);
        System.assertEquals(null, manager.getQuantity(null), 'Adding an item with null name should not change the inventory.');
    }

    @isTest static void testRemovingWithNullName() {
        InventoryManager manager = new InventoryManager();
        manager.removeItem(null, 1);
        System.assertEquals(null, manager.getQuantity(null), 'Removing an item with null name should not change the inventory.');
    }

    @isTest static void testGettingQuantityWithNullName() {
        InventoryManager manager = new InventoryManager();
        System.assertEquals(null, manager.getQuantity(null), 'Getting the quantity of an item with null name should return null.');
    }
}
