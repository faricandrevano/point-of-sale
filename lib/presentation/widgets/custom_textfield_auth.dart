import 'package:flutter/material.dart';
import 'package:pos/presentation/constants/colors.dart';
import 'package:pos/presentation/constants/styles.dart';

class CustomTextfieldAuth extends StatefulWidget {
  const CustomTextfieldAuth(
      {super.key,
      required this.label,
      this.prefixIcon,
      required this.hintText,
      this.obsecureText,
      this.controller,
      this.keyboardType});
  final String label;
  final String hintText;
  final String? prefixIcon;
  final bool? obsecureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  @override
  State<CustomTextfieldAuth> createState() => _CustomTextfieldAuthState();
}

class _CustomTextfieldAuthState extends State<CustomTextfieldAuth> {
  late bool visibility = widget.obsecureText ?? false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: bodyM.copyWith(
            fontWeight: semiBold,
            color: neutral90,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          obscureText: visibility,
          controller: widget.controller,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null
                ? Image.asset(
                    widget.prefixIcon.toString(),
                    scale: 1.75,
                  )
                : null,
            hintText: widget.hintText,
            suffixIcon:
                widget.obsecureText == null || widget.obsecureText == false
                    ? null
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        child: visibility
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: neutral40),
            ),
          ),
        ),
      ],
    );
  }
}
