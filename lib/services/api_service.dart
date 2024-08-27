import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<bool> login(String mobile, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/UserController/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobileNo': mobile, 'password': password}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Login failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  // New register method
  static Future<String> register(String username, String password, String mobileNo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/UserController/addUser'),  // Updated endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password, 'mobileNo': mobileNo}),
      );

      if (response.statusCode == 200) {
        return response.body;  // Return the response body to display the message
      } else {
        print('Registration failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return 'Registration failed. Please try again.';
      }
    } catch (e) {
      print('Error during registration: $e');
      return 'Error during registration. Please try again.';
    }
  }



  // Request OTP method
  static Future<String> requestOtp(String mobileNo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/UserController/forgetpassword'),  // Adjust with your API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobileNo': mobileNo}),
      );
      return response.statusCode == 200 ? 'OTP sent' : 'Error: ${response.body}';
    } catch (e) {
      return 'Error: $e';
    }
  }

  // Verify OTP method
  static Future<String> verifyOtp(String mobileNo, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/UserController/verifyOtp'),  // Adjust with your API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobileNo': mobileNo, 'otp': otp}),
      );
      return response.statusCode == 200 ? 'OTP verified' : 'Error: ${response.body}';
    } catch (e) {
      return 'Error: $e';
    }
  }

  // Reset Password method
  static Future<String> resetPassword(String mobileNo, String newPassword, String confirmPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/UserController/resetPassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mobileNo': mobileNo,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword
        }),
      );
      return response.statusCode == 200
          ? 'Password reset successfully'
          : 'Error: ${response.body}';
    } catch (e) {
      return 'Error: $e';
    }
  }
}