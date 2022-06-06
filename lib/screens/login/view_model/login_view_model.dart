import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/core/widget/dialog/util/show_confirm_dialog.dart';
import 'package:swapy/screens/chat/chat_service/cloud_massaging.dart';
import 'package:swapy/screens/login/model/login_request_model.dart';
import 'package:swapy/screens/login/model/user_info.dart';
import 'package:swapy/screens/login/service/login_service.dart';

class LoginViewModel extends BaseViewModel {
  static LoginViewModel? _instance;

  static LoginViewModel get instance => _instance ??= LoginViewModel();

  final formKey = GlobalKey<FormState>();
  final navigationService = NavigationService.instance;
  final service = LoginService();
  var userRequest = LoginRequestModel();

  UserCredential? user;
  UserInfoModel? userInfo;

  bool showPassword = true;

  @override
  FutureOr<void> init() {}

  void saveEmail(String? email) {
    userRequest.email = email;
  }

  void savePassword(String? password) {
    userRequest.password = password;
  }

  void forgotPassword() {}

  void login() async {
    if (formKey.currentState != null) {
      isLoading = true;
      formKey.currentState!.save();
      try {
        if (userRequest.isNotEmpty) {
          user = await service.loginWithEmailAndPassword(userRequest);
          if (user != null) {
            userInfo = await service
                .getUserInfo(FirebaseAuth.instance.currentUser?.uid);
            CloudMessagingManager.instance.token = userInfo?.userDeviceID;
            navigationService.navigateReplacement(AppRouter.afterLogin);
          } else {
            showConfirmDialog(
                contentText: "Kullanıcı girişi sırasında bir hata oluştu.",
                isJustConfirm: true);
          }
        }
      } catch (e) {
        showConfirmDialog(title: 'Hata', contentText: e.toString());
      }
      isLoading = false;
    }
  }

  void loginWithGmail() {}

  void loginWitFacebook() {}

  void loginWithApple() {}

  void showHidePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void clear(){
    _instance = null;
  }
}
