import 'package:flutter/material.dart';

class XPasswordField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final FormFieldValidator? validator;
  final TextEditingController? controller;

  const XPasswordField({
    super.key,
    required this.labelText,
    this.hintText,
    this.validator,
    this.controller,
  });

  @override
  State<XPasswordField> createState() => _XPasswordFieldState();
}

class _XPasswordFieldState extends State<XPasswordField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            widget.labelText,
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
          controller: widget.controller,
          obscureText: !_passwordVisible,
          obscuringCharacter: "*",
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              filled: true,
              fillColor: const Color(0xFFFFFFFF).withOpacity(0.4),
              hintText: widget.hintText,
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
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white.withOpacity(0.6),
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )),
          validator: widget.validator,
        ),
      ],
    );
  }
}
