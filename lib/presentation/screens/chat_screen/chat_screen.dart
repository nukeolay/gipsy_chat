import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/repositories/chat_repository.dart';
import 'package:gipsy_chat/domain/repositories/rooms_repository.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/bloc/chat_cubit.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/view/chat_view.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roomName = ModalRoute.of(context)!.settings.arguments as String;

    return BlocProvider(
      create: (context) => ChatCubit(
        userRepository: context.read<UserRepository>(),
        roomsRepository: context.read<RoomsRepository>(),
        chatRepository: context.read<ChatRepository>(),
      )..init(roomName),
      child: const ChatView(),
    );
  }
}
