import 'package:flutter/material.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/screens/add_toy/view_model/add_toy_view_model.dart';

class AddToy extends StatelessWidget {
  const AddToy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AddToyViewModel>(vmBuilder: AddToyViewModel(), builder: _buildPage);
  }

  Widget _buildPage(BuildContext context, AddToyViewModel viewModel) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        children: [
          Image.asset(
            ImageConstants.addToy,
            height: context.dynamicHeight(40),
          ).widgetPadding(),
        ],
      ),
    ),
  );
}
