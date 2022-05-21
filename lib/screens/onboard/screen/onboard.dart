import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/core/widget/button/custom_button.dart';

class Onboard extends StatelessWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 3, child: Image.asset(ImageConstants.onboardVector)),
          Flexible(
            child: AutoSizeText(
              'Oyuncaklarını Geri Dönüştürmeye Hazır Mısın?',
              maxLines: 3,
              style: Theme.of(context).textTheme.headline1?.copyWith(color: AppColor.customOrange),
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            child: Text(
              'Artık kullanmadığınız oyuncaklarınız mı var? Çocuğunuz yeni oyuncaklar mı istiyor? Hadi size bir çözüm bulalım. Artık oynamadığınız oyuncakları oyanayabileceklerinizle değiştirelim...',
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                  onTap: () => NavigationService.instance
                      .navigateReplacement(AppRouter.login),
                  text: 'Giriş Yap',
                  topRight: 0,
                  bottomRight: 0,
                  color: AppColor.customPurple,
                )),
                Expanded(
                  child: CustomButton(
                    onTap: () => NavigationService.instance
                        .navigateReplacement(AppRouter.register),
                    text: 'Kayıt Ol',
                    topLeft: 0,
                    bottomLeft: 0,
                    color: AppColor.customGrey,
                    textColor: AppColor.customGrey.shade700,
                  ),
                ),
              ],
            ),
          )
        ],
      ).pagePadding(horizontal: 12, vertical: 100),
    );
  }
}
