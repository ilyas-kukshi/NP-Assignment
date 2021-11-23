import 'package:flutter/material.dart';
import 'package:npassignment/auth/login.dart';
import 'package:npassignment/dashboard/all_products.dart';
import 'package:npassignment/dashboard/product_details.dart';
import 'package:npassignment/models/product_model.dart';
import 'package:npassignment/onboarding/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        buttonTheme: const ButtonThemeData(buttonColor: Color(0xff33D1DB)),
        textTheme: const TextTheme(
            headline1:
                TextStyle(color: Colors.black, fontFamily: 'Times New Roman'),
            headline2:
                TextStyle(color: Colors.white, fontFamily: 'Times New Roman'),
            headline3:
                TextStyle(color: Colors.black, fontFamily: 'Source Sans Pro'),
            headline4:
                TextStyle(color: Colors.white, fontFamily: 'Source Sans Pro')),
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: routing,
      home: const SplashScreen(),
    );
  }

  Route routing(RouteSettings settings) {
    switch (settings.name) {
       case '/login':
        return PageTransition(
            child: const Login(), type: PageTransitionType.leftToRight);
      case '/allproducts':
        return PageTransition(
            child: const AllProducts(), type: PageTransitionType.leftToRight);
      case '/productDetails':
        return PageTransition(
            child: ProductDetails(
              productsModel: settings.arguments as ProductsModel,
            ),
            type: PageTransitionType.leftToRight);

      default:
        return PageTransition(
            child: const AllProducts(), type: PageTransitionType.leftToRight);
    }
  }
}
