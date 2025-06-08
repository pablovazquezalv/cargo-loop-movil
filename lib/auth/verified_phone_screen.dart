import 'package:flutter/material.dart';

class VerifiedPhoneScreen extends StatefulWidget {
  const VerifiedPhoneScreen({super.key});

  @override
  State<VerifiedPhoneScreen> createState() => _VerifiedPhoneScreenState();
}

class _VerifiedPhoneScreenState extends State<VerifiedPhoneScreen> {
  final _controllers = List.generate(4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              Center(
                child: Text(
                  'Codigo de Autenticación',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(26, 0, 176, 1),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Ingresa el codigo que se te mando al telefono.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 60,
                    child: TextField(
                      controller: _controllers[index],
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              Text(
                'No te llego ningún correo? Reenviar',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la lógica para verificar el código
                    // y navegar a la siguiente pantalla.
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(26, 0, 176, 1),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Ingresar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              Spacer(),
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      size: 40,
                      color: Color.fromRGBO(26, 0, 176, 1),
                    ),
                    Text(
                      'CARGA\nLOOP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(26, 0, 176, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
