import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:swapy/core/constants/string/string_constants.dart';
import 'package:swapy/core/constants/theme/theme.dart';
import 'package:swapy/core/navigation/navigation_service.dart';
import 'package:swapy/core/navigation/router.dart';
import 'package:swapy/screens/chat/chat_service/cloud_massaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Directory document = await getApplicationDocumentsDirectory();

  Hive.init(document.path);

  await Hive.openBox(StringConstants.hiveBoxName);

  CloudMessagingManager.instance;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CloudMessagingManager.instance,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: swapyLightTheme,
          onGenerateRoute: AppRouter.generateRoute,
          navigatorKey: NavigationService.instance.navigationKey,
        ));
  }
}
