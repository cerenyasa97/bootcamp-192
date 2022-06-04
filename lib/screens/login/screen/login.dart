import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/widget/button/custom_circle_button.dart';
import 'package:swapy/core/widget/button/custom_button.dart';
import 'package:swapy/screens/login/view_model/login_view_model.dart';
import 'package:swapy/core/extension/context_extension.dart';

class Login extends StatefulWidget {


  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        vmBuilder: () => viewModel , builder: _body);
  }

  Widget _body(BuildContext context, LoginViewModel viewModel) => Scaffold(
        body: SizedBox(
          width: context.currentWidth,
          height: context.currentHeight,
          child: Stack(
            children: [
              Positioned(
                  bottom: -context.dynamicHeight(15),
                  right: -context.dynamicWidth(25),
                  child: Image.asset(
                    ImageConstants.dinosaur,
                    height: context
                        .dynamicWidth(context.smallHeightPhone ? 275 : 350),
                  )),
              SafeArea(
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: FittedBox(
                          child: Text(
                            'Yeniden Hoş Geldiniz',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(color: AppColor.customGreen),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: AutoSizeText(
                          'Hesabın var mı? Hadi giriş yap ve eski oyuncaklarını yeni ve eğlenceli oyuncaklar ile değiştir miniğini mutlu et.',
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ).widgetPadding(
                            vertical: 20),
                      ),
                      Flexible(
                        child: TextFormField(
                          onSaved: viewModel.saveEmail,
                          decoration: InputDecoration(labelText: 'Email'),
                        ).widgetPadding(),
                      ),
                      Flexible(
                        child: TextFormField(
                          onSaved: viewModel.savePassword,
                          obscureText: viewModel.showPassword,
                          decoration: InputDecoration(
                            labelText: 'Şifre',
                            suffixIcon: InkWell(
                              onTap: viewModel.showHidePassword,
                              child: Icon(EvaIcons.eyeOff2),
                            ),
                          ),
                        ).widgetPadding(),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: viewModel.forgotPassword,
                            child: Text(
                              'Parolamı Unuttum',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      decoration: TextDecoration.underline),
                            )),
                      ),
                      Flexible(
                        child: CustomButton(
                          text: 'Giriş Yap',
                          onTap: viewModel.login,
                          color: AppColor.customYellow,
                        ).widgetPadding(),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Image.asset(
                                    ImageConstants.otherOptionsLeft)),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.dynamicWidth(2)),
                                child: AutoSizeText(
                                  'Ya da bunlardan biriyle devam et!',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Flexible(
                                child: Image.asset(
                                    ImageConstants.otherOptionsRight)),
                          ],
                        ).widgetPadding(),
                      ),
                      Flexible(
                          child: SizedBox(
                        height: context.dynamicHeight(10),
                      )),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomCircleButton(
                              onTap: viewModel.loginWithGmail,
                              icon: EvaIcons.google,
                              iconColor: AppColor.customPink,
                            ),
                            CustomCircleButton(
                              onTap: viewModel.loginWitFacebook,
                              icon: EvaIcons.facebook,
                              iconColor: AppColor.customPink,
                            ),
                            CustomCircleButton(
                              onTap: viewModel.loginWithApple,
                              icon: Ionicons.logo_apple,
                              iconColor: AppColor.customPink,
                            ),
                          ],
                        ).widgetPadding(),
                      ),
                    ],
                  ).pagePadding(horizontal: 12, vertical: 60),
                ),
              ),
            ],
          ),
        ),
      );
}
