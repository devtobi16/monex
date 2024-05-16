import 'package:flutter/material.dart';
import 'package:monex/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isValid = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      // Perform login
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
                    onTap: _signUp,
                    child: Container(
                      height: 50,
                      width: 375,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
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
                          context, MaterialPageRoute(builder: (_) => LogIn()));
                    },
                    child: Text(
                      "Already have an account?",
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
