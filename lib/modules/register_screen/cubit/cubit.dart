import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mowitter/models/user_model.dart';
import 'package:mowitter/modules/register_screen/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suflixIcon = Icons.visibility_outlined;
  IconData repeatSuflixIcon = Icons.visibility_outlined;

  bool isPassword = true;
  bool repeatPasswordHide = true;

  // ShopLoginModel? loginMod;

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingStates());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      print(value.user!.email);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId:value.user!.uid,
      );
      emit(RegisterSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorStates(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String phone,
    required String email,
    required String uId,
  }) {

    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value){
          emit(CreateUserSuccessStates());
    })
        .catchError((error){
          emit(CreateUserErrorStates(error));
    });
  }

  void changePasswordShow(int num) {
    if (num == 1) {
      isPassword = !isPassword;
      suflixIcon = isPassword
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined;
    } else {
      repeatPasswordHide = !repeatPasswordHide;
      repeatSuflixIcon = repeatPasswordHide
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined;
    }

    emit(RegisterChangePasswordShowStates());
  }
}
