import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseUtils {
  static TextEditingController textEditingController = TextEditingController();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize Firebase for basic setup
  Future<void> initFirebase() async {
    try {
      await Firebase.initializeApp();

      // Initialize local notifications
      const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initSettings = InitializationSettings(android: androidSettings);
      await _localNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          print("Notification tapped: ${response.payload}");
        },
      );

      FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }

  // Initialize listeners for the home screen
  Future<void> initFirebaseHome() async {
    try {
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        await processNotification(message: initialMessage.data);
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print("onMessage ${DateTime.now()}");
        if (message.notification != null) {
          await _showLocalNotification(
            title: message.notification!.title ?? "No Title",
            body: message.notification!.body ?? "No Body",
            payload: message.data.toString(),
          );
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) async {
        await processNotification(message: event.data);
      });
    } catch (e) {
      print("Error in initFirebaseHome: $e");
    }
  }

  // Request notification permissions
  static Future<bool> reqForNotification() async {
    try {
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        announcement: true,
        sound: true,
      );

      if (await _localNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission() ==
          true) {
        print("Local notification permission granted");
      }

      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      print("Error requesting notification permission: $e");
      return false;
    }
  }

  static Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'Firebase_demo',
      channelDescription: 'Channel for FCM notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      ticker: 'firebase ticker',
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  static Future<void> processNotification({
    required Map<String, dynamic> message,
  }) async {
    try {
      String redirectionUrl = message["redirection_url"]?.toString() ?? "";
      String type = message["type"]?.toString() ?? "";
      String eventTitle = message["event_title"]?.toString() ?? "";
      String typeSlug = message["type_slug"]?.toString() ?? "";
      // Add your redirection logic here
    } catch (e) {
      print("Error processing notification: $e");
    }
  }

  static Future<void> requestFirebaseToken() async {
    try {
      _firebaseMessaging.onTokenRefresh.listen((token) {
        print("Token refreshed: $token");
      });

      String? token = await _firebaseMessaging.getToken();
      print("Initial token: $token");
      textEditingController.text = token!;
        } catch (e) {
      print("Error getting Firebase token: $e");
    }
  }

  static Future<void> firebaseSetUnsetTopic({
    required bool isSubscribe,
    required String strTopic,
  }) async {
    try {
      if (isSubscribe) {
        await _firebaseMessaging.subscribeToTopic(strTopic);
        print("Subscribed to topic: $strTopic");
      } else {
        await _firebaseMessaging.unsubscribeFromTopic(strTopic);
        print("Unsubscribed from topic: $strTopic");
      }
    } catch (e) {
      print("Error managing topic subscription: $e");
    }
  }
}

// Background message handler (top-level function)
// Create this function outside the class or publically
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  print("Background - Title: ${message.notification?.title}");
  print("Background - Body: ${message.notification?.body}");
  print("Background - Payload: ${message.data}");

  if (message.notification != null) {
    await FirebaseUtils._showLocalNotification(
      title: message.notification!.title ?? "No Title",
      body: message.notification!.body ?? "No Body",
      payload: message.data.toString(),
    );
  } else if (message.data.isNotEmpty) {
    await FirebaseUtils._showLocalNotification(
      title: message.data['title'] ?? "No Title",
      body: message.data['body'] ?? "No Body",
      payload: message.data.toString(),
    );
  }
}