import '../../../../core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

class CompleteOnboarding implements UseCase<void, NoParams> {
  final OnboardingRepository repository;

  CompleteOnboarding(this.repository);

  @override
  Future<void> call(NoParams params) {
    return repository.completeOnboarding();
  }
}
