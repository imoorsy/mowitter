import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mowitter/modules/login_screen/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suflixIcon = Icons.visibility_outlined;

  bool isPassword = true;

  // ShopLoginModel? loginMod;

  void userLogin(
    context, {
    required String email,
    required String password,
  }) {
    emit(LoginLoadingStates());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessStates());
    }).catchError((error) {
      emit(LoginErrorStates(error.toString()));
    });
  }

  void changePasswordShow(){
    isPassword = !isPassword;
    suflixIcon = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordShowStates());
  }
}
