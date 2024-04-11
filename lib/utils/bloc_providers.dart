import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/bloc/authentication/authentication_cubit.dart';
import 'package:task_manager/bloc/task_management/task_cubit.dart';

MultiBlocProvider buildBlocProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
      ),
      BlocProvider<TaskCubit>(
        create: (context) => TaskCubit(),
      ),
    ],
    child: child,
  );
}
