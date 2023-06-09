import 'package:flutter/material.dart';
import 'package:taskly_new/screen/home/widgets/home_body.dart';

import '../view.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View(
      builder: (context, viewmodel, _) {
        return HomeBody(
            viewmodel:viewmodel,
        );
      },
      viewmodel: HomeViewmodel(),
    );
  }
}
