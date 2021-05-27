import 'package:flutter/material.dart';
import 'package:argon_flutter/constants/Theme.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;
  final bool enable;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  Input(
      {this.placeholder,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.obscureText = false,
      this.onChanged,
      this.autofocus = false,
      this.borderColor = ArgonColors.border,
      this.enable = true,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.inputFormatters = null
    });

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: obscureText,
        enabled: enable,
        cursorColor: ArgonColors.muted,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        autofocus: autofocus,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style:
            TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: ArgonColors.white,
            hintStyle: TextStyle(
              color: ArgonColors.muted,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
