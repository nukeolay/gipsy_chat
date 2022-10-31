import 'package:equatable/equatable.dart';

enum SplashStatus { loading, notLogined, success, failure }

extension SplashStatusX on SplashStatus {
  bool get isLoading => this == SplashStatus.loading;
  bool get isNotLogined => this == SplashStatus.notLogined;
  bool get isSuccess => this == SplashStatus.success;
  bool get isFailure => this == SplashStatus.failure;
}

class SplashState extends Equatable {
  final SplashStatus status;
  final String? errorMessage;

  const SplashState({
    this.status = SplashStatus.loading,
    this.errorMessage,
  });

  SplashState copyWith({
    SplashStatus? status,
    String? errorMessage,
  }) {
    return SplashState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
