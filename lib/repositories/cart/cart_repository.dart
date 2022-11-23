import '../result.dart';
import 'cart_model.dart';

abstract class CartRepository {
  Future<FResult<FCart>> fetchCart();

  Future<FResult<FCart>> setCart(FCart cart);
}
