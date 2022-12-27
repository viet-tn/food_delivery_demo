import 'cart_model.dart';
import 'item_model.dart';

/// Helper extension used to mutate the items in the shopping cart.
extension MutableCart on FCart {
  /// add an item to the cart by *overriding* the quantity if it already exists
  FCart setItem(Item item) {
    final copy = Map<String, int>.from(items);
    copy[item.foodId] = item.quantity;
    return FCart(restaurantId, copy);
  }

  /// add an item to the cart by *updating* the quantity if it already exists
  FCart addItem(Item item, String restaurantId) {
    final copy = Map<String, int>.from(items);
    // * update item quantity. Read this for more details:
    // * https://codewithandrea.com/tips/dart-map-update-method/
    copy.update(
      item.foodId,
      // if there is already a value, update it by adding the item quantity
      (value) => item.quantity + value,
      // otherwise, add the item with the given quantity
      ifAbsent: () => item.quantity,
    );
    return FCart(restaurantId, copy);
  }

  /// add a list of items to the cart by *updating* the quantities of items that
  /// already exist
  FCart addItems(List<Item> itemsToAdd) {
    final copy = Map<String, int>.from(items);
    for (var item in itemsToAdd) {
      copy.update(
        item.foodId,
        // if there is already a value, update it by adding the item quantity
        (value) => item.quantity + value,
        // otherwise, add the item with the given quantity
        ifAbsent: () => item.quantity,
      );
    }
    return FCart(restaurantId, copy);
  }

  /// if an item with the given foodId is found, remove it
  FCart removeItemById(String foodId) {
    final copy = Map<String, int>.from(items);
    copy.remove(foodId);
    return FCart(restaurantId, copy);
  }
}
