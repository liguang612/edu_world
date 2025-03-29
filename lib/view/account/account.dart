import 'package:edu_world/bloc/account/account_bloc.dart';
import 'package:edu_world/data/resources/colors.dart';
import 'package:edu_world/di/di.dart';
import 'package:edu_world/shared/utils/ext/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Account extends StatelessWidget {
  final AccountBloc bloc = getIt.get();

  Account({super.key}) {
    bloc.add(GetAccountInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AccountBloc, AccountState>(
        bloc: bloc,
        builder: (context, state) {
          return SizedBox(
            width: context.screenWidth,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              const SizedBox(height: 50),
              state is GetAccountInfoSuccess
                  ? ClipOval(
                      child: Image.network(
                        state.user.avatarUrl ?? '',
                        fit: BoxFit.cover,
                        height: context.screenWidth * 100 / 375,
                        width: context.screenWidth * 100 / 375,
                      ),
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(state is GetAccountInfoSuccess ? state.user.name : ''),
              Text(state is GetAccountInfoSuccess ? state.user.email ?? '' : ''),
              InfoItem(
                icon: const Icon(Icons.school, color: AppColor.purple01),
                title: 'Trường',
                value: state is GetAccountInfoSuccess ? state.user.school : '',
              ),
              InfoItem(
                icon: const Icon(Icons.location_city, color: AppColor.purple01),
                title: 'Địa điểm',
                value: state is GetAccountInfoSuccess ? state.user.address : '',
              ),
              InfoItem(
                icon: const Icon(Icons.class_, color: AppColor.purple01),
                title: 'Lớp',
                value: '${state is GetAccountInfoSuccess ? state.user.grade : ''}',
              )
            ]),
          );
        },
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;

  const InfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    color: AppColor.black.withOpacity(0.15),
                    offset: const Offset(0, 4),
                  )
                ],
                color: AppColor.white),
            child: icon,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title),
              Text(value),
            ]),
          ),
          const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Chỉnh sửa'),
          ])
        ]),
      ),
    );
  }
}
