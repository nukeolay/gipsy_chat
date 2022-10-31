import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/repositories/chat_repository.dart';
import 'package:gipsy_chat/domain/repositories/rooms_repository.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/create_room_screen/bloc/create_room_cubit.dart';
import 'package:gipsy_chat/presentation/screens/create_room_screen/view/create_room_view.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateRoomCubit(
        userRepository: context.read<UserRepository>(),
        chatRepository: context.read<ChatRepository>(),
        roomsRepository: context.read<RoomsRepository>(),
      ),
      child: const CreateRoomView(),
    );
  }
}
