// import 'package:flutter/material.dart';

// class CustomDropdown extends StatefulWidget {
//   final List<String> options;
//   final String? Function(String?)? validator;
//   final ValueChanged<String> onOptionSelected;
//   final String title;
//   String? initialValue;

//   CustomDropdown({
//     Key? key,
//     required this.options,
//     this.validator,
//     required this.onOptionSelected,
//     required this.title,
//     this.initialValue,
//   }) : super(key: key);

//   @override
//   _CustomDropdownState createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(widget.title,
//               style:
//                   const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           DropdownButtonFormField<String>(
//               value: widget.initialValue,
//               isExpanded: true,
//               hint: Text(widget.title),
//               icon: const Icon(Icons.arrow_drop_down, color: Colors.blueGrey),
//               iconSize: 24,
//               elevation: 16,
//               style: TextStyle(color: Colors.black87, fontSize: 16),
//               validator: widget.validator,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   widget.initialValue = newValue;
//                 });
//                 widget.onOptionSelected(newValue!);
//               },
//               items: [
//                 //Select in first
//                 DropdownMenuItem<String>(
//                   value: 'Select',
//                   child: Text('Select ${widget.title}'),
//                 ),
//                 ...widget.options.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ]),
//         ],
//       ),
//     );
//   }
// }
