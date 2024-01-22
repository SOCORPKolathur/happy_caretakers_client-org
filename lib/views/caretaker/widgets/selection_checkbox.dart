import 'package:flutter/material.dart';

class WorkTypeSelection extends StatefulWidget {
  @override
  _WorkTypeSelectionState createState() => _WorkTypeSelectionState();
}

class _WorkTypeSelectionState extends State<WorkTypeSelection> {
  String selectedWorkType = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Work Type",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),

          RadioListTile(
            title: Text("Day"),
            value: "Day",
            groupValue: selectedWorkType,
            onChanged: (String? value) {
              setState(() {
                selectedWorkType = value!;
              });
            },
          ),

          RadioListTile(
            title: Text("Night"),
            value: "Night",
            groupValue: selectedWorkType,
            onChanged: (String? value) {
              setState(() {
                selectedWorkType = value!;
              });
            },
          ),

          RadioListTile(
            title: Text("24 Hrs"),
            value: "24 Hrs",
            groupValue: selectedWorkType,
            onChanged: (String? value) {
              setState(() {
                selectedWorkType = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}