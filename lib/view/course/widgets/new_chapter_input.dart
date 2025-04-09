import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/data/resources/resources.dart';
import 'package:edu_world/data/resources/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewChapterInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final Function(String)? onAccept;
  final Function()? onCancel;

  NewChapterInput({super.key, this.onAccept, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.gray09.withOpacity(0.9),
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(children: [
        Expanded(
            child: TextField(
          controller: controller,
          decoration: const InputDecoration(isDense: true),
          style: AppTextTheme.interRegular12,
        )),
        IconButton(icon: SvgPicture.asset(Assets.icCancel), onPressed: onCancel),
        IconButton(
          icon: SvgPicture.asset(Assets.icAccept),
          onPressed: () {
            if (onAccept != null) onAccept!(controller.text);
          },
        )
      ]),
    );
  }
}
