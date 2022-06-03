import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swapy/core/constants/string/string_constants.dart';
import 'package:swapy/screens/chat/chat_service/cloud_massaging.dart';
import 'package:swapy/screens/login/model/user_info.dart';
import 'package:swapy/screens/register/model/register_request_model.dart';
import 'package:uuid/uuid.dart';

class RegisterService {
  final auth = FirebaseAuth.instance;

  Future<UserCredential?> register(RegisterRequestModel request) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
        email: request.email!, password: request.password!);
    final db = FirebaseFirestore.instance;
    await CloudMessagingManager.instance.requestToken();
    await db.collection(StringConstants.users).doc(Uuid().v1()).set(
      UserInfoModel(
        email: userCredential.user?.email,
        userUid: userCredential.user?.uid,
        name: request.userName,
        userDeviceID: CloudMessagingManager.instance.token
      ).toJson()
    );
  }
}