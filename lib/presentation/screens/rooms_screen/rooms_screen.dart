import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/repositories/chat_repository.dart';
import 'package:gipsy_chat/domain/repositories/rooms_repository.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/rooms_screen/bloc/rooms_cubit.dart';
import 'package:gipsy_chat/presentation/screens/rooms_screen/view/rooms_view.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomsCubit(
        userRepository: context.read<UserRepository>(),
        roomsRepository: context.read<RoomsRepository>(),
        chatRepository: context.read<ChatRepository>(),
      )..init(),
      child: const RoomsView(),
    );
  }
}
