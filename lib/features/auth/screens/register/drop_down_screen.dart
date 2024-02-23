import 'package:flutter/material.dart';

import '../../../../common_widgets/textfield/search_textformfield.dart';

class DropdownScreen extends StatefulWidget {
  final List list;
  final String title;

  const DropdownScreen({Key? key, required this.list, required this.title})
      : super(key: key);

  @override
  State<DropdownScreen> createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<DropdownScreen> {
  late int tappedIndex = -1;
  int? id;
  String value = '';
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.cancel,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchTextFormField(
              controller: controller,
              hintText: 'Search',
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        // shrinkWrap: true,
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return dropdownListTile(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }

  ListTile dropdownListTile(int index) {
    return ListTile(
      // tileColor: tappedIndex == index ? AppColors.acmeBlue : Colors.white,
      onTap: () {
        setState(() {
          tappedIndex = index;
          id = widget.list[index].id;
          value = widget.list[index].name;
          Navigator.pop(context, [value, id]);
        });
      },
      contentPadding:
          EdgeInsets.zero + const EdgeInsets.only(left: 16, right: 16),
      title: Text(
        widget.list[index].name,
      ),
    );
  }
}
