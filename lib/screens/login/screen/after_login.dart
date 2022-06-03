import 'package:flutter/material.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/core/widget/button/custom_button.dart';

class AfterLogin extends StatelessWidget {
  const AfterLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: FittedBox(
                child: Text(
                  'Başlamaya Hazırsın!',
                  style: textTheme.headline1
                      ?.copyWith(color: AppColor.customOrange),
                ),
              ),
            ),
            Expanded(flex: 3, child: Image.asset(ImageConstants.afterLogin)),
            Flexible(
              child: CustomButton(
                text: 'Devam Et',
                onTap: () => NavigationService.instance
                    .navigateReplacement(AppRouter.home),
                color: AppColor.customGreen,
              ),
            ),
            Flexible(
              child: Text(
                'Miniğinizi mutlu etmenin yolu Swapy\'den geçer. Hadi miniğinize yeni oyuncaklar bulalım!',
                style: textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ).pageExpandedPadding(),
      ),
    );
  }
}
