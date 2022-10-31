import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/login_screen/bloc/login_cubit.dart';
import 'package:gipsy_chat/presentation/screens/login_screen/view/login_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<UserRepository>()),
      child: const LoginView(),
    );
  }
}
