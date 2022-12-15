import 'package:cloud_firestore/cloud_firestore.dart';
import '../result.dart';

import 'user_model.dart';
import 'user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl()
      : super(
          FirebaseFirestore.instance.collection("users").withConverter<FUser>(
                fromFirestore: (snapshot, _) => FUser.fromMap(snapshot.data()!),
                toFirestore: (value, _) => value.toMap(),
              ),
          getID: (user) => user.id,
          setID: (user, id) => user.copyWith(id: id),
        );

  @override
  Future<String> getImage(String userId) async {
    final user = await ref.doc(userId).get();
    return user.data()!.photo ?? '';
  }

  @override
  Future<String> getName(String userId) async {
    final querySnapshot = await ref.where('id', isEqualTo: userId).get();
    final user = querySnapshot.docs.first.data();
    return '${user.firstName!} ${user.lastName!}';
  }

  @override
  Future<FResult<FUser>> getShipper() async {
    // simulate get shipper
    const shipperId = 'XjuKAeSNkYNj5DhKINiOUapq0Rl2';
    return get(shipperId);
  }
}
