import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmock/presentation/pages/assigned/assigned_screen.dart';
import 'package:readmock/presentation/pages/notifications/notification_screen.dart';
import 'package:readmock/presentation/pages/orders/order_screen.dart';
import 'package:readmock/presentation/pages/payment/payment_screen.dart';
import '../../../../config/app_text_styles.dart';
import '../../../../config/routes_manager.dart';

import '../../../../core/di/locator.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../booklet/booklet_screen.dart';
import '../../customer/customer_screen.dart';
import '../../home/home_screen.dart';
import '../bloc/landing_cubit/landing_cubit.dart';

import '../../profile/pages/profile_screen.dart';

import '../widgets/bottom_menu.dart';
import '../widgets/drawer.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _bottomMenuIndex = 0;

  final PageController _pageController = PageController();

  void _onBottomMenuChanged(int index) {
    setState(() {
      _bottomMenuIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        drawer: MenuDrawer(),
        body: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: 5,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return HomeScreen();

                case 1:
                  return AssignedScreen();
                case 2:
                  return OrderScreen();

                case 3:
                  return ProfileScreen();

                default:
                  return Container(
                    child: Text("Home4"),
                  );
              }
            }),
        bottomNavigationBar: BottomMenu(
            bottomMenuIndex: _bottomMenuIndex,
            onChanged: (index) {
              _onBottomMenuChanged(index);

              _pageController.jumpToPage(index);

              // like normal page navigation
            }));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //   // Status bar color
      //   statusBarColor: Colors.indigo,
      //   // Status bar brightness (optional)
      //   statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
      // ),
      backgroundColor: Colors.white,
      elevation: 1,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(ImageAssets.logo),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => NotificationScreen()));
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.notifications, color: Colors.black, size: 30),
              Positioned(
                right: 0,
                top: 16,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    'N', // Replace 'N' with your notification count variable
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
