import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/presentation/common/routes/routes.dart';
import 'package:gipsy_chat/presentation/screens/splash_screen/bloc/splash_cubit.dart';
import 'package:gipsy_chat/presentation/screens/splash_screen/bloc/splash_state.dart';
import 'package:gipsy_chat/presentation/screens/splash_screen/widgets/splash_error.dart';
import 'package:gipsy_chat/presentation/screens/splash_screen/widgets/splash_loading.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              Navigator.of(context).pushReplacementNamed(Routes.rooms);
            }
            if (state.status.isNotLogined) {
              Navigator.of(context).pushReplacementNamed(Routes.login);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case SplashStatus.failure:
                return const SplashError();
              default:
                return const SplashLoading();
            }
          },
        ),
      ),
    );
  }
}
