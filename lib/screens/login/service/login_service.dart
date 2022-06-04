import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swapy/screens/login/model/login_request_model.dart';
import 'package:swapy/screens/login/model/user_info.dart';

class LoginService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithEmailAndPassword(
      LoginRequestModel request) async {
    return await auth.signInWithEmailAndPassword(
        email: request.email!, password: request.password!);
  }

  Future<UserInfoModel?> getUserInfo(String? id) async {
    final db = FirebaseFirestore.instance;
    final userInfoData = await db
        .collection('users')
        .where("userUid", isEqualTo: id)
        .get();
    return UserInfoModel().fromJson(userInfoData.docs.first.data());
  }
}
