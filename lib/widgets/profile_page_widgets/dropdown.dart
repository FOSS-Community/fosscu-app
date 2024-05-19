import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';

class DropDown extends StatefulWidget {
  final ValueChanged<String>? onValueChanged;
  const DropDown({
    this.onValueChanged,
    super.key,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<String> values = [
    'Select any role',
    'Developer',
    'Writer',
    'Designer',
    'Community Ops',
    'Create your own role!'
  ];
  String dropDownValue = '';

  @override
  void initState() {
    dropDownValue = values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: darkGreyColor,
      borderRadius: BorderRadius.circular(10),
      value: dropDownValue,
      elevation: 16,
      underline: Container(
        height: 2,
        color: brightGreyColor,
      ),
      items: values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          dropDownValue = value!;
          DropDownValueHolder.setDropDownValue(dropDownValue);
        });
        if (widget.onValueChanged != null) {
          widget.onValueChanged!(dropDownValue);
        }
      },
    );
  }
}

class DropDownValueHolder {
  static String dropDownValue = '';

  static void setDropDownValue(String value) {
    dropDownValue = value;
  }

  static String getDropDownValue() {
    return dropDownValue;
  }
}
