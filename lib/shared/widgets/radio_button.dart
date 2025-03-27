import 'package:edu_world/data/resources/theme.dart';
import 'package:flutter/material.dart';

class RadioButton<T> extends StatefulWidget {
  final List<T> items;
  final TextStyle? textStyle;

  const RadioButton({
    super.key,
    required this.items,
    this.textStyle,
  });

  @override
  State<RadioButton> createState() => _RadioButtonState<T>();
}

class _RadioButtonState<T> extends State<RadioButton> {
  T? selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.items
          .map((e) => Expanded(
                child: RadioListTile<T>(
                  groupValue: selected,
                  onChanged: (value) => setState(() {
                    selected = value;
                  }),
                  title: Text(e.toString(), style: widget.textStyle ?? AppTextTheme.interRegular14),
                  value: e,
                ),
              ))
          .toList(),
    );
  }
}
