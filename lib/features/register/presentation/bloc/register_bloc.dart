import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/save_user_data.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SaveUserData saveUserData;

  RegisterBloc({required this.saveUserData}) : super(const RegisterInitial()) {
    on<SubmitRegistrationEvent>(_onSubmit);
  }

  Future<void> _onSubmit(
    SubmitRegistrationEvent event,
    Emitter<RegisterState> emit,
  ) async {
    if (event.name.trim().isEmpty || event.email.trim().isEmpty) {
      emit(const RegisterError(message: 'Name and email are required.'));
      return;
    }
    emit(const RegisterLoading());
    try {
      await saveUserData(
        UserEntity(name: event.name.trim(), email: event.email.trim()),
      );
      emit(const RegisterSuccess());
    } catch (e) {
      emit(RegisterError(message: e.toString()));
    }
  }
}
