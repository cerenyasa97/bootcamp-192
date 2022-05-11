import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/widget/button/custom_button.dart';
import 'package:swapy/screens/register/view_model/register_view_model.dart';

class Register extends StatelessWidget {
  final height = 75.0;
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
        vmBuilder: () => RegisterViewModel(), builder: _pageBuilder);
  }

  Widget _pageBuilder(BuildContext context, RegisterViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox(
        width: context.currentWidth,
        height: context.currentHeight,
        child: Stack(
          children: [
            Image.asset(ImageConstants.background),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Kayıt Ol',
                      style: textTheme.headline1,
                    ).widgetPadding(vertical: 10),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam maecenas mi non sed ut odio. Non, justo, sed facilisi et.',
                      style: textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ).widgetPadding(),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
                      onSaved: viewModel.saveUserName,
                    ).widgetPadding(),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      onSaved: viewModel.saveEmail,
                    ).widgetPadding(),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Şifre'),
                      onSaved: viewModel.savePassword,
                    ).widgetPadding(),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Şifre (Tekrar)'),
                      onSaved: viewModel.saveRePassword,
                    ).widgetPadding(),
                    Row(
                      children: [
                        Icon(
                          Ionicons.checkmark_done_circle_outline,
                          color: Colors.red,
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
                                      ?.copyWith(color: Colors.red),
                                  children: [
                                    TextSpan(
                                        text: ' ve ', style: textTheme.caption),
                                    TextSpan(
                                        text: 'Gizlilik Politikasını',
                                        style: textTheme.caption
                                            ?.copyWith(color: Colors.red)),
                                    TextSpan(
                                        text: ' okudum ve kabul ediyorum.',
                                        style: textTheme.caption)
                                  ])),
                        ),
                      ],
                    ),
                    CustomButton(
                      text: 'Kayıt Ol',
                      onTap: viewModel.register,
                    ).widgetPadding(),
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
                                color: Colors.red,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    )
                  ],
                ).pagePadding(horizontal: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
