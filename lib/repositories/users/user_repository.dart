import '../base_collection_reference.dart';
import '../result.dart';
import 'user_model.dart';

abstract class UserRepository extends BaseCollectionReference<FUser> {
  UserRepository(super.ref, {required super.getID, required super.setID});

  Future<String> getImage(String userId);

  Future<String> getName(String userId);

  Future<FResult<FUser>> getShipper();
}
