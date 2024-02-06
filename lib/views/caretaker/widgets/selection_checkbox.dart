import 'package:flutter/material.dart';

class WorkTypeSelection extends StatefulWidget {
  final Function(String) onWorkTypeSelected;
  final TextEditingController workTypeController;

  WorkTypeSelection({
    required this.onWorkTypeSelected,
    required this.workTypeController,
  });

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

              // Call the callback function with the selected work type
              widget.onWorkTypeSelected(selectedWorkType);
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

              // Call the callback function with the selected work type
              widget.onWorkTypeSelected(selectedWorkType);
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

              // Call the callback function with the selected work type
              widget.onWorkTypeSelected(selectedWorkType);
            },
          ),

          // Assuming you want to update the controller when work type changes
          // You can uncomment the following lines
          // TextFormField(
          //   controller: widget.workTypeController,
          //   readOnly: true,
          //   decoration: InputDecoration(labelText: 'Selected Work Type'),
          // ),
        ],
      ),
    );
  }
}
