import 'package:flutter/material.dart';
import 'package:monex/forgotPassword.dart';
import 'package:monex/signUp.dart';
import 'package:monex/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monex/home.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isValid = true;

  FirebaseAuthService _authService =
      FirebaseAuthService(); // Instantiate the FirebaseAuthService

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      // Perform login
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _authService.signInWithEmailAndPassword(
          email, password); // Use the _authService instance to sign in
      if (user != null) {
        print('Logged In successfully');
        Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
      } else {
        print('Error Occurred');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Container(
                    height: 125,
                    width: 125,
                    foregroundDecoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  if (!_isValid)
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Invalid email or password",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(
                    width: 375,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _isValid
                            ? Colors.grey[200]
                            : Colors.red.withOpacity(0.1),
                        hintText: 'E-mail',
                        prefixIcon: Icon(Icons.person,
                            color: _isValid ? Colors.black : Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: _isValid ? Colors.blue : Colors.red),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      onChanged: (_) {
                        if (!_isValid) {
                          setState(() {
                            _isValid = true;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          setState(() {
                            _isValid = false;
                          });
                          return 'Invalid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 375,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock,
                            color: _isValid ? Colors.black : Colors.red),
                        filled: true,
                        fillColor: _isValid
                            ? Colors.grey[200]
                            : Colors.red.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: _isValid ? Colors.blue : Colors.red),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      onChanged: (_) {
                        if (!_isValid) {
                          setState(() {
                            _isValid = true;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            _isValid = false;
                          });
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: _signIn,
                    child: Container(
                      height: 50,
                      width: 375,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ForgotPassword()),
                      );
                    },
                    child: Text(
                      'FORGOT PASSWORD',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SignUp()));
                    },
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
