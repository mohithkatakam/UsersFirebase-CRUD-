import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:users/booking_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebadeMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(); // options: DefaultFirebaseConfig.platformOptions
  print('Handling a background message ${message.messageId}');
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebadeMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookingSlots(),
    );
  }
}
