import 'dart:developer';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmock/presentation/pages/home/cubit/home_cubit.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';

import '../../../constant/enum.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../common_bloc/auth/auth_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<HomeCubit>().getLocation();
  }

  int toggleIndex = 0;

  //togle switch
  void _onToggleChanged(int index) {
    setState(() {
      toggleIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state.getLocationStatus == StateStatusEnum.loading) {
        // DialogUtils.buildLoadingDialog(context);
      }
      if (state.getLocationStatus == StateStatusEnum.error) {
        // Navigator.of(context).pop();
      }
      if (state.getLocationStatus == StateStatusEnum.success) {
        Fluttertoast.showToast(
          msg: 'Location Updated',
        );
        log(state.getLocationStatus.toString());

        // Navigator.of(context).pop();
        // print(state.currentLocation.toString());
      }
    },
            // ignore: prefer_const_constructors
            builder: (context, state) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: state.currentLocation!, zoom: 15),
            markers: {
              Marker(
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                  title: 'Current Location',
                ),
                markerId: MarkerId('1'),
                position: LatLng(state.currentLocation!.latitude,
                    state.currentLocation!.longitude),
              )
            },
            onMapCreated: (GoogleMapController controller) async {
              await context.read<HomeCubit>().getLocation();

              log(state.getLocationStatus.toString());
              log('onMapCreated');

              double currentZoom = 20.0; // Starting zoom level (higher)
              double targetZoom = 15.0; // Target zoom level (lower)
              int animationDuration =
                  3000; // Duration of the animation in milliseconds

              // Calculate intermediate zoom levels
              List<double> intermediateZoomLevels = [];
              int numberOfSteps = 15; // Number of steps in the animation

              for (int i = 0; i <= numberOfSteps; i++) {
                double zoom = currentZoom +
                    (targetZoom - currentZoom) * (i / numberOfSteps);
                intermediateZoomLevels.add(zoom);
              }

              // Perform the animation with intermediate zoom levels
              for (double zoom in intermediateZoomLevels) {
                await controller
                    .animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                      target: context.read<HomeCubit>().state.currentLocation!,
                      zoom: zoom,
                    )))
                    .then((_) => Future.delayed(Duration(
                        milliseconds: animationDuration ~/ numberOfSteps)));
              }

              log(state.currentLocation.toString());
            },

            // myLocationEnabled: true,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedToggleSwitch.dual(
              current: context.read<HomeCubit>().state.onlineToggleStatusValue,
              first: 0,
              second: 1,
              onChanged: (value) => context.read<HomeCubit>().startTimer(),
              iconBuilder: (value) {
                return value == 0
                    ? Icon(Icons.location_off)
                    : Icon(Icons.location_on);
              },
              customTextBuilder: (value, selected, child) {
                return Text(value == 0 ? 'Offline' : 'Online',
                    style: TextStyle(
                      color: Colors.white,
                    ));
              },
              style: ToggleStyle(
                backgroundColor:
                    context.read<HomeCubit>().state.onlineToggleStatusValue == 0
                        ? Colors.red
                        : Colors.green,
                borderColor: Colors.transparent,
                indicatorColor: Colors.white,
              ),
            ),
          )
          // Padding(
          //     padding: EdgeInsets.all(16.0),
          //     child: AnimatedToggleSwitch.rolling(
          //       animationDuration: Duration(milliseconds: 500),
          //       borderWidth: 2,
          //       onTap: (value) {
          //         log(value.toString());
          //       },

          //       onChanged: (index) => _onToggleChanged(index),
          //       // iconBuilder: (value, size) {
          //       //   return value == 0
          //       //       ? Text('online', style: TextStyle(color: Colors.white))
          //       //       : Icon(Icons.location_on);
          //       // },
          //       iconList: [
          //         toggleIndex == 1
          //             ? Text('Online', style: TextStyle(color: Colors.white))
          //             : Icon(Icons.location_off),
          //         toggleIndex == 0
          //             ? Text('Offline', style: TextStyle(color: Colors.white))
          //             : Icon(Icons.location_on)
          //       ],

          //       current: toggleIndex,
          //       values: [
          //         0,
          //         1,
          //       ],
          //       style: ToggleStyle(
          //         backgroundColor: toggleIndex == 0 ? Colors.red : Colors.green,
          //         borderColor: Colors.transparent,
          //         indicatorColor: Colors.white,
          //       ),
          //     )),
        ],
      );
    }));
  }
}
