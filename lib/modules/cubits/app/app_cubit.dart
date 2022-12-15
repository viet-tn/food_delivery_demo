import '../../../repositories/maps/search/places_search_repository.dart';

import '../../order/data/order_repository.dart';
import '../../../repositories/restaurants/restaurant_repository.dart';
import '../../../repositories/result.dart';

import '../../order/model/order.dart';
import '../../../repositories/restaurants/restaurant_model.dart';
import 'package:get_it/get_it.dart';

import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/cloud_storage/cloud_storage.dart';
import '../../../repositories/users/user_model.dart';
import '../../../repositories/users/user_repository.dart';
import '../../home/cubit/home_cubit.dart';
import '../../login/cubit/login_cubit.dart';
import '../../signup/cubit/sign_up_cubit.dart';

part 'app_state.dart';

class AppCubit extends FCubit<AppState> {
  AppCubit({
    required CloudStorage cloudStorage,
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required RestaurantRepository restaurantRepository,
    required PlacesSearchRepository placesSearchRepository,
  })  : _cloudStorage = cloudStorage,
        _userRepository = userRepository,
        _authRepository = authRepository,
        _restaurantRepository = restaurantRepository,
        _placesSearchRepository = placesSearchRepository,
        super(const AppState());

  final CloudStorage _cloudStorage;
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final RestaurantRepository _restaurantRepository;
  final PlacesSearchRepository _placesSearchRepository;

  void init(FUser user) async {
    emitValue(state.copyWith(user: user));
    if (user.coordinates.isEmpty) return;
    GetIt.I<HomeCubit>().init(
        user.coordinates.first.latitude, user.coordinates.first.longitude);

    final result = await GetIt.I<OrderRepository>()
        .fetchOrdersByStatus(OrderStatus.processing);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    if (result.data!.isEmpty) return;

    final order = result.data!.first;
    getProcessingOrderInfo(order);
  }

  Future<void> signOut() async {
    emitLoading();
    await _authRepository.signOut();
    emit(const AppState());
    GetIt.I<SignUpCubit>().emit(const SignUpState());
    GetIt.I<LoginCubit>().emit(
      GetIt.I<LoginCubit>().state.copyWith(user: FUser.empty),
    );
  }

  void updateUserState(FUser user) {
    emitValue(state.copyWith(user: user));
  }

  Future<void> updateUserToDatabase([String? imgUrl]) async {
    emitLoading();
    FUser? update;

    if (imgUrl != null) {
      update = state.user!.copyWith(
        photo: await _cloudStorage.uploadAvatar(state.user!.id, imgUrl),
      );
    }
    final result = await _userRepository.set(update ?? state.user!);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(state.copyWith(user: result.data!));
  }

  void deleteUserFromDatabase() {
    _authRepository.deleteUser().then((value) {
      if (value.isError) {
        emitError(value.error!);
        return;
      }
      signOut();
    });
    if (!state.status.hasError) {
      _userRepository.delete(state.user!.id);
    }
  }

  void changePassword(String currentPassword, String newPassword) async {
    emitLoading();
    final result =
        await _authRepository.changePassword(currentPassword, newPassword);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue();
  }

  FOrder onOrderDelivered() {
    return _onOrderStatusChanged(OrderStatus.delivered);
  }

  void onOrderCanceled() {
    _onOrderStatusChanged(OrderStatus.cancelled);
  }

  FOrder _onOrderStatusChanged(OrderStatus status) {
    final update = state.order!.copyWith(status: status);
    emitValue(
      state.copyWith(
        order: update,
      ),
    );
    return update;
  }

  void getProcessingOrderInfo(FOrder order) async {
    List<FResult<dynamic>> results = await Future.wait([
      _restaurantRepository.getByFoodId(order.cart.items.keys.first),
      _userRepository.getShipper(),
    ]);

    final restaurantResult = results[0] as FResult<FRestaurant>;
    final shipperResult = results[1] as FResult<FUser>;

    if (restaurantResult.isError) {
      emitError(results[0].error!);
      return;
    }

    if (shipperResult.isError) {
      emitError(results[1].error!);
      return;
    }

    final deliveryTime = await _placesSearchRepository.calculateDistance(
      restaurantResult.data!.coordinate.latitude,
      restaurantResult.data!.coordinate.longitude,
      order.userPosition.latitude,
      order.userPosition.longitude,
    );

    emitValue(
      state.copyWith(
        order: order,
        restaurant: restaurantResult.data!,
        shipper: shipperResult.data!,
        deliveryTime: deliveryTime[1],
      ),
    );
  }
}
