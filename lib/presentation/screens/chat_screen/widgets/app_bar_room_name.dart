import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/bloc/chat_cubit.dart';

class AppBarRoomName extends StatelessWidget {
  const AppBarRoomName({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context.watch<ChatCubit>().state.room.name;
    return Text(name, overflow: TextOverflow.ellipsis);
  }
}
