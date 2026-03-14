import '../../../../features/onboarding/data/datasources/onboarding_local_datasource.dart';
import '../../../../features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<bool> isOnboardingCompleted() => localDataSource.isOnboardingCompleted();

  @override
  Future<void> completeOnboarding() => localDataSource.setOnboardingCompleted();
}
