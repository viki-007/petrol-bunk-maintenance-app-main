import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petrol_bunk_maintainence/controllers/splashscreen_controller.dart';
import 'screens/authenticate/login/login.dart';
import 'screens/home/calculator.dart';
import 'screens/home/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/calci', page: () => HomePage())
        ],
        debugShowCheckedModeBanner: false,
        title: 'Petrol Bunk Maintainence',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashScreenController screenController =
      Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color(0XFF003a68),
            height: Get.height,
            width: Get.width,
            child: Image.asset(
              "assets/Dreamimbue.png",
              fit: BoxFit.contain,
            )));
  }
}
