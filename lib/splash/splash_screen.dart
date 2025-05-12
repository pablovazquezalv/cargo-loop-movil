import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navegar a Login después de 3 segundos
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Carga-loop-icon.png', width: 150),
            SizedBox(height: 20),
            Text(
              'CARGA LOOP',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(26, 0, 176, 1),
              ),
            ),
            // SizedBox(height: 10),
            // CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
