import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String tag;

  const CustomChip({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColor.blue02,
      deleteIcon: const Icon(Icons.close, color: AppColor.blue01, size: 12),
      label: Text(
        tag,
        style: AppTextTheme.interRegular12.copyWith(color: AppColor.blue01),
      ),
      labelPadding: const EdgeInsets.only(left: 4),
      onDeleted: () {},
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: Colors.transparent),
      ),
      visualDensity: VisualDensity.compact,
    );
  }
}
