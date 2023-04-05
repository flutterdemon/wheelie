import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wheelie/Screens/otpVerificationScreen.dart';
import 'package:wheelie/main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNoConroller;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNoConroller = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNoConroller.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/wheelie_light.png', height: 150),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    child: UserInputField(
                      hintText: "First Name",
                      keyboardType: TextInputType.text,
                      controller: _firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: UserInputField(
                      hintText: "Last Name",
                      keyboardType: TextInputType.text,
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your last name";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              UserInputField(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IntlPhoneField(
                  controller: _phoneNoConroller,
                  keyboardType: TextInputType.phone,
                  initialCountryCode: 'KE',
                  decoration: InputDecoration(
                      hintText: "Phone Number",
                      fillColor: Colors.grey[300],
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
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
              PasswordInputField(
                hintText: "Confirm Password",
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmPasswordController,
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
                  if (value != _passwordController.text) {
                    return "Password does not match";
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
                      signUp();
                    },
                    child: Text(
                      "Register",
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
                          text: "Sign In",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              widget.toggleView();
                            }),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInputField extends StatelessWidget {
  UserInputField({
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
