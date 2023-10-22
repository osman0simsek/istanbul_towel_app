// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:istanbul_towel_stock_app/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 2 saniye sonra otomatik olarak giriş ekranına geçiş yapacak Future.delayed kullanımı
    Future.delayed(Duration(seconds: 2), () {
      navigateToHome(context);
    });
  }

  void navigateToHome(BuildContext context) {
    // 'Navigator' ile yeni sayfaya geçiş yapabiliriz ve Splash ekranı için geri dönmemesi için 'replace' kullanabiliriz.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/istanbul_towel_logo.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 16),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.deepOrangeAccent), // Yükleme göstergesi rengi
            ),
          ],
        ),
      ),
    );
  }
}
