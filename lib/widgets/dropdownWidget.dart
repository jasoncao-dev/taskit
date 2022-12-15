import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final Function onDropdownChange;

  const DropdownWidget({Key? key, required this.onDropdownChange})
      : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  List<String> items = [
    'Name',
    'Note',
    'Tag',
  ];
  late String selectedValue = items.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          'Select Item',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
          widget.onDropdownChange(value);
        },
        buttonHeight: 40,
        buttonWidth: 60,
        itemHeight: 40,
      ),
    );
  }
}
