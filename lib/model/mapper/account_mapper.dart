import 'package:edu_world/model/entity/account.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension AccountMapper on User? {
  Account toAccount() => Account(
        avatarUrl: this?.photoURL,
        name: this?.displayName,
        email: this?.email,
      );
}
