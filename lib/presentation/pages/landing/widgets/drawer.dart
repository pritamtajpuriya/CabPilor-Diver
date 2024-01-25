import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:readmock/core/resources/assets_manager.dart';

import '../../../../config/routes_manager.dart';
import '../../../../core/di/locator.dart';
import '../../../../core/resources/text_content_manage.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/utils/local_prefs.dart';
import '../../../common_bloc/auth/auth_bloc.dart';
import '../../profile/widgets/nav_tile.dart';
import '../../web_page/web_page.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({super.key});

  void ddd(BuildContext context) async {
    log('Logout');
    // DialogUtils.buildLoadingDialog(context);

    CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      text: "Please wait...",
      barrierDismissible: false,
    );
    CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      text: "Please wait...",
      barrierDismissible: true,
    );

    log('ddd');
    await Future.delayed(const Duration(milliseconds: 1000));
    getInstance<LocalPrefs>().clearAllData();
    getInstance<AuthBloc>().add(AuthCheck());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Image.asset(ImageAssets.logo),
            ),
          ),

          // divider
          Divider(
            color: Colors.grey.shade400,
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),

          // menu title name

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // BuildNavTitle(
                //   icon: Icons.translate,
                //   title: 'Change Language',
                //   iconUrl: 'assets/icons/translate.png',
                //   onPressed: () {},
                // ),
                AppSizeBox.height10,
                BuildNavTitle(
                  icon: Icons.privacy_tip,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => WebPage(
                                  title: 'Privacy Policy',
                                  htmlData: TextContentManager.privacyHTML,
                                )));
                  },
                  title: 'Privacy Policy',
                  iconUrl: 'assets/icons/leaderboard.png',
                ),

                AppSizeBox.height10,

                BuildNavTitle(
                  icon: Icons.privacy_tip_outlined,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => WebPage(
                                  title: 'Terms & Conditions',
                                  htmlData: TextContentManager.termsHTML,
                                )));
                  },
                  title: 'Terms & Conditions',
                  iconUrl: 'assets/icons/leaderboard.png',
                ),

                const BuildNavTitle(
                  icon: Icons.update,
                  title: 'Update App',
                  iconUrl: 'assets/icons/update.png',
                ),
                BuildNavTitle(
                  icon: Icons.logout,
                  title: 'Logout',
                  iconUrl: 'assets/icons/update.png',
                  onPressed: () {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.confirm,
                      title: "Logout",
                      text: "Are you sure you want to logout?",
                      confirmBtnText: "Yes",
                      cancelBtnText: "No",
                      onConfirmBtnTap: () {
                        Navigator.pop(context);
                        ddd(context);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
