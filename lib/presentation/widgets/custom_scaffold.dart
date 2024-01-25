import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    this.appBar,
    this.drawer,
    this.bottomNavigationBar,
    this.body,
    this.floatingActionButton,
    this.contentPadding = const EdgeInsets.only(left: 16, right: 16, top: 0),
    this.floatingActionButtonLocation,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? body;
  final FloatingActionButton? floatingActionButton;
  final EdgeInsets contentPadding;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Drawer? drawer;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final NavigatorState navigator = Navigator.of(context);
        if (navigator.canPop()) {
          navigator.pop();
          return false;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade50,
              Colors.white,
              Colors.white,
              Colors.green.shade50,
            ],
            stops: const [0.0, 0.1, 0.65, 1.0],
          ),
        ),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.white,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: SafeArea(
            child: Scaffold(
              drawer: drawer,
              bottomNavigationBar: bottomNavigationBar != null
                  ? BottomAppBar(
                      child: bottomNavigationBar,
                    )
                  : null,
              floatingActionButton: floatingActionButton,
              extendBodyBehindAppBar: true,
              extendBody: true,
              floatingActionButtonLocation: floatingActionButtonLocation,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (appBar != null) appBar!,
                  Expanded(
                    child: Container(
                      padding: contentPadding,
                      child: body,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
