import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? title;

  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (title != null) Text(title!, style: AppTextTheme.interRegular12),
      const SizedBox(height: 10),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.gray08)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.gray08)),
          hintStyle: AppTextTheme.interRegular12.copyWith(color: AppColor.gray07),
          hintText: hint,
        ),
        style: AppTextTheme.interRegular12,
      )
    ]);
  }
}
