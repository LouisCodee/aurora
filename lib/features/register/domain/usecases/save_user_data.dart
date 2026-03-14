import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/register_repository.dart';

class SaveUserData implements UseCase<void, UserEntity> {
  final RegisterRepository repository;

  SaveUserData(this.repository);

  @override
  Future<void> call(UserEntity params) {
    return repository.saveUser(params);
  }
}
