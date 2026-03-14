import '../../data/datasources/register_local_datasource.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterLocalDataSource localDataSource;

  RegisterRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveUser(UserEntity user) => localDataSource.saveUser(user);

  @override
  Future<UserEntity?> getSavedUser() => localDataSource.getUser();
}
