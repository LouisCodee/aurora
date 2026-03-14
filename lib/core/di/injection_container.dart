import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/onboarding/data/datasources/onboarding_local_datasource.dart';
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/check_onboarding_status.dart';
import '../../features/onboarding/domain/usecases/complete_onboarding.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';

import '../../features/register/data/datasources/register_local_datasource.dart';
import '../../features/register/data/repositories/register_repository_impl.dart';
import '../../features/register/domain/repositories/register_repository.dart';
import '../../features/register/domain/usecases/save_user_data.dart';
import '../../features/register/presentation/bloc/register_bloc.dart';

import '../../features/tasks/presentation/bloc/tasks_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ---------- External ----------
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // ---------- Onboarding feature ----------
  // Data sources
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(prefs: sl()),
  );

  // Repositories
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => CheckOnboardingStatus(sl()));
  sl.registerLazySingleton(() => CompleteOnboarding(sl()));

  // BLoC
  sl.registerFactory(
    () => OnboardingBloc(
      checkOnboardingStatus: sl(),
      completeOnboarding: sl(),
    ),
  );

  // ---------- Register feature ----------
  // Data sources
  sl.registerLazySingleton<RegisterLocalDataSource>(
    () => RegisterLocalDataSourceImpl(prefs: sl()),
  );

  // Repositories
  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SaveUserData(sl()));

  // BLoC
  sl.registerFactory(() => RegisterBloc(saveUserData: sl()));

  // ---------- Tasks feature ----------
  sl.registerFactory(() => TasksBloc(sl()));
}
