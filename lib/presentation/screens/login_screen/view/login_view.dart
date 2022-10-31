import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/presentation/common/widgets/error_snack_bar.dart';
import 'package:gipsy_chat/presentation/common/widgets/gipsy_elevated_button.dart';
import 'package:gipsy_chat/presentation/common/widgets/gipsy_text_field.dart';
import 'package:gipsy_chat/presentation/common/routes/routes.dart';
import 'package:gipsy_chat/presentation/screens/login_screen/bloc/login_cubit.dart';
import 'package:gipsy_chat/presentation/screens/login_screen/bloc/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    context.read<LoginCubit>().login(_textController.text.trim());
  }

  void _onUserNameChange(String userName) {
    context.read<LoginCubit>().changeName(userName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                Navigator.of(context).pushReplacementNamed(Routes.rooms);
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
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Gipsy Chat',
                            style: TextStyle(
                              fontFamily: 'Merienda',
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          GipsyTextField(
                            hintText: 'enter your gipsy name',
                            textController: _textController,
                            onChanged: _onUserNameChange,
                          ),
                          const SizedBox(height: 25),
                          Hero(
                            tag: 'fab',
                            child: GipsyElevatedButton(
                              label: 'Become a gipsy!',
                              isActive: state.isButtonActive,
                              isLoading: state.status.isLoading,
                              onPressed: _onLoginPressed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
