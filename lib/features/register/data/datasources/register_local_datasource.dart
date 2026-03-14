import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';

abstract class RegisterLocalDataSource {
  Future<void> saveUser(UserEntity user);
  Future<UserEntity?> getUser();
}

class RegisterLocalDataSourceImpl implements RegisterLocalDataSource {
  final SharedPreferences prefs;

  static const _kNameKey = 'user_name';
  static const _kEmailKey = 'user_email';

  RegisterLocalDataSourceImpl({required this.prefs});

  @override
  Future<void> saveUser(UserEntity user) async {
    await prefs.setString(_kNameKey, user.name);
    await prefs.setString(_kEmailKey, user.email);
  }

  @override
  Future<UserEntity?> getUser() async {
    final name = prefs.getString(_kNameKey);
    final email = prefs.getString(_kEmailKey);
    if (name == null || email == null) return null;
    return UserEntity(name: name, email: email);
  }
}
