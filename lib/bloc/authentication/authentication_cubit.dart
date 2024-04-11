import 'package:flutter/cupertino.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../utils/snack_bar_message.dart';
import '../../utils/token_manager.dart';
import 'authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  AuthCubit() : super(AuthInitial());

  void _emitLoading() {
    emit(AuthLoading());
  }

  void _emitError(String errorMessage) {
    emit(AuthError(errorMessage));
  }

  Future<void> login(
      BuildContext context, String username, String password) async {
    _emitLoading();
    try {
      final user = await _authRepository.loginUser(username, password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        _emitError("Login Failed");
        showSnackBar(context, 'Invalid username or password');
      }
    } catch (error) {
      showSnackBar(context, 'Please try again later');
    }
  }

  Future<void> refreshSession() async {
    final token = await TokenManager.getToken();
    if (token != null) {
      _emitLoading();
      try {
        final user = await _authRepository.refreshSession();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          _emitError("Session Refresh Failed");
        }
      } catch (e) {
        _emitError("Error: $e");
      }
    }
  }

  Future<void> getCurrentUser() async {
    final token = await TokenManager.getToken();
    if (token != null) {
      _emitLoading();
      try {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          _emitError("User Not Found");
        }
      } catch (e) {
        _emitError("Error: $e");
      }
    }
  }
}
