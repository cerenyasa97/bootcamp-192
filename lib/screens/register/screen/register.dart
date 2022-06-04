import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/widget/button/custom_button.dart';
import 'package:swapy/screens/register/view_model/register_view_model.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final vm = RegisterViewModel();
  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
        vmBuilder: vm, builder: _pageBuilder);
  }

  Widget _pageBuilder(BuildContext context, RegisterViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Form(
        key: viewModel.formKey,
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                ImageConstants.tiger,
                height: context
                    .dynamicHeight(context.smallHeightPhone ? 150 : 250),
              ),
            ),
            Center(
              child: Text(
                'Kayıt Ol',
                style: textTheme.headline1
                    ?.copyWith(color: AppColor.customOrange),
              ).widgetPadding(vertical: 2),
            ),
            AutoSizeText(
              'Swapy\'ye henüz kayıt olmadınız mı? Hadi sizin için bir kayıt oluşturalım ve miniğinizi mutlu edecek oyuncaklar bulalım...',
              style: textTheme.bodyText2,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
              onSaved: viewModel.saveUserName,
            ).widgetPadding(vertical: 2),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onSaved: viewModel.saveEmail,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Şifre'),
              onSaved: viewModel.savePassword,
            ).widgetPadding(vertical: 2),
            TextFormField(
              decoration: InputDecoration(labelText: 'Şifre (Tekrar)'),
              onSaved: viewModel.saveRePassword,
            ),
            Row(
              children: [
                Icon(
                  Ionicons.checkmark_done_circle_outline,
                  color: AppColor.customPink,
                ),
                SizedBox(
                  width: context.dynamicWidth(12),
                ),
                Flexible(
                  child: RichText(
                      maxLines: 3,
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                          text: 'Kullanım Şartlarını',
                          style: textTheme.caption
                              ?.copyWith(color: AppColor.customPink),
                          children: [
                            TextSpan(
                                text: ' ve ', style: textTheme.caption),
                            TextSpan(
                                text: 'Gizlilik Politikasını',
                                style: textTheme.caption
                                    ?.copyWith(color: AppColor.customPink)),
                            TextSpan(
                                text: ' okudum ve kabul ediyorum.',
                                style: textTheme.caption)
                          ])),
                ),
              ],
            ).widgetPadding(vertical: 2),
            CustomButton(
              text: 'Kayıt Ol',
              onTap: viewModel.register,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Zaten bir hesabın var mı? ',
                  style: textTheme.caption,
                ),
                InkWell(
                  onTap: viewModel.login,
                  child: Text(
                    'Giriş Yap',
                    style: textTheme.caption?.copyWith(
                        color: AppColor.customPink,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ).widgetPadding(vertical: 2),
          ],
        ),
      ),
    );
  }
}
