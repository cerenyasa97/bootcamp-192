import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/widget/dialog/util/show_confirm_dialog.dart';
import 'package:swapy/screens/add_toy/service/add_toy_service.dart';
import 'package:swapy/screens/home/model/toy_model.dart';
import 'package:swapy/screens/home/model/toy_type_model.dart';
import 'package:swapy/screens/home/service/home_service.dart';
import 'package:swapy/screens/login/view_model/login_view_model.dart';
import 'package:uuid/uuid.dart';

class AddToyViewModel extends BaseViewModel {
  final service = AddToyService();
  final homeService = HomeService();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final picker = ImagePicker();
  final storage = FirebaseStorage.instance.ref();
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

  void selectImage() {
    _showActionSheet(context);
    notifyListeners();
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Fotoğraf Yükle'),
        message: const Text(
            'Eklemek istediğiniz oyuncağın fotoğrafını çekiniz veya fotoğraf seçiniz.'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              _getImage();
              Navigator.pop(context);
            },
            child: const Text('Resim Çek'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              _getImage(isFromGallery: true);
              Navigator.pop(context);
            },
            child: const Text('Galeriden Seç'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('İptal'),
          )
        ],
      ),
    );
  }

  Future _getImage({isFromGallery = false}) async {
    try {
      await Permission.photos.request();
      var permissionStatus = await Permission.photos.status;
      if (permissionStatus.isGranted) {
        //Select Image
        XFile? pickedFile = await picker.pickImage(
          source: isFromGallery ? ImageSource.gallery : ImageSource.camera,
          maxWidth: 1000,
          maxHeight: 1000,
        );
        if (pickedFile != null) {
          File imageFile = File(pickedFile.path);
          if (imageFile != null) {
            //Upload to Firebase
            var snapshot =
                await storage.child(pickedFile.name).putFile(imageFile);
            imageUrl = await snapshot.ref.getDownloadURL();
            notifyListeners();
          } else {
            showConfirmDialog(
                contentText: 'Fotoğraf yüklenirken bir sorun oluştu.',
                isJustConfirm: true);
          }
        }
      } else {
        showConfirmDialog(
            contentText: 'Fotoğraf yükleme izni verilmemiştir.',
            isJustConfirm: true);
      }
    } on Exception catch (e) {
      showConfirmDialog(contentText: e.toString(), isJustConfirm: true);
    }
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

  void clearPage(){
    nameController.text = "";
    descController.text = "";
    gender = null;
    selectedToyType = null;
    imageUrl = null;
  }
}
