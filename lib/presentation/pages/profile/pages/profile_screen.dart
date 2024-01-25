import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_text_styles.dart';
import '../../../../config/routes_manager.dart';
import '../../../../core/di/locator.dart';
import '../../../../core/resources/text_content_manage.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/utils/local_prefs.dart';
import '../../../common_bloc/auth/auth_bloc.dart';
import 'view_profile_view.dart';
import '../profile_bloc/profile_cubit.dart';
import '../../web_page/web_page.dart';
import '../../../widgets/custom_scaffold.dart';

import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../widgets/nav_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      contentPadding: EdgeInsets.zero,
      body: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizeBox.height10,
                ProfileCard(state: state),
                AppSizeBox.height20,
                const Text(
                  'Explore',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                AppSizeBox.height20,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        AppSizeBox.height10,
                        BuildNavTitle(
                          icon: Icons.privacy_tip,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => WebPage(
                                          title: 'Privacy Policy',
                                          htmlData:
                                              TextContentManager.privacyHTML,
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
                                          htmlData:
                                              TextContentManager.termsHTML,
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
                ),
                AppSizeBox.bottomSizeBox,
              ],
            ),
          ),
        );
      }),
    );
  }

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
}

class ProfileCard extends StatelessWidget {
  ProfileCard({super.key, required this.state});

  ProfileState state;

  @override
  Widget build(BuildContext context) {
    var user = state.profileModel;
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        user!.name![0],
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ))),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name!,
                      style: AppTextStyle.h4TitleTextStyle(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      user.email!,
                      style: AppTextStyle.h5TitleTextStyle(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ViewProfileView()));
                            },
                            child: const Text('View Profile')),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       getInstance<LocalPrefs>().clearAllData();
                        //       getInstance<AuthBloc>().add(AuthCheck());
                        //     },
                        //     child: const Text('Logout')),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
