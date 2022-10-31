import 'package:flutter/material.dart';
import 'package:gipsy_chat/presentation/screens/chat_screen/chat_screen.dart';
import 'package:gipsy_chat/presentation/screens/create_room_screen/create_room_screen.dart';
import 'package:gipsy_chat/presentation/screens/login_screen/login_screen.dart';
import 'package:gipsy_chat/presentation/screens/rooms_screen/rooms_screen.dart';
import 'package:gipsy_chat/presentation/screens/splash_screen/splash_screen.dart';

class Routes {
  static const login = '/login-screen';
  static const splash = '/splash-screen';
  static const rooms = '/rooms-screen';
  static const createRoom = '/create-room-screen';
  static const chat = '/chat-screen';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) {
        switch (routeSettings.name) {
          case login:
            return const LoginScreen();
          case splash:
            return const SplashScreen();
          case rooms:
            return const RoomsScreen();
          case chat:
            return const ChatScreen();
          case createRoom:
            return const CreateRoomScreen();
          default:
            return const SplashScreen();
        }
      },
    );
  }
}
