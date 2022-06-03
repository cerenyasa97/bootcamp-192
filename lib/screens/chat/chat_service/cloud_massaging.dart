import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class CloudMessagingManager extends ChangeNotifier {
  CloudMessagingManager._() {
    init();
  }

  static CloudMessagingManager? _instance;

  static CloudMessagingManager get instance =>
      _instance ??= CloudMessagingManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;
  int badgeCount = 0;
  String? token;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      listenForegroundAndBackgroundMessages();

      _initialized = true;
    }
  }

  void listenForegroundAndBackgroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        badgeCount += 1;
        // TODO: local notification eklenecek
        notifyListeners();
      }
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      badgeCount += 1;
      // TODO: local notification eklenecek
      notifyListeners();
    });
  }

  Future requestToken() async {
    // For testing purposes print the Firebase Messaging token
    token = await _firebaseMessaging.getToken();
    debugPrint("FirebaseMessaging token: $token");
  }
}
