import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swapy/core/widget/dialog/util/show_confirm_dialog.dart';

class ImagePick {
  final picker = ImagePicker();
  final storage = FirebaseStorage.instance.ref();
  String? imageUrl;

  Future<void> showActionSheet(BuildContext context) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Fotoğraf Yükle'),
        message: const Text(
            'Eklemek istediğiniz oyuncağın fotoğrafını çekiniz veya fotoğraf seçiniz.'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              await _getImage();
              Navigator.pop(context);
            },
            child: const Text('Resim Çek'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              await _getImage(isFromGallery: true);
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

  Future<void> _getImage({isFromGallery = false}) async {
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
}
