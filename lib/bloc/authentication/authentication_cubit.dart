import '../../data/repositories/authentication_repository.dart';
import '../../utils/base_cubit.dart';
import 'authentication_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    handleApiCall(() async {
      final user = await _authRepository.loginUser(username, password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emitError("Login Failed");
      }
    });
  }

  Future<void> refreshSession(String token) async {
    handleApiCall(() async {
      final user = await _authRepository.refreshSession(token);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emitError("Session Refresh Failed");
      }
    });
  }

  Future<void> getCurrentUser(String token) async {
    handleApiCall(() async {
      final user = await _authRepository.getCurrentUser(token);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emitError("User Not Found");
      }
    });
  }
}
