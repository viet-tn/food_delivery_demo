import '../result.dart';
import 'favorite_list_model.dart';

abstract class FavoriteListRepository {
  Future<FResult<FFavoriteList>> fetchFavoriteList(String uid);
  Future<FResult<FFavoriteList>> setFavoriteList(FFavoriteList list);
}
