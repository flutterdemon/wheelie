import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wheelie/main.dart';
import './editProfileScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    } finally {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/wheelie_light.png', height: 150),
            SizedBox(
              height: 20,
            ),
            EmailInputField(
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: (value) => EmailValidator.validate(value)
                  ? null
                  : "Please enter valid email address",
            ),
            SizedBox(
              height: 20,
            ),
            PasswordInputField(
              hintText: "Password",
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Password cannot be empty';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                RegExp regex = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                if (!regex.hasMatch(value)) {
                  return "Password should contain upper,lower,digit and Special character ";
                }

                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Processing Data');
                      signIn();
                    }
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RichText(
              text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                        text: "Sign Up",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.toggleView();
                          })
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailInputField extends StatelessWidget {
  EmailInputField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.validator,
  });
  final TextInputType keyboardType;
  final String hintText;
  final TextEditingController controller;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        validator: (value) => validator(value),
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.grey[300],
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class PasswordInputField extends StatefulWidget {
  PasswordInputField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.validator,
  });
  final TextInputType keyboardType;
  final String hintText;
  final TextEditingController controller;
  final Function validator;

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  late bool _passwordVisibility;

  @override
  void initState() {
    _passwordVisibility = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        obscureText: _passwordVisibility,
        validator: (value) => widget.validator(value),
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: Colors.grey[300],
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _passwordVisibility = !_passwordVisibility;
                });
              },
              icon: Icon(
                _passwordVisibility ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              )),
        ),
      ),
    );
  }
}
