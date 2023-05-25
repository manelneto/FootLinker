import 'package:app/view/pages/schedule_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  GlobalKey<NavigatorState> navigatorKey;
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationController(this.navigatorKey) {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
    _setupAndroidDetails();
  }

  _setupAndroidDetails() {
    androidDetails = const AndroidNotificationDetails(
      'Schedule_notifications',
      'Schedule',
      channelDescription: 'This channel is for matches from schedule',
      importance: Importance.max,
      priority: Priority.max,
    );
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  _onDidReceiveNotificationResponse(NotificationResponse response) {
    if (response.payload == null) return;

    if (response.payload == 'Schedule') {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const SchedulePage(),
        ),
      );
    }
  }

  showLocalNotification(RemoteNotification notification, String? payload) {
    localNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: payload,
    );
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const SchedulePage(),
        ),
      );
    }
  }
}
