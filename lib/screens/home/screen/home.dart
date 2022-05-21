import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/widget/button/custom_circle_button.dart';
import 'package:swapy/screens/home/screen/home_bottom_navigation.dart';
import 'package:swapy/screens/home/view_model/home_view_model.dart';
import 'package:swapy/screens/home/screen/toy_card.dart';

class Home extends StatelessWidget {
  final viewModel = HomeViewModel();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        vmBuilder: () => viewModel, builder: _buildPage);
  }

  Widget _buildPage(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
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
                  height: context.dynamicHeight(110),
                ),
                CustomCircleButton(
                  icon: Ionicons.chatbubble_ellipses_outline,
                )
              ],
            ),
            SizedBox(
              height: context.dynamicHeight(25),
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
              height: context.dynamicHeight(25),
            ),
            SizedBox(
              height: context.dynamicHeight(75),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Chip(
                        backgroundColor: viewModel
                            .chipColors[index % viewModel.chipColors.length],
                        label: Text(
                          viewModel.toyTypes[index],
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
            GridView.count(
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: context.dynamicHeight(10),
              crossAxisSpacing: context.dynamicWidth(10),
              childAspectRatio: .75,
              children: List.generate(20, (index) => ToyCard()),
            )
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavigation(
        viewModel: viewModel,
      ),
    );
  }
}
