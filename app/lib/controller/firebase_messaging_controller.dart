import 'package:app/controller/notification_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingController {
  final NotificationController _notificationController;

  FirebaseMessagingController(this._notificationController);

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );

    _onMessage();
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _notificationController.showLocalNotification(
            notification, message.data['route']);
      }
    });
  }
}
