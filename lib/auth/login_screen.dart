import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isCreatingAccount = true;
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'CARGA LOOP',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight:
                      FontWeight.bold, //Color.fromRGBO(26, 0, 176, 107),
                  color: const Color.fromRGBO(26, 0, 176, 1),
                ),
              ),
              SizedBox(height: 40),
              ToggleButtons(
                isSelected: [!isCreatingAccount, isCreatingAccount],
                onPressed: (int index) {
                  setState(() {
                    isCreatingAccount = index == 1;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                selectedColor: Colors.white,
                fillColor: Color.fromRGBO(26, 0, 176, 1),
                borderColor: Color.fromRGBO(26, 0, 176, 1),
                selectedBorderColor: Colors.blue.shade800,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navega a la pantalla de inicio de sesión
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Iniciar Sesión'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navega a la pantalla de registro
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Crear Cuenta'),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Teléfono',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Ingresa tu número',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(26, 0, 176, 1),
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(26, 0, 176, 1),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // llamar a la función de inicio de sesión
                    _login();
                  },
                  child: Text(
                    'Enviar Código',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showErrorDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSuccessDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Éxito'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //login
  Future<void> _login() async {
    final String phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      await _showErrorDialog('Por favor, completa todos los campos.');
      return;
    }

    // Simulación de inicio de sesión exitoso
    await _showSuccessDialog('Inicio de sesión exitoso');
    Navigator.pushNamed(context, '/home');
  }
}
