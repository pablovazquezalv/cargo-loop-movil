import 'package:flutter/material.dart';

class ChoiseScreen extends StatefulWidget {
  const ChoiseScreen({super.key});
  @override
  State<ChoiseScreen> createState() => _ChoiseScreenState();
}

class _ChoiseScreenState extends State<ChoiseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Center(
                child: Text(
                  'CARGA LOOP',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(26, 0, 176, 1),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 100, color: Colors.grey[300]),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Define bien tu rumbo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Navega a la pantalla de empresa
                  Navigator.pushNamed(context, '/company');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(26, 0, 176, 1),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Estoy con una empresa',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navega a la pantalla de usuario
                  Navigator.pushNamed(context, '/verify');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(26, 0, 176, 1),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Soy un usuario',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
