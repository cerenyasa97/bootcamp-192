import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/widget/dialog/util/show_confirm_dialog.dart';
import 'package:swapy/screens/add_toy/service/add_toy_service.dart';
import 'package:swapy/screens/home/model/toy_model.dart';
import 'package:swapy/screens/home/model/toy_type_model.dart';
import 'package:swapy/screens/home/service/home_service.dart';
import 'package:swapy/screens/login/view_model/login_view_model.dart';
import 'package:swapy/screens/shared/methods/pick_image.dart';
import 'package:uuid/uuid.dart';

class AddToyViewModel extends BaseViewModel {
  final service = AddToyService();
  final homeService = HomeService();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final user = LoginViewModel.instance.userInfo;
  String? _gender;
  TType? _selectedToyType;
  List<TType> toyTypes = [];
  String? imageUrl;

  @override
  FutureOr<void> init() async {
    toyTypes = (await homeService.getToyTypes()) ?? <TType>[];
    if (toyTypes.length > 1) toyTypes.removeAt(0);
  }

  String? get gender => _gender;

  set gender(String? value) {
    _gender = value;
    notifyListeners();
  }

  void updateToyType(String? type) {
    selectedToyType = toyTypes.firstWhere((element) => element.title == type);
  }

  TType? get selectedToyType => _selectedToyType;

  set selectedToyType(TType? value) {
    _selectedToyType = value;
    notifyListeners();
  }

  Future<void> selectImage() async {
    final imagePick = ImagePick();
    await imagePick.showActionSheet(context);
    imageUrl = imagePick.imageUrl;
    notifyListeners();
  }

  Future saveToy() async {
    try {
      if (nameController.text.isNotEmpty &&
          selectedToyType != null &&
          imageUrl != null) {
        final toy = Toy(
            toyId: Uuid().v1(),
            name: nameController.text,
            gender: gender,
            advertiser: user?.name,
            advertiserId: user?.userUid,
            advertiserImage: user?.userImage,
            advertiserRating: user?.rating,
            image: imageUrl,
            description: descController.text);
        await service.saveToy(toy, selectedToyType?.typeId ?? "educational");
        clearPage();
      } else {
        showConfirmDialog(
            contentText:
                'Lütfen oyuncak ismi, fotoğrafı ve kategorisini seçtiğinizden emin olunuz.',
            isJustConfirm: true);
      }
    } on Exception catch (e) {
      showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    }
  }

  void clearPage() {
    nameController.text = "";
    descController.text = "";
    gender = null;
    selectedToyType = null;
    imageUrl = null;
  }
}
