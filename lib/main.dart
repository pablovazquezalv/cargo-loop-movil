import 'package:cargo_loop_app/auth/choise_screen.dart';
import 'package:cargo_loop_app/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'auth/company_inputs_screen.dart';
import 'auth/documents_screen.dart';
import 'auth/login_screen.dart';
import 'auth/verified_phone_screen.dart';
import 'home/home_screen.dart';
import 'profile/profile_screen.dart';
import 'splash/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carga Loop',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/documents': (context) => DocumentsScreen(),
        '/choise': (context) => ChoiseScreen(),
        '/company': (context) => CompanyInputsScreen(),
        '/verify': (context) => VerifiedPhoneScreen(),
      },
    );
  }
}
