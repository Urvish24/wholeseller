import 'package:bwc/constant/constants.dart';
import 'package:bwc/provider/CustomerActionProvider.dart';
import 'package:bwc/provider/CustomerListProvider.dart';
import 'package:bwc/provider/EstimateNotificationProvider.dart';
import 'package:bwc/provider/ItemZohoListProvider.dart';
import 'package:bwc/provider/ItemsServerListProvider.dart';
import 'package:bwc/provider/LoginProvider.dart';
import 'package:bwc/provider/ProviderItemCreate.dart';
import 'package:bwc/ui/pages/EstimatesAdmin.dart';
import 'package:bwc/ui/pages/splash.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 255, 255, 1),
        canvasColor: appCanvascolor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) => print('Token ' + token));
  }

  @override
  void initState() {
    super.initState();
    _register();
    getMessage();

    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Colors.white,
              channelShowBadge: true,
              importance: NotificationImportance.Max,
              ledColor: Colors.white)
        ]);

   AwesomeNotifications().actionStream.listen((receivedNotification) {
     // show("CLICKED", context, green);
     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
       return EstimatesAdmin(true);
     }));
    });
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
     /* var model = Provider.of<EstimateNotificationProvider>(context, listen: false);
      model.reloadEstimate(true);*/
      FBroadcast.instance().broadcast("Key_Color", value: "s");
      setState(() => _message = message["notification"]["title"]);
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 10,

              channelKey: 'basic_channel',
              displayOnBackground: true,
              displayOnForeground: true,
              title: message["notification"]["title"],
              body: message["notification"]["body"]));

    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return EstimatesAdmin(true);
      }));
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return EstimatesAdmin(true);
      }));
      setState(() => _message = message["notification"]["title"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomerActionProvider>(
            create: (_) => CustomerActionProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<CustomerListProvider>(
            create: (_) => CustomerListProvider()),
        ChangeNotifierProvider<ItemsServerListProvider>(
            create: (_) => ItemsServerListProvider()),
        ChangeNotifierProvider<ProviderItemCreate>(
            create: (_) => ProviderItemCreate()),
        ChangeNotifierProvider<ItemZohoListProvider>(
            create: (_) => ItemZohoListProvider()),
        ChangeNotifierProvider<EstimateNotificationProvider>(
            create: (_) => EstimateNotificationProvider()),
      ],
      child: MaterialApp(
        title: 'Wholesaler',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(255, 255, 255, 1),
          canvasColor: appCanvascolor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash_screen(),
      ),
    );
  }
}
