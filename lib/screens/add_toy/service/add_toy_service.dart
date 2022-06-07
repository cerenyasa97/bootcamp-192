import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swapy/core/constants/string/string_constants.dart';
import 'package:swapy/screens/home/model/toy_model.dart';

class AddToyService {
  final db = FirebaseFirestore.instance;

  Future<void> saveToy(Toy toy, String selectedCategoryID) async {
    final newDoc = db
        .collection(StringConstants.toys)
        .doc(selectedCategoryID);
    final toys = await newDoc
        .withConverter<ToyResult>(
        fromFirestore: (snapshot, _) => ToyResult().fromJson(snapshot.data()),
        toFirestore: (model, _) => model.toJson()).get();
    var toyRes = toys.data();
    if(toyRes?.toys != null){
      toyRes!.toys!.add(toy);
    } else {
      toyRes = ToyResult(
        toys: [toy]
      );
    }
    await db
        .collection(StringConstants.toys)
        .doc(selectedCategoryID)
        .set(toyRes.toJson());
  }
}
