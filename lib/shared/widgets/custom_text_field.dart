import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? title;

  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
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
        maxLines: maxLines,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: AppTextTheme.interRegular12,
      )
    ]);
  }
}
