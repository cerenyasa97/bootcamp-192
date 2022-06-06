import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/core/widget/dialog/util/show_confirm_dialog.dart';
import 'package:swapy/screens/login/view_model/login_view_model.dart';
import 'package:swapy/screens/profile/service/profile_service.dart';
import 'package:swapy/screens/shared/methods/pick_image.dart';

class ProfileViewModel extends BaseViewModel {
  final service = ProfileService();
  final formKey = GlobalKey<FormState>();
  final user = LoginViewModel.instance.userInfo;
  final navigationService = NavigationService.instance;

  final nameController = TextEditingController(text: LoginViewModel.instance.userInfo?.name);
  final phoneController = TextEditingController(text: LoginViewModel.instance.userInfo?.phone);
  final emailController = TextEditingController(text: LoginViewModel.instance.userInfo?.email);
  final addresController = TextEditingController(text: LoginViewModel.instance.userInfo?.address);

  var isEditMode = false;

  @override
  FutureOr<void> init() {}

  void openEditMode({isNavigateBack = true}) {
    isEditMode = !isEditMode;
    notifyListeners();
    if(isNavigateBack) navigationService.navigateBack();
  }

  Future<void> addImage() async {
    final imagePick = ImagePick();
    await imagePick.showActionSheet(context);
    user?.userImage = imagePick.imageUrl;
    notifyListeners();
  }

  Future save() async {
    try {
      if (user != null) {
        user?.name =
            nameController.text.isNotEmpty ? nameController.text : user?.name;
        user?.phone = phoneController.text.isNotEmpty
            ? phoneController.text
            : user?.phone;
        user?.email = emailController.text.isNotEmpty
            ? emailController.text
            : user?.email;
        user?.address = addresController.text.isNotEmpty
            ? addresController.text
            : user?.address;
        await service.updateUserInfo(user!);
        openEditMode(isNavigateBack: false);
      }
    } on Exception catch (e) {
      showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    LoginViewModel.instance.clear();
    navigationService.navigateReplacement(AppRouter.login);
  }
}
