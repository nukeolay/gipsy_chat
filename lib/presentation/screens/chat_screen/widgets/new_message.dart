import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/bloc/chat_cubit.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';

  void _sendMessage() async {
    context.read<ChatCubit>().sendMessage(_enteredMessage);
    _controller.clear();
    _enteredMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'enter your gipsy message',
            ),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            color: _enteredMessage.trim().isEmpty
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                : Theme.of(context).colorScheme.primary,
          ),
          onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
        )
      ]),
    );
  }
}
