import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'reset_password_screen.dart';  // Import the ResetPasswordScreen

class OtpScreen extends StatefulWidget {
  final String mobileNo;

  OtpScreen({required this.mobileNo});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  Future<void> _verifyOtp() async {
    final otp = _otpController.text;
    final response = await ApiService.verifyOtp(widget.mobileNo, otp); // Make sure this API method exists

    if (response == 'OTP verified') { // Adjust based on actual response
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen(mobileNo: widget.mobileNo)),
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
      appBar: AppBar(title: Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
