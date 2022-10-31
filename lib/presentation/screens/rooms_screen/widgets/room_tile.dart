import 'package:flutter/material.dart';
import 'package:gipsy_chat/domain/entities/room.dart';
import 'package:gipsy_chat/presentation/common/routes/routes.dart';

class RoomTile extends StatelessWidget {
  final Room room;
  const RoomTile(this.room, {super.key});

  @override
  Widget build(BuildContext context) {
    final message = room.messages[0];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minVerticalPadding: 8.0,
        title: Text(room.name),
        subtitle: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: '${message.sender.name}: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).disabledColor,
              ),
            ),
            TextSpan(
              text: message.text,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).disabledColor,
              ),
            ),
          ]),
        ),
        trailing: const SizedBox(
          height: double.infinity,
          child: Icon(Icons.arrow_forward_ios_rounded),
        ),
        onTap: () =>
            Navigator.of(context).pushNamed(Routes.chat, arguments: room.name),
      ),
    );
  }
}
