// import 'dart:js';

// import 'package:fashion_guru/change_pass_screen.dart';
// import 'dart:js';

// import 'dart:js';


import 'package:fashion_guru/screens/add_product_screen.dart';
import 'package:fashion_guru/screens/admin_portal.dart';
import 'package:fashion_guru/screens/admin_view_product_screen.dart';
import 'package:fashion_guru/screens/admin_view_user_screen.dart';
import 'package:fashion_guru/screens/change_pass_screen.dart';
import 'package:fashion_guru/screens/checkout_screen.dart';
import 'package:fashion_guru/screens/dashboard_screen.dart';
import 'package:fashion_guru/screens/delivery_address_screen.dart';
import 'package:fashion_guru/screens/forgetpass_screen.dart';
import 'package:fashion_guru/screens/home_screen.dart';
import 'package:fashion_guru/screens/login_screen.dart';
import 'package:fashion_guru/screens/mycart_screen.dart';
import 'package:fashion_guru/screens/order_details_screen.dart';
import 'package:fashion_guru/screens/order_history_screen.dart';
import 'package:fashion_guru/screens/product_detail_screen.dart';
import 'package:fashion_guru/screens/resulted_products.dart';
import 'package:fashion_guru/screens/signup_screen.dart';
import 'package:fashion_guru/screens/splash_screen.dart';
import 'package:fashion_guru/screens/user_details_screen.dart';
import 'package:fashion_guru/screens/vendor_profile.dart';
import 'package:fashion_guru/screens/view_orders.dart';
import 'package:fashion_guru/screens/view_products_screen.dart';
import 'package:fashion_guru/services/firebase_api.dart';
// import 'package:fashion_guru/temp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey:'AIzaSyAvlvwsswgPx3eQO_is3ohF0blrSoUEFZ0',appId:'1:386305183847:android:7b245862f23670cd5a04c2',messagingSenderId:'386305183847',projectId:'fashion-guru-8635b'));

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await FirebaseApi(navigatorKey).initNotifications();

  var loggedInUser,orderId;
  runApp(
    MaterialApp(
      title: 'Fashion Guru',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFF5A811, <int,Color>{50: Color(0XFFFF4F5A),
          100: Color(0xFFF5A811),
          200: Color(0xFFF5A811),
          300: Color(0xFFF5A811),
          400: Color(0xFFF5A811),
          500: Color(0xFFF5A811),
          600: Color(0xFFF5A811),
          700: Color(0xFFF5A811),
          800: Color(0xFFF5A811),
          900: Color(0xFFF5A811),}),
        fontFamily: 'Poppins',// Change to your primary color
        hintColor: const Color(0xFFF5A811), // Change to your accent color
        // fontFamily: 'Roboto', // Change to your desired font
      ),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      //   useMaterial3: true,
      // ),
      debugShowCheckedModeBanner: false,
      // initialRoute: 'temp',
      // initialRoute: 'ResultedProducts',
      navigatorKey: navigatorKey  ,
      initialRoute: 'SplashScreen',
      routes: {
        'SplashScreen': (context) => const SplashScreen(),
        'LoginScreen': (context) => const LoginScreen(),
        'SignupScreen': (context) => const SignupScreen(),
        'ForgetPassword': (context) => const ForgetpassScreen(),
        // 'ChangePassword': (context) => const ChangePassScreen(),
        // 'temp': (context) => const temp(),
        'HomeScreen' : (context) => HomeScreen(loggedInUser: loggedInUser),
        'DashboardScreen': (context) => const DashboardScreen(),
        'VendorProfile': (context) => const VendorProfile(),
        'AdminPortal' : (context) => const AdminPortal(),
        'ViewProduct' : (context) => const ViewProductScreen(),
        'AdminViewProduct' : (context) => const AdminViewProductScreen(),
        'ViewUsers' : (context) => const ViewUserScreen(),
        'UserDetails' : (context) => const UserDetailScreen(),
        'AddProduct' : (context) => const AddProduct(isUpdateProduct: '',),
        'ProductDetails' : (context) => const ProductDetailScreen(productDetails: {},),
        'MyCart' : (context) => const MyCartScreen(),
        'CheckoutScreen' : (context) => const CheckoutScreen(),
        'DeliveryAddress' : (context) => const DeliveryAddressScreen(),
        'OrderHistory' : (context) => const OrderHistoryScreen(),
        'ViewOrder' : (context) => const ViewOrders(),
        // 'ResultedProducts' : (context) => const ResultedProducts(),


      },
    ),
  );
}
