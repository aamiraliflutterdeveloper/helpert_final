import 'package:flutter/material.dart';


class ShowDataWidget extends StatelessWidget {
  const ShowDataWidget(this.data, {Key? key}) : super(key: key);
  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(data),
    );
  }
}
