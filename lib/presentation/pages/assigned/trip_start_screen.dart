import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmock/domain/model/trip.dart';
import 'package:readmock/presentation/pages/home/cubit/home_cubit.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
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

    // Fetch directions and draw polyline
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

        // Zoom the camera to fit both markers and the polyline
        // fitBounds(LatLngBounds(southwest: origin, northeast: destination));
        mapController.animateCamera(CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: destination,
              northeast: origin,
            ),
            50));
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

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(
      bounds,
      50.0,
    );
    //zoom

    mapController.animateCamera(
      u2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      contentPadding: EdgeInsets.zero,
      appBar: AppBar(
        title: Text('Trip Details'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) async {
          mapController = controller;

          await fetchDirections(
              LatLng(
                double.parse(widget.trip.trip!.pickLat!),
                double.parse(widget.trip.trip!.pickLng!),
              ),
              LatLng(
                double.parse(widget.trip.trip!.dropLat!),
                double.parse(widget.trip.trip!.dropLng!),
              ));

          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(
            double.parse(widget.trip.trip!.pickLat!),
            double.parse(widget.trip.trip!.pickLng!),
          ))));

          // fitBounds(LatLngBounds(
          //     southwest: LatLng(
          //       double.parse(widget.trip.trip!.pickLat!),
          //       double.parse(widget.trip.trip!.pickLng!),
          //     ),
          //     northeast: LatLng(
          //       double.parse(widget.trip.trip!.dropLat!),
          //       double.parse(widget.trip.trip!.dropLng!),
          //     )));
        },
        initialCameraPosition: CameraPosition(
          target:
              context.read<HomeCubit>().state.currentLocation ?? LatLng(0, 0),
          zoom: 15,
        ),
        markers: markers,
        polylines: polylines,
      ),
    );
  }
}
