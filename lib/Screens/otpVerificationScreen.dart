import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatefulWidget {
  OtpVerificationScreen({Key? key, required this.phoneController})
      : super(key: key);
  final String phoneController;
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late TextEditingController _otpController;
  late TextEditingController _phoneController;
  final _auth = FirebaseAuth.instance;
  late bool _keyBoardEnabled;
  final _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String _verificationId = '';

  @override
  void initState() {
    _otpController = TextEditingController();
    _phoneController = TextEditingController(text: widget.phoneController);
    _keyBoardEnabled = false;
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future phoneVerification() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneController.text,
        verificationCompleted: (credential) async {
          await _auth
              .signInWithCredential(credential)
              .then((value) => print("You are signed in successfully"));
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendtoken) {
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  Future<bool> verifyOTP() async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: _verificationId, smsCode: _otpController.text));

    return credentials.user != null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFCFD),
      appBar: AppBar(
        backgroundColor: Color(0xFFFBFCFD),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/wheelie_light.png',
                  height: 300,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Enter OTP",
                style: TextStyle(
                    fontSize: 40,
                    color: Color(0xFF1E2944),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "We have sent the code verification to your phone number",
                style: TextStyle(color: Colors.grey[700], fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  TextFormField(
                    controller: _phoneController,
                    enabled: _keyBoardEnabled,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: MediaQuery.of(context).size.width * 0.4,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _keyBoardEnabled = true;
                        });
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.edit),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Text(
                    "Request OTP",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
