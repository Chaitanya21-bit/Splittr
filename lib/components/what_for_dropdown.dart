import 'package:flutter/material.dart';

class WhatForDropdown extends StatefulWidget {
  const WhatForDropdown({super.key});

  @override
  MyDropDown createState() => MyDropDown();
}

class MyDropDown extends State<WhatForDropdown> {
  String? dropdownValue = 'Unknown';
  @override
  Widget build(BuildContext context) {
    final items = [
      'Unknown',
      'Food',
      'Travel',
      'Taxi',
      'Settle',
      'Other'
    ];

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    value: dropdownValue,
                    items: items.map((String items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}