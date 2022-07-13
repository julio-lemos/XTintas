import 'package:flutter/material.dart';

class XTextFieldWidget extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final FormFieldValidator? validator;
  final TextEditingController? controller;

  const XTextFieldWidget({
    Key? key,
    required this.labelText,
    this.hintText,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(Object context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            labelText,
            style: const TextStyle(
              fontFamily: "OpenSans",
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            filled: true,
            fillColor: const Color(0xFFFFFFFF).withOpacity(0.4),
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: "OpenSans",
              color: Colors.white.withOpacity(0.6),
              fontSize: 16,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                )),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
