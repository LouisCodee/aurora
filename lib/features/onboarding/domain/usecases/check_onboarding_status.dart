import '../../../../core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

class CheckOnboardingStatus implements UseCase<bool, NoParams> {
  final OnboardingRepository repository;

  CheckOnboardingStatus(this.repository);

  @override
  Future<bool> call(NoParams params) {
    return repository.isOnboardingCompleted();
  }
}
