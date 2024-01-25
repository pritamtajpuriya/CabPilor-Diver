import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final IconData? leadingIcon;
  final TextInputType keyboardType;
  final editable;

  final String? Function(String?)? validator;

  const CustomTextField({
    required this.label,
    required this.controller,
    this.leadingIcon,
    this.editable = true,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            enabled: widget.editable,
            decoration: InputDecoration(
              prefixIcon:
                  widget.leadingIcon != null ? Icon(widget.leadingIcon) : null,
              hintText: widget.hintText,
              border: OutlineInputBorder(),
            ),
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
