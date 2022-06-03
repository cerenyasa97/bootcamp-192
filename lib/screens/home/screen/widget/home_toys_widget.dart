import 'package:flutter/material.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/screens/home/model/toy_model.dart';
import 'package:swapy/screens/home/screen/widget/toy_card.dart';

class HomeToysWidget extends StatelessWidget {
  final List<Toy> toys;
  final Function(int) onTap;
  final Function(int)? swapDone;
  final bool showSwapDoneButton;

  const HomeToysWidget(
      {Key? key,
      required this.toys,
      required this.onTap,
      this.swapDone,
      this.showSwapDoneButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: context.dynamicHeight(10),
      crossAxisSpacing: context.dynamicWidth(10),
      childAspectRatio: .6,
      children: List.generate(
          toys.length,
          (index) => ToyCard(
              toy: toys[index],
              onTap: () => onTap(index),
              swapDone: () {
                if (swapDone != null) swapDone!(index);
              },
              showSwapDoneButton: showSwapDoneButton)),
    );
  }
}
