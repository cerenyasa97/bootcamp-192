import 'package:flutter/material.dart';
import 'package:swapy/screens/home/view_model/home_view_model.dart';

class HomeBottomNavigation extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeBottomNavigation({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 4,
      currentIndex: viewModel.selectedTab,
      onTap: (tab) {
        viewModel.selectedTab = tab;
      },
      iconSize: 30,
      selectedFontSize: 0,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: viewModel.chipColors[0],
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border, color: viewModel.chipColors[1]),
            label: ''),
        BottomNavigationBarItem(
            icon:
                Icon(Icons.add_circle_outline, color: viewModel.chipColors[2]),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.refresh, color: viewModel.chipColors[3]),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: viewModel.chipColors[4]),
            label: ''),
      ],
    );
  }
}
