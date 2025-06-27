import 'dart:convert';
import 'package:cargo_loop_app/models/user.dart';
import 'package:cargo_loop_app/utils/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<User?> login(String phone) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/client/loginWithMail'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': phone}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

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
}
