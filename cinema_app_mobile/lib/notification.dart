import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class NotificationApi{

     static AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title // description
    importance: Importance.high,
    playSound: true);

    static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('A bg message just showed up :  ${message.messageId}');
}

    static  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();

  static void configNotificationApi()async 
  {


    
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   print("TOKEN ");
   print(await FirebaseMessaging.instance.getToken());
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

   await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
   );
   }
}