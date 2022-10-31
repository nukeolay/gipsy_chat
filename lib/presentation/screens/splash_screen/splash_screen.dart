import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/splash_screen/bloc/splash_cubit.dart';
import 'package:gipsy_chat/presentation/screens/splash_screen/view/splash_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashCubit(context.read<UserRepository>())..loadUser(),
      child: const SplashView(),
    );
  }
}
