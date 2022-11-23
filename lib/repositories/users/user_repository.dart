import '../base_collection_reference.dart';
import 'user_model.dart';

abstract class UserRepository extends BaseCollectionReference<FUser> {
  UserRepository(super.ref, {required super.getID, required super.setID});

  Future<String> getBase64ProfileImage(String userId);

  Future<String> getName(String userId);
}
