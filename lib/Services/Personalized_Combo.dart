import 'package:flutter/material.dart';

class MyCombo extends StatefulWidget {

  final List<String> options;
  final String text;
  final void Function(String selectedItem) onItemSelected;

  MyCombo({required this.options, required this.text, required this.onItemSelected});

  @override
  _MyComboState createState() => _MyComboState();
}

class _MyComboState extends State<MyCombo> {
  String selectedValue = 'Ninguno';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))
      ),
      child: Column(
        children: [
          SizedBox(height: 5,),
          Text(widget.text, style: TextStyle(color: Colors.grey, fontSize: 15),),
          Container(
            height: 50,
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedValue,
              onChanged: (String? value) {
                widget.onItemSelected(value.toString());
                setState(() {
                  selectedValue = value!;
                });
              },
              items: widget.options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}