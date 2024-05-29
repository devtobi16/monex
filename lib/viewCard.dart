import 'package:flutter/material.dart';

class ViewCard extends StatefulWidget {
  const ViewCard({super.key});

  @override
  State<ViewCard> createState() => _ViewCardState();
}

class _ViewCardState extends State<ViewCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
