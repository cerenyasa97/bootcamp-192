import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/widget/button/custom_button.dart';
import 'package:swapy/core/widget/image_view/circle_image.dart';
import 'package:swapy/core/widget/text_field/text_field_with_label.dart';
import 'package:swapy/screens/profile/view_model/profile_view_model.dart';

class Profile extends StatefulWidget {

  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final vm = ProfileViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        vmBuilder: vm, builder: _buildPage);
  }

  Widget _buildPage(BuildContext context, ProfileViewModel viewModel) =>
      Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(12),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.dynamicWidth(50),
                  ),
                  Image.asset(
                    ImageConstants.profile,
                    height: context.dynamicHeight(40),
                  ).widgetPadding(),
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Colors.black),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: TextButton.icon(
                            onPressed: viewModel.openEditMode,
                            icon: Icon(Icons.settings),
                            label: Text('Profili Düzenle'),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            )),
                      ),
                      PopupMenuItem(
                        child: TextButton.icon(
                            onPressed: viewModel.logOut,
                            icon: Icon(Icons.logout),
                            label: Text('Çıkış Yap'),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: viewModel.isEditMode ? viewModel.addImage : null,
                child: Container(
                  width: context.dynamicWidth(150),
                  height: context.dynamicWidth(150),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: viewModel.user?.userImage != null
                        ? DecorationImage(
                            image: NetworkImage(viewModel.user!.userImage!),
                          )
                        : null,
                    color: Colors.white,
                  ),
                ),
              ),
              TextFieldWithLabel(
                controller: viewModel.nameController,
                hintText: "Adı Soyadı",
                label: "Adı Soyadı",
                isEnabled: viewModel.isEditMode,
              ).widgetPadding(),
              TextFieldWithLabel(
                controller: viewModel.phoneController,
                hintText: "Telefon Numarası",
                label: "Telefon Numarası",
                isEnabled: viewModel.isEditMode,
              ),
              TextFieldWithLabel(
                controller: viewModel.emailController,
                hintText: "E-Mail",
                label: "E-Mail",
                isEnabled: viewModel.isEditMode,
              ).widgetPadding(),
              TextFieldWithLabel(
                controller: viewModel.addresController,
                hintText: "Adres",
                label: "Adres",
                isEnabled: viewModel.isEditMode,
              ),
              Visibility(
                visible: viewModel.isEditMode,
                child: CustomButton(
                  onTap: viewModel.save,
                  color: AppColor.customPink,
                  text: 'Kaydet',
                ).widgetPadding(),
              ),
            ],
          ),
        ),
      );
}
