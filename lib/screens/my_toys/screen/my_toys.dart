import 'package:flutter/material.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/screens/home/screen/widget/home_toys_widget.dart';
import 'package:swapy/screens/my_toys/view_model/my_toyes_view_model.dart';

class MyToys extends StatelessWidget {
  const MyToys({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<MyToysViewModel>(
        vmBuilder: MyToysViewModel(), builder: _buildPage);
  }

  Widget _buildPage(BuildContext context, MyToysViewModel viewModel) =>
      Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            children: [
              Image.asset(
                ImageConstants.myToys,
                height: context.dynamicHeight(40),
              ).widgetPadding(),
              HomeToysWidget(
                  toys: viewModel.toys,
                  onTap: (index) => viewModel.navigateToDetail(index),
                  swapDone: (index) async => await viewModel.swapDone(index),
                  showSwapDoneButton: true)
            ],
          ),
        ),
      );
}
