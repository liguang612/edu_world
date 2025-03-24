import 'package:edu_world/utils/ext/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: context.screenHeight * (1 - 329 / 807),
            child: Column(
              children: [
                Row(
                  children: [SvgPicture.asset('')],
                )
              ],
            ),
          ),
          Container(
            height: context.screenHeight * 329 / 807,
            child: Column(),
          )
        ],
      ),
    );
  }
}
