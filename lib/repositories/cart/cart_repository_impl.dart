import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../result.dart';
import 'cart_model.dart';
import 'cart_repository.dart';

const _localRepositoryKey = 'LOCAL_REPOSITORY_KEY';

class CartRepositoryImpl implements CartRepository {
  final SharedPreferences _sharedPreferences = GetIt.I<SharedPreferences>();

  @override
  Future<FResult<FCart>> fetchCart() async {
    try {
      final cartString = _sharedPreferences.getString(_localRepositoryKey);
      final cart = FCart.fromJson(cartString!);
      return FResult.success(cart);
    } catch (e) {
      return FResult.success(const FCart());
    }
  }

  @override
  Future<FResult<FCart>> setCart(FCart cart) async {
    try {
      await _sharedPreferences.setString(_localRepositoryKey, cart.toJson());
      return FResult.success(cart);
    } catch (e) {
      return FResult.error(e.runtimeType.toString());
    }
  }
}
