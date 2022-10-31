import 'package:equatable/equatable.dart';

enum LoginStatus { init, loading, success, failure }

extension LoginStatusX on LoginStatus {
  bool get isInit => this == LoginStatus.init;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isFailure => this == LoginStatus.failure;
}

class LoginState extends Equatable {
  final LoginStatus status;
  final bool isButtonActive;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.init,
    this.isButtonActive = false,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStatus? status,
    bool? isButtonActive,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, isButtonActive, errorMessage];
}
