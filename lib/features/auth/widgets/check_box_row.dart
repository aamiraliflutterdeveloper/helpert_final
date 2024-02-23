import 'package:flutter/material.dart';

class TOSCheckBox extends StatefulWidget {
  final ValueChanged<bool?>? onChanged;
  final String title;
  final bool checkBoxValue;
  const TOSCheckBox(
      {Key? key,
      required this.title,
      required this.onChanged,
      required this.checkBoxValue})
      : super(key: key);

  @override
  State<TOSCheckBox> createState() => _TOSCheckBoxState();
}

class _TOSCheckBoxState extends State<TOSCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 10),
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            value: widget.checkBoxValue,
            onChanged: widget.onChanged,
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
                bottom:
                    widget.title == 'I am currently working here' ? 8.0 : 0),
            child: Text(
              widget.title,
              style: const TextStyle(color: Color(0xFF666666)),
            ),
          ),
        )
      ],
    );
  }
}
