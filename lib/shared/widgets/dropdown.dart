import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:flutter/material.dart';

class Dropdown<T> extends StatefulWidget {
  final String? hint;
  final TextStyle? hintStyle;
  final List<T> items;
  final Function(T?) onChanged;
  final String? label;
  final TextStyle? style;
  final T? initialValue;

  const Dropdown({
    super.key,
    this.hint,
    this.hintStyle,
    required this.items,
    this.label,
    required this.onChanged,
    this.style,
    this.initialValue,
  });

  @override
  State<Dropdown<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<Dropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.label != null) ...[
        Text('${widget.label}', style: AppTextTheme.interRegular14),
        const SizedBox(height: 8)
      ],
      DropdownButtonFormField<T>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.gray01),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          hintStyle: widget.hintStyle ?? AppTextTheme.interRegular14,
          hintText: widget.hint,
          isDense: true,
        ),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        items: widget.items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: widget.style ?? AppTextTheme.interRegular14,
                ),
              ),
            )
            .toList(),
        onChanged: (value) => widget.onChanged(value),
        value: widget.initialValue,
      ),
    ]);
  }
}
