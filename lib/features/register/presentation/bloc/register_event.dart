import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class SubmitRegistrationEvent extends RegisterEvent {
  final String name;
  final String email;

  const SubmitRegistrationEvent({required this.name, required this.email});

  @override
  List<Object?> get props => [name, email];
}
