import 'package:cloud_firestore/cloud_firestore.dart';

import '../base_collection_reference.dart';
import '../result.dart';
import 'favorite_list_model.dart';
import 'favorite_list_repository.dart';

class FavoriteListRepositoryImpl extends BaseCollectionReference<FFavoriteList>
    implements FavoriteListRepository {
  FavoriteListRepositoryImpl()
      : super(
          FirebaseFirestore.instance
              .collection("favoriteList/")
              .withConverter<FFavoriteList>(
                fromFirestore: (snapshot, _) =>
                    FFavoriteList.fromMap(snapshot.data()!),
                toFirestore: (value, _) => value.toMap(),
              ),
          getID: (favorite) => favorite.id,
          setID: (favorite, id) => favorite.copyWith(id: id),
        );

  @override
  Future<FResult<FFavoriteList>> fetchFavoriteList(String id) async {
    final result = await get(id);

    if (result.isError) {
      return await set(FFavoriteList(id));
    }

    return FResult.success(result.data!);
  }

  @override
  Future<FResult<FFavoriteList>> setFavoriteList(FFavoriteList list) {
    return set(list, merge: false);
  }
}
