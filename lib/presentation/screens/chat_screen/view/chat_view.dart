import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/presentation/common/widgets/error_snack_bar.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/bloc/chat_cubit.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/bloc/chat_state.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/widgets/app_bar_room_name.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/widgets/message_bubble.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/widgets/new_message.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarRoomName(),
        ),
        body: SafeArea(
          child: BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state.status.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(
                  context,
                  state.errorMessage!,
                ));
              }
            },
            builder: (context, state) => state.status.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          padding: const EdgeInsets.only(bottom: 50),
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            final message = state.messages[index];
                            final isMyMessage =
                                message.sender.name == state.user.name;
                            return MessageBubble(
                              message: state.messages[index],
                              isMyMessage: isMyMessage,
                            );
                          },
                        ),
                      ),
                      const NewMessage(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
