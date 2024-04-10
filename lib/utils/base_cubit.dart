import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(State initialState) : super(initialState);

  Future<void> handleApiCall(Future<void> Function() apiCall) async {
    emitLoading();
    try {
      await apiCall();
    } catch (e) {
      emitError('Error: $e');
    }
  }

  void emitLoading() {
    emit(_loadingState());
  }

  void emitError(String errorMessage) {
    emit(_errorState(errorMessage));
  }

  State _loadingState() {
    return Loading() as State;
  }

  State _errorState(String errorMessage) {
    return Error(errorMessage) as State;
  }
}

class Loading {}

class Error {
  final String errorMessage;

  Error(this.errorMessage);
}
