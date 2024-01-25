import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../constant/enum.dart';
import '../../../../core/di/locator.dart';
import '../../../../core/utils/local_prefs.dart';
import '../../../../domain/model/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  final _localPrefs = getInstance<LocalPrefs>();

//get user

  getUser() async {
    emit(state.copyWith(loadingStatus: StateStatusEnum.loading));
    User? user = await _localPrefs.getUser();
    log('user: $user');
    if (user != null) {
      emit(state.copyWith(
          profileModel: user, loadingStatus: StateStatusEnum.success));

      // updateTextEditingCtr(user);
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // inital setup

  // update TextEdingCTR
  // void updateTextEditingCtr(User user) {
  //   nameController.text = user.fullName;
  //   emailController.text = user.email;
  //   phoneController.text = user.email;
  //   addressController.text = user.email;
  // }
}
