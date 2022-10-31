import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/domain/repositories/user_repository.dart';
import 'package:gipsy_chat/presentation/screens/splash_screen/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final UserRepository _userRepository;

  SplashCubit(this._userRepository) : super(const SplashState());

  Future<void> loadUser() async {
    try {
      emit(const SplashState(status: SplashStatus.loading));
      final user = await _userRepository.user;
      if (user != null) {
        emit(const SplashState(status: SplashStatus.success));
      } else {
        emit(const SplashState(status: SplashStatus.notLogined));
      }
    } catch (error) {
      emit(SplashState(
        status: SplashStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }
}
