import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/widget/button/custom_circle_button.dart';
import 'package:swapy/screens/add_toy/screen/add_toy.dart';
import 'package:swapy/screens/chat/chat_service/cloud_massaging.dart';
import 'package:swapy/screens/home/screen/widget/home_body.dart';
import 'package:swapy/screens/home/screen/widget/home_bottom_navigation.dart';
import 'package:swapy/screens/my_toys/screen/my_toys.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: HomeBottomNavigation(
        onChanged: (index) {
          setState(() {
            selectedTab = index;
          });
        },
      ),
    );
  }

  Widget getBody(){
    switch(selectedTab){
      case 0:
        return HomeBody();
      case 1:
        return MyToys();
      case 2:
        return AddToy();
      case 3:
        return HomeBody(); // Buraya profil sayfasının classı gelecek
      default:
        return HomeBody();
    }
  }
}
