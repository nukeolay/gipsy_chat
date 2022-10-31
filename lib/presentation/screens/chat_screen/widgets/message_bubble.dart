import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gipsy_chat/domain/entities/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMyMessage;
  const MessageBubble({
    required this.message,
    required this.isMyMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final maximumBubbleWidth = MediaQuery.of(context).size.width * 0.8;
    final tileColor = isMyMessage
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.secondaryContainer;
    final textStyle = isMyMessage
        ? TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontSize: 16,
          )
        : TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            fontSize: 16,
          );
    final date = DateFormat('HH:mm  dd.MM.yy').format(message.createdAt);
    const bubbleRadius = Radius.circular(20);

    return Row(
      mainAxisAlignment:
          isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 12.0,
            bottom: 4.0,
          ),
          child: Column(
            crossAxisAlignment:
                isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: maximumBubbleWidth),
                child: Card(
                  margin: EdgeInsets.zero,
                  color: tileColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: bubbleRadius,
                      topRight: bubbleRadius,
                      bottomLeft:
                          isMyMessage ? bubbleRadius : const Radius.circular(0),
                      bottomRight:
                          isMyMessage ? const Radius.circular(0) : bubbleRadius,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: isMyMessage
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (!isMyMessage)
                          Text(
                            message.sender.name,
                            style: textStyle.copyWith(
                              fontSize: 12,
                              color: textStyle.color!.withOpacity(0.8),
                            ),
                          ),
                        Column(
                          crossAxisAlignment: isMyMessage
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.text,
                              style: textStyle,
                              textAlign:
                                  isMyMessage ? TextAlign.end : TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                date,
                style: textStyle.copyWith(
                  fontSize: 12,
                  color: textStyle.color!.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
