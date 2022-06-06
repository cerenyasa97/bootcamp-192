import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapy/core/extension/context_extension.dart';

class TextFieldWithLabel extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final int? maxLine;
  final List<String?>? comboItems;
  final Function(String?)? itemSelected;
  final bool? isEnabled;
  String? selectedItem;

  TextFieldWithLabel(
      {Key? key,
      required this.controller,
      required this.label,
      required this.hintText,
      this.maxLine,
      this.comboItems,
      this.itemSelected,
      this.isEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: comboItems == null ? null : () => showCombo(context),
          child: TextField(
              focusNode: FocusNode(),
              controller: controller,
              enabled: isEnabled ?? comboItems == null,
              decoration: InputDecoration(hintText: hintText),
              maxLines: maxLine),
        ),
      ],
    );
  }

  showCombo(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
              height: context.dynamicHeight(200),
              color: Colors.white,
              child: CupertinoPicker(
                // This is called when selected item is changed.
                onSelectedItemChanged: (int selectedItem) {
                  this.selectedItem = comboItems?[selectedItem];
                  if (itemSelected != null && this.selectedItem != null)
                    itemSelected!(this.selectedItem!);
                },
                itemExtent: context.dynamicHeight(50),
                children:
                    List<Widget>.generate(comboItems?.length ?? 0, (int index) {
                  return Center(
                    child: Text(
                      comboItems?[index] ?? '',
                    ),
                  );
                }),
              ),
            ));
  }
}
