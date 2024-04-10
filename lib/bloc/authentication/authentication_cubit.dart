import '../../data/repositories/authentication_repository.dart';
import '../../utils/base_cubit.dart';
import '../../utils/token_manager.dart';
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

  Future<void> refreshSession() async {
    final token = await TokenManager.getToken();
    if (token != null) {
      handleApiCall(() async {
        final user = await _authRepository.refreshSession();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emitError("Session Refresh Failed");
        }
      });
    } else {
      emitError("No token available");
    }
  }

  Future<void> getCurrentUser() async {
    final token = await TokenManager.getToken();
    if (token != null) {
      handleApiCall(() async {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emitError("User Not Found");
        }
      });
    } else {
      emitError("No token available");
    }
  }
}
