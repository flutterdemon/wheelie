import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheelie/Utils/themeUtil.dart';
import 'package:wheelie/main.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _passwordController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Password Reset Email Sent",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 5),
      ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    } finally {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeOn = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/wheelie_light.png',
                      color: isDarkModeOn ? Colors.white : null,
                      height: 300,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Forgot",
                    style: TextStyle(
                        fontSize: 40,
                        color: Color(0xFF1E2944),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Password?",
                    style: TextStyle(
                        fontSize: 40,
                        color: Color(0xFF1E2944),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Don't worry!It happens. Please enter the address associated with your account.",
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email address",
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
                        if (_formKey.currentState!.validate()) {
                          resetPassword();
                        }
                      },
                      child: Text(
                        "Reset Password",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
