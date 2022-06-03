import 'package:flutter/material.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/screens/home/view_model/home_view_model.dart';

class HomeBottomNavigation extends StatefulWidget {
  final Function(int) onChanged;

  const HomeBottomNavigation({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<HomeBottomNavigation> createState() => _HomeBottomNavigationState();
}

class _HomeBottomNavigationState extends State<HomeBottomNavigation> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 4,
      currentIndex: selectedIndex,
      onTap: (tab) {
        setState(() {
          selectedIndex = tab;
        });
        widget.onChanged(selectedIndex);
      },
      iconSize: 30,
      selectedFontSize: 0,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: chipColors[0],
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy_outlined, color: chipColors[1]),
            label: ''),
        BottomNavigationBarItem(
            icon:
                Icon(Icons.add_circle_outline, color: chipColors[2]),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.refresh, color: chipColors[3]),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: chipColors[4]),
            label: ''),
      ],
    );
  }

  List<MaterialColor> get chipColors =>
      [
        AppColor.customGreen,
        AppColor.customPurple,
        AppColor.customTurquoise,
        AppColor.customYellow,
        AppColor.customPink,
        AppColor.customBlue,
        AppColor.customOrange,
      ];
}
