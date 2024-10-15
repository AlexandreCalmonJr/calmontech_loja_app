import 'package:emart_app/view/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'consts/consts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDeRT28xq8ii2KmfDL92hSUZDIeQveIIE8",
      appId: "1:97604060836:android:0386ce2fd62805c05a4831",
      messagingSenderId: "97604060836",
      projectId: "calmontechapp",
      storageBucket: "calmontechapp.appspot.com",
      androidClientId: "97604060836-android.apps.googleusercontent.com",
      databaseURL: "https://calmontechapp-default-rtdb.firebaseio.com/", // Add if necessary for Realtime Database
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: darkFontGrey),
          elevation: 0,
          backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
