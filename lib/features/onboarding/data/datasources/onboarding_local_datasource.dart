import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  /// Returns true if the user has completed onboarding
  Future<bool> isOnboardingCompleted();

  /// Marks onboarding as completed in local storage
  Future<void> setOnboardingCompleted();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences prefs;

  static const _kOnboardingKey = 'onboarding_completed';

  OnboardingLocalDataSourceImpl({required this.prefs});

  @override
  Future<bool> isOnboardingCompleted() async {
    return prefs.getBool(_kOnboardingKey) ?? false;
  }

  @override
  Future<void> setOnboardingCompleted() async {
    await prefs.setBool(_kOnboardingKey, true);
  }
}
