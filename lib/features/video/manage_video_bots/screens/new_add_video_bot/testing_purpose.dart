import 'package:flutter/material.dart';


class TestingPurpose extends StatelessWidget {
  const TestingPurpose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}
