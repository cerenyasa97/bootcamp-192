import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/widget/button/custom_button.dart';
import 'package:swapy/core/widget/text_field/text_field_with_label.dart';
import 'package:swapy/screens/add_toy/view_model/add_toy_view_model.dart';

class AddToy extends StatelessWidget {
  const AddToy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AddToyViewModel>(
        vmBuilder: AddToyViewModel(), builder: _buildPage);
  }

  Widget _buildPage(BuildContext context, AddToyViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final space = SizedBox(
      height: 10,
    );
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12),
          children: [
            Image.asset(
              ImageConstants.addToy,
              height: context.dynamicHeight(40),
            ).widgetPadding(),
            InkWell(
              onTap: viewModel.selectImage,
              child: Card(
                child: viewModel.imageUrl != null
                    ? CachedNetworkImage(imageUrl: viewModel.imageUrl!)
                    : Container(
                        width: context.dynamicHeight(250),
                        height: context.dynamicHeight(250),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_rounded,
                              color: Colors.black,
                              size: context.dynamicHeight(50),
                            ),
                            space,
                            Text(
                              'Fotoğraf Ekle',
                              style: textTheme.headline6,
                            )
                          ],
                        ),
                      ),
              ),
            ),
            space,
            TextFieldWithLabel(
              controller: viewModel.nameController,
              label: 'Oyuncak Adı',
              hintText: 'Lego...',
            ),
            space,
            TextFieldWithLabel(
              controller: TextEditingController(text: viewModel.gender ?? ''),
              label: 'Cinsiyet',
              itemSelected: (text) => viewModel.gender = text,
              hintText: 'Seçiniz',
              comboItems: ['Kız', 'Erkek', 'Unisex'],
            ),
            space,
            TextFieldWithLabel(
              controller: TextEditingController(
                  text: viewModel.selectedToyType?.title ?? ''),
              label: 'Kategori',
              itemSelected: viewModel.updateToyType,
              hintText: 'Seçiniz',
              comboItems: viewModel.toyTypes.map((e) => e.title).toList(),
            ),
            space,
            TextFieldWithLabel(
              controller: viewModel.descController,
              label: 'Açıklama',
              hintText: '86 Parça Lego seti...',
              maxLine: 10,
            ),
            space,
            CustomButton(text: 'Kaydet', onTap: viewModel.saveToy)
          ],
        ),
      ),
    );
  }
}
