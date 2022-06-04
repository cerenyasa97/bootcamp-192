import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/widget/button/custom_circle_button.dart';
import 'package:swapy/screens/chat/chat_service/cloud_massaging.dart';
import 'package:swapy/screens/home/screen/widget/home_toys_widget.dart';
import 'package:swapy/screens/home/view_model/home_view_model.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>.value(
      value: HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) => SafeArea(
          child: ListView(
            padding: EdgeInsets.only(top: 12, left: 12, right: 12),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Image.asset(
                    ImageConstants.appLogo,
                    height: context.dynamicHeight(40),
                  ).widgetPadding(),
                  Consumer<CloudMessagingManager>(
                      builder: (context, model, _) => model.badgeCount != 0
                          ? Badge(
                        badgeContent: Text(model.badgeCount.toString()),
                        child: CustomCircleButton(
                          icon: Ionicons.chatbubble_ellipses_outline,
                          onTap: viewModel.messages,
                        ),
                      )
                          : CustomCircleButton(
                        icon: Ionicons.chatbubble_ellipses_outline,
                        onTap: viewModel.messages,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width:
                    context.dynamicWidth(context.smallWidthPhone ? 275 : 325),
                    child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Ara...',
                          suffixIcon: InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.search,
                                color: AppColor.customGrey.shade700,
                              )),
                        )),
                  ),
                  CustomCircleButton(
                    icon: Ionicons.options_outline,
                  ),
                ],
              ),
              SizedBox(
                height: context.dynamicHeight(75),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ActionChip(
                      onPressed: () => viewModel.selectToyType(index: index),
                      backgroundColor: viewModel
                          .chipColors[index % viewModel.chipColors.length],
                      label: Text(
                        viewModel.toyTypes[index].title ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: context.dynamicWidth(5),
                    ),
                    itemCount: viewModel.toyTypes.length),
              ),
              HomeToysWidget(
                  toys: viewModel.toys,
                  onTap: (index) => viewModel.navigateToDetail(index))
            ],
          ),
        ),
      ),
    );
  }
}
