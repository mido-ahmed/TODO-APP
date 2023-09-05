import 'package:flutter/material.dart';

class InsertDataWidget extends StatefulWidget {
  final String hintText;
  final double borderWidth;
  final Color borderColor;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function? onTap;
  final Function validator;
  final IconData iconData;

  const InsertDataWidget({
    super.key,
    required this.hintText,
    required this.borderWidth,
    required this.borderColor,
    required this.keyboardType,
    required this.controller,
     this.onTap,
    required this.validator,
    required this.iconData,
  });

  @override
  State<InsertDataWidget> createState() => _InsertDataWidgetState();
}

class _InsertDataWidgetState extends State<InsertDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          onTap: () => widget.onTap,
          validator: (value) {
            widget.validator;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: widget.borderWidth, color: widget.borderColor)),
              label: Text(widget.hintText,
                  style: const TextStyle(color: Colors.black)),
              prefixIcon: Icon(widget.iconData, color: Colors.black)),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
