/**
 * @description       : Manages a simple inventory of items using a private inner class.
 * @author            : Gemini
 * @last modified on  : 03-09-2026
**/
public class InventoryManager {

    // Map to store items where the key is the item name (lowercase for consistency)
    private Map<String, Item> inventoryMap = new Map<String, Item>();

    // Private inner class as required
    private class Item {
        public String name;
        public Integer quantity;

        public Item(String name, Integer quantity) {
            this.name = name;
            this.quantity = quantity;
        }
    }

    /**
     * @description Adds quantity to an existing item or creates a new one.
     */
    public void addItem(String itemName, Integer quantity) {
        if (itemName == null || quantity == null) {
            return;
        }

        if (inventoryMap.containsKey(itemName)) {
            inventoryMap.get(itemName).quantity += quantity;
        } else {
            inventoryMap.put(itemName, new Item(itemName, quantity));
        }
    }

    /**
     * @description Removes quantity from an item. Sets to 0 if removal exceeds stock.
     */
    public void removeItem(String itemName, Integer quantity) {
        if (itemName == null || quantity == null || !inventoryMap.containsKey(itemName)) {
            return;
        }

        Item currentItem = inventoryMap.get(itemName);
        currentItem.quantity -= quantity;

        if (currentItem.quantity < 0) {
            currentItem.quantity = 0;
        }
    }

    /**
     * @description Returns the current quantity of a specific item.
     */
    public Integer getQuantity(String itemName) {
        if (itemName == null || !inventoryMap.containsKey(itemName)) {
            return null;
        }
        return inventoryMap.get(itemName).quantity;
    }
}