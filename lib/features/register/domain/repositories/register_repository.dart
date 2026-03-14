import '../entities/user_entity.dart';

abstract class RegisterRepository {
  Future<void> saveUser(UserEntity user);
  Future<UserEntity?> getSavedUser();
}
