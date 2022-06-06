import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swapy/core/constants/string/string_constants.dart';
import 'package:swapy/screens/login/model/user_info.dart';
import 'package:swapy/screens/register/model/register_request_model.dart';
import 'package:uuid/uuid.dart';

class ProfileService {
  final db = FirebaseFirestore.instance;

  Future<void> updateUserInfo(UserInfoModel user) async {
    final docs = await db
        .collection(StringConstants.users)
        .where('userUid', isEqualTo: user.userUid)
        .get();
    if (docs.docs.isNotEmpty) {
      await db
          .collection(StringConstants.users)
          .doc(docs.docs.first.id)
          .update(user.toJson());
    }
  }
}
