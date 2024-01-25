import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmock/domain/model/trip.dart';
import 'package:readmock/presentation/pages/home/cubit/home_cubit.dart';
import 'package:readmock/presentation/widgets/custom_scaffold.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

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

    fetchDirections(from, to); // Call fetchDirections here
  }

  Future<void> fetchDirections(LatLng origin, LatLng destination) async {
    final apiKey =
        'AIzaSyBDAit_21ZT1Wdu95dfDAYEnIqz8lwMa2o'; // Replace with your API key
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
        title: Text('Trip Details'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
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
