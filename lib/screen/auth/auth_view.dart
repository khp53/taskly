import 'package:flutter/material.dart';
import 'package:taskly_new/screen/auth/auth_viewmodel.dart';
import 'package:taskly_new/screen/auth/widgets/signup.dart';
import 'package:taskly_new/screen/view.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View(
      builder: (context, viewmodel, child) {
        return SignUp(
          viewmodel: viewmodel,
        );
      },
      viewmodel: AuthViewmodel(),
    );
  }
}
