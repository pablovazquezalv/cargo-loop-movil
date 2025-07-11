import 'dart:convert';
import 'package:cargo_loop_app/models/user.dart';
import 'package:cargo_loop_app/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  /// Login y guarda token + datos de usuario en SharedPreferences
  Future<User?> login(String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/client/loginWithMail'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': phone, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Login exitoso: $data');

        final token = data['token'];
        final userData = data['0']; // El objeto del usuario

        // Guardar en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setInt('user_id', userData['id']);
        await prefs.setString('user_name', userData['name']);
        await prefs.setString('user_email', userData['email']);
        await prefs.setString('user_phone', userData['phone']);
        await prefs.setString('user_rol_id', userData['rol_id']);

        print('Token y datos de usuario guardados correctamente.');

        return User.fromJson(userData);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  /// Registro de usuario
  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/client/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'last_name': lastName,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
          'phone': phone,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        print('Registro exitoso: ${data['message']}');
        return {'success': true, 'message': data['message']};
      } else {
        print('Error: ${response.statusCode} - ${data['errors']}');
        return {
          'success': false,
          'message': data['errors']?.values.first[0] ?? 'Error al registrar.',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error de conexión: $e'};
    }
  }

  /// Obtener datos de usuario guardados
  Future<Map<String, dynamic>?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getInt('user_id');
    final userName = prefs.getString('user_name');
    final userEmail = prefs.getString('user_email');
    final userPhone = prefs.getString('user_phone');
    final userRolId = prefs.getInt('user_rol_id');

    if (token != null && userId != null) {
      return {
        'token': token,
        'id': userId,
        'name': userName,
        'email': userEmail,
        'phone': userPhone,
        'rol_id': userRolId,
      };
    } else {
      return null; // No hay sesión guardada
    }
  }

  /// Cerrar sesión
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('Sesión cerrada y datos eliminados.');
  }
}
