import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/authentication_repository.dart';
import 'authentication_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.loginUser(username, password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Login Failed"));
      }
    } catch (e) {
      emit(AuthError("Error: $e"));
    }
  }

  Future<void> refreshSession(String token) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.refreshSession(token);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Session Refresh Failed"));
      }
    } catch (e) {
      emit(AuthError("Error: $e"));
    }
  }

  Future<void> getCurrentUser(String token) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.getCurrentUser(token);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("User Not Found"));
      }
    } catch (e) {
      emit(AuthError("Error: $e"));
    }
  }
}
