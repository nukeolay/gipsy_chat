import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/entities/user.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/login_screen/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository _userRepository;

  LoginCubit(this._userRepository) : super(const LoginState());

  void changeName(String username) {
    if (username.trim() != '') {
      emit(state.copyWith(
        isButtonActive: true,
        status: LoginStatus.init,
      ));
    } else {
      emit(state.copyWith(
        isButtonActive: false,
        status: LoginStatus.init,
      ));
    }
  }

  Future<void> login(String username) async {
    try {
      emit(const LoginState(status: LoginStatus.loading));
      await _userRepository.login(User(username));
      emit(const LoginState(status: LoginStatus.success));
    } catch (error) {
      emit(LoginState(
        status: LoginStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }
}
