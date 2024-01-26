import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmock/core/utils/dialog_utils.dart';
import 'package:readmock/domain/model/trip.dart';
import 'package:readmock/presentation/pages/assigned/cubit/assigned_cubit.dart';
import 'package:readmock/presentation/pages/home/cubit/home_cubit.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';
import 'package:http/http.dart' as http;
import 'package:slide_to_act/slide_to_act.dart';
import 'dart:math' as math;

import '../../../constant/enum.dart';
import '../../../data/request/start_trip_request.dart';
import '../../widgets/custom_circular_button.dart';
import '../../widgets/custom_image_picker.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custome_video_picker.dart';

class TripStartScreen extends StatefulWidget {
  TripStartScreen({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  @override
  _TripStartScreenState createState() => _TripStartScreenState();
}

class _TripStartScreenState extends State<TripStartScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = Set<Marker>();
  Set<Polyline> polylines = Set<Polyline>();

  File? _image;

  //Front image
  //back image
  //left image
  //right image
  File? _frontImage;
  File? _backImage;
  File? _leftImage;
  File? _rightImage;

  @override
  void initState() {
    super.initState();
    context.read<AssignedCubit>().setTrip(widget.trip);
    addMarkers();
  }

  void addMarkers() {
    LatLng currentLocation =
        context.read<HomeCubit>().state.currentLocation ?? LatLng(0, 0);
    LatLng from = LatLng(
      double.parse(widget.trip.trip!.pickLat!),
      double.parse(widget.trip.trip!.pickLng!),
    );
    LatLng to = LatLng(
      double.parse(widget.trip.trip!.dropLat!),
      double.parse(widget.trip.trip!.dropLng!),
    );

    markers.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: currentLocation,
        infoWindow: InfoWindow(
          title: 'Current Location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    markers.add(
      Marker(
        markerId: MarkerId('from'),
        position: from,
        infoWindow: InfoWindow(
          title: 'From',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    markers.add(
      Marker(
        markerId: MarkerId('to'),
        position: to,
        infoWindow: InfoWindow(
          title: 'To',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    fetchDirections(from, to);
  }

  Future<void> fetchDirections(LatLng origin, LatLng destination) async {
    final apiKey = 'AIzaSyBDAit_21ZT1Wdu95dfDAYEnIqz8lwMa2o';
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      if (decoded['status'] == 'OK') {
        List<LatLng> points = _decodePolyline(
            decoded['routes'][0]['overview_polyline']['points']);

        setState(() {
          polylines.clear();
          polylines.add(
            Polyline(
              polylineId: PolylineId('route'),
              points: points,
              color: Colors.blue,
              width: 5,
            ),
          );
        });

        fitBounds(LatLngBounds(southwest: destination, northeast: origin));
      }
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }

    return points;
  }

  Future<void> fitBounds(LatLngBounds bounds) async {
    if (bounds.southwest.latitude > bounds.northeast.latitude ||
        bounds.southwest.longitude > bounds.northeast.longitude) {
      // Ensure valid bounds
      return;
    }

    LatLngBounds newBounds = LatLngBounds(
      southwest: LatLng(bounds.southwest.latitude, bounds.southwest.longitude),
      northeast: LatLng(bounds.northeast.latitude, bounds.northeast.longitude),
    );

    // Calculate distance between bounds
    double distance = _calculateDistance(newBounds);
    log('Distance ' + distance.toString());

    // Set the zoom level based on the distance
    double zoomLevel = _calculateZoomLevel(distance);

    log('Zoom Level ' + zoomLevel.toString());

    // Animate camera to fit bounds with accurate zoom level
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(newBounds, 50),
    );
    // mapController.animateCamera(
    //   CameraUpdate.newLatLngBounds(newBounds, 15),
    // );
  }

  double _calculateDistance(LatLngBounds bounds) {
    double distance = math.sqrt(math.pow(
            bounds.northeast.latitude - bounds.southwest.latitude, 2) +
        math.pow(bounds.northeast.longitude - bounds.southwest.longitude, 2));
    return distance;
  }

  double _calculateZoomLevel(double distance) {
    const double maxZoomLevel = 21.0;

    double zoomLevel = math.log((2 * math.pi * distance) / 156543.03392);
    return zoomLevel.clamp(0.0, maxZoomLevel);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      contentPadding: EdgeInsets.zero,
      appBar: AppBar(
        title: Text(widget.trip.trip!.user!.name!),
      ),
      body: BlocListener<AssignedCubit, AssignedState>(
        listener: (context, state) {
          if (state.startTripStatus == StateStatusEnum.success) {}
          if (state.startTripStatus == StateStatusEnum.error) {
            Fluttertoast.showToast(msg: state.startTripError);
          }
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: context.read<HomeCubit>().state.currentLocation ??
                    LatLng(0, 0),
                zoom: 15,
              ),
              myLocationEnabled: true,
              markers: markers,
              polylines: polylines,
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              //,
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Column(
                children: [
                  //Trip details
                  SizedBox(
                    height: 10,
                  ),

                  context.watch<AssignedCubit>().state.startTripStatus ==
                          StateStatusEnum.loading
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Column(
                            children: [
                              context
                                          .read<AssignedCubit>()
                                          .state
                                          .trip
                                          ?.tripStatus ==
                                      null
                                  ? SizedBox(
                                      height: 50,
                                      child: SlideAction(
                                          outerColor: Colors.white60,
                                          sliderButtonIconPadding: 10,
                                          elevation: 0,
                                          child: Text(
                                            'Start Trip',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onSubmit: () {
                                            showContactDetails(context);
                                          }),
                                    )
                                  : SizedBox.shrink(),
                              context
                                          .read<AssignedCubit>()
                                          .state
                                          .trip
                                          ?.tripStatus ==
                                      0
                                  ? SizedBox(
                                      height: 50,
                                      child: SlideAction(
                                          outerColor: Colors.white60,
                                          sliderButtonIconPadding: 10,
                                          elevation: 0,
                                          child: Text(
                                            'End Trip',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onSubmit: () {
                                            context
                                                .read<AssignedCubit>()
                                                .endTrip(widget.trip.trip!.id!);
                                          }),
                                    )
                                  : SizedBox.shrink(),
                              context
                                          .read<AssignedCubit>()
                                          .state
                                          .trip
                                          ?.tripStatus ==
                                      1
                                  ? Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.green
                                            .shade300, // Indicating a completed status with green color
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.green.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(0, 3),
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Trip Completed',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 16.0, vertical: 8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [

                  //       context.read<AssignedCubit>().state.trip?.tripStatus ==
                  //               1
                  //           ? ElevatedButton(
                  //               onPressed: () {
                  //                 // TODO: Implement end button functionality
                  //               },
                  //               style: ElevatedButton.styleFrom(
                  //                 primary: Colors.red, // background color
                  //                 onPrimary: Colors.white, // text color
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(30),
                  //                 ),
                  //                 padding: EdgeInsets.symmetric(
                  //                     horizontal: 32, vertical: 12),
                  //               ),
                  //               child: Text('End'),
                  //             )
                  //           : SizedBox.shrink(),
                  //     ],
                  //   ),
                  // ),

                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2)),
                      child:
                          //Locaton from to to
                          //,
                          Column(
                        children: [
                          Text(widget.trip.trip!.from!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.black)),
                          Spacer(),
                          Text('To',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Spacer(),
                          Text(
                            widget.trip.trip!.to!,
                            style: Theme.of(context).textTheme.labelSmall!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showContactDetails(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.8,
            maxChildSize: 1.0,
            minChildSize: 0.1,
            expand: false,
            builder: (context, scrollController) =>
                BlocListener<AssignedCubit, AssignedState>(
                    listener: (context, state) {
                      //loading

                      if (state.getAssignedStatus == StateStatusEnum.loading) {
                        DialogUtils.buildLoadingDialog(context);
                      }
                    },
                    child: SingleChildScrollView(
                        controller: scrollController,
                        child: Form(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Fill Details To Start Trip',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  CustomImagePicker(
                                    imageFile: _frontImage,
                                    onImagePicked: (imageFile) {
                                      setState(() {
                                        _frontImage = imageFile;
                                      });
                                    },
                                    title: 'Font Image',
                                  ),

                                  CustomImagePicker(
                                    imageFile: _backImage,
                                    onImagePicked: (imageFile) {
                                      setState(() {
                                        _backImage = imageFile;
                                      });
                                    },
                                    title: 'Back Image',
                                  ),

                                  //for left image
                                  CustomImagePicker(
                                    imageFile: _leftImage,
                                    onImagePicked: (imageFile) {
                                      setState(() {
                                        _leftImage = imageFile;
                                      });
                                    },
                                    title: 'Left Image',
                                  ),

                                  //for right image
                                  CustomImagePicker(
                                    imageFile: _rightImage,
                                    onImagePicked: (imageFile) {
                                      setState(() {
                                        _rightImage = imageFile;
                                      });
                                    },
                                    title: 'Right Image',
                                  ),

                                  //Purchase Button

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          //check all image
                                          if (_frontImage == null ||
                                              _backImage == null ||
                                              _leftImage == null ||
                                              _rightImage == null) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Please select all images');
                                          } else {
                                            var request = StartTripRequest(
                                              tripId: widget.trip.trip!.id!,
                                              frontImage: _frontImage,
                                              backImage: _backImage,
                                              leftImage: _leftImage,
                                              rightImage: _rightImage,
                                            );
                                            log('start trip request $request');

                                            context
                                                .read<AssignedCubit>()
                                                .startTrip(request);

                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('Start Trip'),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        )))));
  }
}
