import 'dart:convert';
import 'package:cargo_loop_app/models/user.dart';
import 'package:cargo_loop_app/utils/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<User?> login(String phone) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/client/loginWithPhone'),
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
}
