import 'package:flutter/material.dart';

class PasswordUpdated extends StatefulWidget {
  const PasswordUpdated({Key? key});

  @override
  State<PasswordUpdated> createState() => _PasswordUpdatedState();
}

class _PasswordUpdatedState extends State<PasswordUpdated> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    foregroundDecoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/passwordUpdate.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Password Updated'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
