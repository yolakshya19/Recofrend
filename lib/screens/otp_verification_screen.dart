import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:recofrend/screens/home/home_screen.dart';
import 'package:recofrend/screens/profile_details_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phonenumber;
  final bool showAlert;
  const OtpVerificationScreen({
    super.key,
    required this.phonenumber,
    this.showAlert = false,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String otpCode = '';
  bool showValidationMsg = false;
  bool isVerifyingOtp = false;
  TextEditingController otpController = TextEditingController();

  void verifyOtp() async {
    setState(() {
      isVerifyingOtp = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return; // ✅ Add this line

    // setState(() {
    //   isVerifyingOtp = false;
    // });
    final firstDigit = widget.phonenumber[0];
    if (int.parse(firstDigit) % 2 == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileDetailsScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.showAlert) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text("OTP Sent"),
            content: Text("OTP has been sent to ${widget.phonenumber}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1FB),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(21), // adjust for roundness
                child: Image.asset(
                  'assets/logo.jpg',
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'Welcome to Recofrend',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Enter the verfication code sent to',
                style: TextStyle(color: Color.fromARGB(255, 68, 68, 68)),
              ),

              Text(
                widget.phonenumber,
                style: TextStyle(color: Color.fromARGB(255, 68, 68, 68)),
              ),

              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Verification Code",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: showValidationMsg ? Colors.red : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              PinCodeTextField(
                controller: otpController,
                appContext: context,
                length: 6,
                // autoFocus: false,
                // obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: Colors.black,
                  selectedColor: Colors.blue,
                  inactiveColor: Colors.grey,
                ),
                cursorColor: Colors.black,
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    otpCode = value;
                    showValidationMsg = value.length < 6;
                  });
                },
              ),

              if (showValidationMsg)
                const Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Text(
                    "OTP must be 6 digits",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: otpCode.length == 6
                      ? () {
                          verifyOtp();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isVerifyingOtp
                        ? Colors.grey
                        : const Color(0xFF00AEEF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isVerifyingOtp
                      ? const Text(
                          "Verifying OTP.....",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      : Text(
                          "Verify OTP",
                          style: TextStyle(
                            fontSize: 16,
                            color: otpCode.length == 6
                                ? Colors.white
                                : const Color.fromARGB(255, 133, 131, 131),
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    await Future.delayed(Duration(milliseconds: 500));
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, // Blue button
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Change Phone Number",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    otpController.clear();
                    setState(() {
                      otpCode = '';
                      showValidationMsg = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('OTP resent to ${widget.phonenumber}'),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white, // Blue button
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
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
}
