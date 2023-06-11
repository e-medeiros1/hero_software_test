import 'package:flutter/material.dart';
import 'package:hero_software_test/app/core/styles/color_style.dart';
import 'package:hero_software_test/app/core/styles/text_styles.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String? label;
  final bool isMandatory;
  final String hintText;
  final double fieldWidth;
  final String? Function(String?)? validation;
  bool obscureText;
  final double fontSize;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  CustomTextField({
    super.key,
    this.validation,
    this.obscureText = false,
    this.label,
    required this.fieldWidth,
    this.fontSize = 17,
    required this.hintText,
    this.isMandatory = true,
    this.controller,
    this.suffixIcon,
    required this.keyboardType,
  });
  CustomTextField.password(
      {super.key,
      this.validation,
      this.obscureText = true,
      required this.label,
      required this.fieldWidth,
      this.fontSize = 25,
      required this.hintText,
      this.isMandatory = true,
      this.controller,
      required this.suffixIcon,
      required this.keyboardType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.label,
                  style: context.textStyles.textMedium.copyWith(
                    color: context.colors.secondary,
                    fontSize: 17,
                  ),
                ),
                if (widget.isMandatory)
                  TextSpan(
                    text: ' *',
                    style: context.textStyles.textExtraBold.copyWith(
                      color: context.colors.blue,
                      fontSize: 17,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: widget.fieldWidth,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              cursorColor: context.colors.secondary,
              cursorHeight: 20,
              style: context.textStyles.textRegular.copyWith(
                  fontSize: widget.fontSize,
                  color: context.colors.secondary,
                  letterSpacing: 1),
              obscureText: widget.obscureText,
              obscuringCharacter: '●',
              decoration: InputDecoration(
                suffixIcon: widget.suffixIcon,
                hintText: widget.hintText,
                hintStyle: context.textStyles.textRegular
                    .copyWith(color: Colors.grey.shade400),
              ),
              validator: widget.validation,
            ),
          ),
        ],
      ),
    );
  }
}
