import 'package:flutter/material.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        Navigator.pop(context);
      },
      child: Image.asset(
        'assets/images/floatingicon.png',
        height: 30,
        color: Colors.white,
      ),
    );
  }
}
