

import 'package:bloc/bloc.dart';
import 'package:egy_eye_admin/app/layout/view/screens/layout_screen.dart';
import 'package:egy_eye_admin/helpers/cache/cache_helper.dart';
import 'package:egy_eye_admin/helpers/methods/navigation_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:html' as html;
import '../../../../helpers/constants/constants.dart';
import 'login_states.dart';


class LoginCubit extends Cubit<LoginStates>{

  LoginCubit():super(InitialLoginState());

  static LoginCubit get(context) =>BlocProvider.of(context);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  void login(context)async {
    emit(SocialAppLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()).then((value) {

      html.window.localStorage['uId'] = value.user!.uid;
      //CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      uId= value.user!.uid;
      navigateWithoutBack(context, LayoutScreen());

      emit(SocialAppLoginSuccessState("dd"));
    }).catchError((error){
      print(error.toString());
      emit(SocialAppLoginErrorState(error: error.toString()));
    });
  }


}