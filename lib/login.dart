import 'package:flutter/material.dart';
import 'package:monex/forgotPassword.dart';
import 'package:monex/signUp.dart';
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

  String? emailError;
  String? passwordError;
  bool loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        )
            .then((value) =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Home())));
        setState(() {
          emailError = null;
          passwordError = null;
        });
      } on FirebaseAuthException catch (error) {
        setState(() {
          emailError = null;
          passwordError = error.message;
        });
      } catch (e, s) {
        print(e);
        print(s);
      }
      setState(() {
        loading = false;
      });
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
                  if (emailError != null || passwordError != null)
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          if (emailError != null)
                            Text(
                              emailError!,
                              style: TextStyle(color: Colors.red),
                            ),
                          if (passwordError != null)
                            Text(
                              passwordError!,
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                  SizedBox(
                    width: 375,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: emailError == null
                            ? Colors.grey[200]
                            : Colors.red.withOpacity(0.1),
                        hintText: 'E-mail',
                        prefixIcon: Icon(Icons.person,
                            color: emailError == null
                                ? Colors.black
                                : Colors.red),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: emailError == null
                                  ? Colors.blue
                                  : Colors.red),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.red), // Change border color to red
                        ),
                      ),
                      onChanged: (_) {
                        setState(() {
                          emailError = null;
                        });
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                          setState(() {
                            emailError = 'Invalid email';
                          });
                          return null;
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
                            color: passwordError == null
                                ? Colors.black
                                : Colors.red),
                        filled: true,
                        fillColor: passwordError == null
                            ? Colors.grey[200]
                            : Colors.red.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: passwordError == null
                                  ? Colors.blue
                                  : Colors.red),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.red), // Change border color to red
                        ),
                      ),
                      onChanged: (_) {
                        setState(() {
                          passwordError = null;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            passwordError = 'Password cannot be empty';
                          });
                          return null;
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
