import 'package:equatable/equatable.dart';

enum CreateRoomStatus { init, loading, success, failure }

extension CreateRoomStatusX on CreateRoomStatus {
  bool get isInit => this == CreateRoomStatus.init;
  bool get isLoading => this == CreateRoomStatus.loading;
  bool get isSuccess => this == CreateRoomStatus.success;
  bool get isFailure => this == CreateRoomStatus.failure;
}

class CreateRoomState extends Equatable {
  final CreateRoomStatus status;
  final bool isButtonActive;
  final String? errorMessage;

  const CreateRoomState({
    this.status = CreateRoomStatus.init,
    this.isButtonActive = false,
    this.errorMessage,
  });

  CreateRoomState copyWith({
    CreateRoomStatus? status,
    bool? isButtonActive,
    String? errorMessage,
  }) {
    return CreateRoomState(
      status: status ?? this.status,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, isButtonActive, errorMessage];
}
