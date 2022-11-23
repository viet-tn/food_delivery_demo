import 'auth/auth_repository.dart';
import 'auth/firebase_auth_repository.dart';
import 'cart/cart_repository.dart';
import 'cart/cart_repository_impl.dart';
import 'chat/chat_repository.dart';
import 'chat/chat_repository_impl.dart';
import 'chat/messages/message_repository.dart';
import 'chat/messages/message_repository_impl.dart';
import 'cloud_storage/cloud_storage.dart';
import 'cloud_storage/firebase_cloud_storage.dart';
import 'favorite/favorite_list_repository.dart';
import 'favorite/favorite_list_repository_impl.dart';
import 'food/food_repository.dart';
import 'food/food_repository_impl.dart';
import 'restaurants/restaurant_repository.dart';
import 'restaurants/restaurant_repository_impl.dart';
import 'search/algolia_search_repository.dart';
import 'search/search_repository.dart';
import 'users/user_repository.dart';
import 'users/user_repository_impl.dart';

class DomainManager {
  DomainManager._() {
    authRepository = const FirebaseAuthRepository();
    userRepository = UserRepositoryImpl();
    restaurantRepository = RestaurantRepositoryImpl();
    foodRepository = FoodRepositoryImpl();
    cartRepository = CartRepositoryImpl();
    favoriteListRepository = FavoriteListRepositoryImpl();
    chatRepository = ChatRepositoryImpl();
    messageRepository = MessageRepositoryImpl();
    searchRepository = AlgoliaSearchRepository();
    cloudStorage = const FirebaseCloudStorage();
  }
  static final DomainManager _instance = DomainManager._();

  factory DomainManager() {
    return _instance;
  }

  late AuthRepository authRepository;
  late UserRepository userRepository;
  late RestaurantRepository restaurantRepository;
  late FoodRepository foodRepository;
  late CartRepository cartRepository;
  late FavoriteListRepository favoriteListRepository;
  late ChatRepository chatRepository;
  late MessageRepository messageRepository;
  late SearchRepository searchRepository;
  late CloudStorage cloudStorage;
}
