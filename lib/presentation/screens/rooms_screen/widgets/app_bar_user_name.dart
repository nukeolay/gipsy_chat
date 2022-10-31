import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/presentation/screens/rooms_screen/bloc/rooms_cubit.dart';

class AppBarUserName extends StatelessWidget {
  const AppBarUserName({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context.watch<RoomsCubit>().state.user.name;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: name == ''
              ? null
              : Text(
                  name.characters.first,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Merienda',
                  ),
                ),
        ),
        const SizedBox(width: 10),
        Text(
          name,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
