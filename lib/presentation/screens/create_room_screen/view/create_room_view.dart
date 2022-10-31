import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/presentation/common/widgets/error_snack_bar.dart';
import 'package:gipsy_chat/presentation/common/widgets/gipsy_elevated_button.dart';
import 'package:gipsy_chat/presentation/common/widgets/gipsy_text_field.dart';
import 'package:gipsy_chat/presentation/common/routes/routes.dart';
import 'package:gipsy_chat/presentation/screens/create_room_screen/bloc/create_room_cubit.dart';
import 'package:gipsy_chat/presentation/screens/create_room_screen/bloc/create_room_state.dart';

class CreateRoomView extends StatefulWidget {
  const CreateRoomView({super.key});

  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState extends State<CreateRoomView> {
  final _textController = TextEditingController();

  void _onCreatePressed() {
    context.read<CreateRoomCubit>().createRoom(_textController.text.trim());
  }

  void _onRoomNameChange(String roomName) {
    context.read<CreateRoomCubit>().changeRoomName(roomName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create new tabor')),
      body: SafeArea(
        child: BlocConsumer<CreateRoomCubit, CreateRoomState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              Navigator.of(context).pushReplacementNamed(
                Routes.chat,
                arguments: _textController.text.trim(),
              );
            }
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(
                context,
                state.errorMessage!,
              ));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GipsyTextField(
                    hintText: 'enter tabor name',
                    textController: _textController,
                    onChanged: _onRoomNameChange,
                  ),
                  const SizedBox(height: 25),
                  Hero(
                    tag: 'fab',
                    child: GipsyElevatedButton(
                      label: 'Create',
                      isActive: state.isButtonActive,
                      isLoading: state.status.isLoading,
                      onPressed: _onCreatePressed,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
