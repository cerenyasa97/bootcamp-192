import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swapy/core/constants/string/string_constants.dart';
import 'package:swapy/screens/home/model/toy_model.dart';
import 'package:swapy/screens/login/view_model/login_view_model.dart';

class MyToysService {
  final db = FirebaseFirestore.instance;

  Future<List<Toy>> getMyToys() async {
    final data = await db
        .collection(StringConstants.toys)
        .withConverter<ToyResult>(
            fromFirestore: (snapshot, _) =>
                ToyResult().fromJson(snapshot.data()),
            toFirestore: (model, _) => model.toJson())
        .get();
    var toys = <Toy>[];
    if (data.docs.isNotEmpty) {
      data.docs.forEach((element) {
        final toyList = (element
            .data()
            .toys
            ?.where((element) =>
                element.advertiserId ==
                LoginViewModel.instance.userInfo?.userUid)
            .toList());
        if (toyList != null && toyList.isNotEmpty) toys.addAll(toyList);
      });
    }
    return toys;
  }

  Future<void> deleteToy(Toy toy) async {
    final document = await db
        .collection(StringConstants.toys)
        .where(StringConstants.toyID, isEqualTo: toy.toyId)
        .get();
    print(document.toString());
    await db
        .collection(StringConstants.toys)
        .doc(document.docs.first.id)
        .delete();
  }
}
