import 'package:flutter/material.dart';
import 'package:readmock/core/resources/assets_manager.dart';

import '../../widgets/custom_scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset(ImageAssets.logo)],
      ),
    ));
  }
}
