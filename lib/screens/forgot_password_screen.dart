import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'otp_screen.dart';  // Import the OTPScreen

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _mobileController = TextEditingController();

  Future<void> _requestOtp() async {
    final mobileNo = _mobileController.text;
    final response = await ApiService.requestOtp(mobileNo); // Make sure this API method exists

    if (response == 'OTP sent') { // Adjust based on actual response
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpScreen(mobileNo: mobileNo)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestOtp,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
