import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/repositories/rooms_repository.dart';
import 'package:gipsy_chat/presentation/common/routes/custom_page_transition_builder.dart';
import 'package:gipsy_chat/presentation/common/routes/routes.dart';
import 'package:gipsy_chat/domain/repositories/chat_repository.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/splash_screen/splash_screen.dart';

class GipsyChatApp extends StatelessWidget {
  const GipsyChatApp({
    required UserRepository userRepository,
    required RoomsRepository roomsRepository,
    required ChatRepository chatRepository,
    super.key,
  })  : _userRepository = userRepository,
        _roomsRepository = roomsRepository,
        _chatRepository = chatRepository;

  final UserRepository _userRepository;
  final RoomsRepository _roomsRepository;
  final ChatRepository _chatRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(value: _userRepository),
        RepositoryProvider<RoomsRepository>.value(value: _roomsRepository),
        RepositoryProvider<ChatRepository>.value(value: _chatRepository),
      ],
      child: const GipsyChatAppView(),
    );
  }
}

class GipsyChatAppView extends StatelessWidget {
  const GipsyChatAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gipsy Chat',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
        errorColor: Colors.red.shade900,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CustomPageTransitionBuilder(),
          TargetPlatform.iOS: CustomPageTransitionBuilder(),
        }),
      ),
      home: const SplashScreen(),
      onGenerateRoute: Routes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
