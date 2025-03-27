import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:flutter/material.dart';

class Dropdown<T> extends StatelessWidget {
  final String? hint;
  final TextStyle? hintStyle;
  final List<T> items;
  final Function(T?) onChanged;
  final String? label;
  final TextStyle? style;

  const Dropdown({
    super.key,
    this.hint,
    this.hintStyle,
    required this.items,
    this.label,
    required this.onChanged,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (label != null) ...[Text('$label', style: AppTextTheme.interRegular14), const SizedBox(height: 8)],
      DropdownButtonFormField<T>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.gray01),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          hintStyle: hintStyle ?? AppTextTheme.interRegular14,
          hintText: hint,
          isDense: true,
        ),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item.toString(), style: style ?? AppTextTheme.interRegular14),
              ),
            )
            .toList(),
        onChanged: (value) => onChanged(value),
        value: null,
      ),
    ]);
  }
}
