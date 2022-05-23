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

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
        vmBuilder: () => RegisterViewModel(), builder: _pageBuilder);
  }

  Widget _pageBuilder(BuildContext context, RegisterViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: context.currentWidth,
          height: context.currentHeight,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  left: -context.dynamicWidth(40),
                  child: Image.asset(
                    ImageConstants.tiger,
                    height: context
                        .dynamicWidth(context.smallHeightPhone ? 175 : 275),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex: 2,
                        child: FittedBox(
                          child: Text(
                            'Kayıt Ol',
                            style: textTheme.headline1
                                ?.copyWith(color: AppColor.customOrange),
                          ).widgetPadding(),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: AutoSizeText(
                          'Swapy\'ye henüz kayıt olmadınız mı? Hadi sizin için bir kayıt oluşturalım ve miniğinizi mutlu edecek oyuncaklar bulalım...',
                          style: textTheme.bodyText2,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ).widgetPadding(),
                      ),
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Kullanıcı Adı'),
                          onSaved: viewModel.saveUserName,
                        ).widgetPadding(),
                      ),
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          onSaved: viewModel.saveEmail,
                        ).widgetPadding(),
                      ),
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Şifre'),
                          onSaved: viewModel.savePassword,
                        ).widgetPadding(),
                      ),
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Şifre (Tekrar)'),
                          onSaved: viewModel.saveRePassword,
                        ).widgetPadding(),
                      ),
                      Flexible(
                        child: Row(
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
                                      style: textTheme.caption?.copyWith(
                                          color: AppColor.customPink),
                                      children: [
                                        TextSpan(
                                            text: ' ve ',
                                            style: textTheme.caption),
                                        TextSpan(
                                            text: 'Gizlilik Politikasını',
                                            style: textTheme.caption?.copyWith(
                                                color: AppColor.customPink)),
                                        TextSpan(
                                            text: ' okudum ve kabul ediyorum.',
                                            style: textTheme.caption)
                                      ])),
                            ),
                          ],
                        ).widgetPadding(vertical: 5),
                      ),
                      Flexible(
                        flex: 2,
                        child: CustomButton(
                          text: 'Kayıt Ol',
                          onTap: viewModel.register,
                        ).widgetPadding(),
                      ),
                      Flexible(
                        child: Row(
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
                        ),
                      ),
                    ],
                  ).pagePadding(horizontal: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
