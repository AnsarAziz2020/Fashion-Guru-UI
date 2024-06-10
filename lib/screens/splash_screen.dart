import 'dart:async';
import 'package:fashion_guru/components/toast_message.dart';
import 'package:fashion_guru/controllers/session.dart';
import 'package:fashion_guru/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/users.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_screen.dart';
// import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0.0; // Initial opacity value for the image

  @override
  void initState() {
    super.initState();
    getUserFromSession().then((result) {
      if (result['error']) {
        Timer(
          const Duration(seconds: 3),
          () {
            Navigator.pushNamed(context, 'LoginScreen');
          },
        );
      } else {
        Timer(
          const Duration(seconds: 3),
          () {
            Navigator.pushNamed(context, 'DashboardScreen');
          },
        );
      }
    }) .catchError((onError){
      showToast("Server Error");
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // Delay the appearance of the image with a fade-in effect
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacity = 1.0; // Set opacity to 1 for full visibility
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF5A811),
                  Color(0xFFF8F8F8),
                  Color(0xFFF8F8F8),
                  Color(0xFFF5A811)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Centered Image with Fade Transition
          Center(
            child: AnimatedOpacity(
              duration: Duration(seconds: 1), // Fade-in duration
              opacity: opacity,
              child: Image.asset(
                'images/logo.png', // Replace with your image URL
              ),
            ),
          ),
        ],
      ),
    );
  }
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//
//     // Future.delayed(const Duration(seconds: 5), () {
//     //   Navigator.of(context).pushReplacement(
//     //     MaterialPageRoute(
//     //       builder: (_) => const LoginScreen(),
//     //     ),
//     //   );
//     // });
//   }
//
//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: SystemUiOverlay.values);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         // color: Colors.white,
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//           Color(0xFFF5A811),
//           Color(0xFFF8F8F8),
//           Color(0xFFF8F8F8),
//           Color(0xFFF5A811)
//         ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//         child: AnimatedSplashScreen(
//           duration: 3000,
//           splash: 'images/logo.png',
//           nextScreen: const LoginScreen(),
//           splashTransition: SplashTransition.fadeTransition,
//         ),
//         // child: Column(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: const [
//         //     Icon(
//         //       Icons.shopping_cart,
//         //       size: 80,
//         //       color: Colors.black87,
//         //     ),
//         //     SizedBox(
//         //       height: 20,
//         //     ),
//         //     Text(
//         //       'Fashion Guru',
//         //       style: TextStyle(
//         //         fontWeight: FontWeight.w900,
//         //         fontSize: 38,
//         //         color: Colors.black87,
//         //       ),
//         //     ),
//         //   ],
//         // )),
//       ),
//     );
//   }
}
