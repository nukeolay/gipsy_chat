import 'package:equatable/equatable.dart';
import 'package:gipsy_chat/domain/entities/room.dart';
import 'package:gipsy_chat/domain/entities/user.dart';

enum RoomsStatus { loading, notLogined, disconnected, success, failure }

extension RoomsStatusX on RoomsStatus {
  bool get isLoading => this == RoomsStatus.loading;
  bool get isNotLogined => this == RoomsStatus.notLogined;
  bool get isDisconnected => this == RoomsStatus.disconnected;
  bool get isSuccess => this == RoomsStatus.success;
  bool get isFailure => this == RoomsStatus.failure;
}

class RoomsState extends Equatable {
  final RoomsStatus status;
  final String? errorMessage;
  final User user;
  final List<Room> rooms;

  const RoomsState({
    this.status = RoomsStatus.loading,
    this.user = const User(''),
    this.rooms = const [],
    this.errorMessage,
  });

  RoomsState copyWith({
    RoomsStatus? status,
    String? errorMessage,
    User? user,
    List<Room>? rooms,
  }) {
    return RoomsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      rooms: rooms ?? this.rooms,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, user, rooms];
}
