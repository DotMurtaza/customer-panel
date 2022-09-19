import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
    required this.destinationLat,
    required this.destinationLng,
  }) : super(key: key);
  final double destinationLat;
  final double destinationLng;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

LocationData? currentLocation;
final customerController = Get.put(CustomerController());

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static LatLng sourceLocation =
      LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

  List<LatLng> polylineCoordinates = [];

  Future<void> getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(newLoc.latitude!, newLoc.longitude!),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  LatLng? destination;
  Future<void> getPolyPoints() async {
    destination = LatLng(widget.destinationLat, widget.destinationLng);
    PolylinePoints polylinePoints = PolylinePoints();
    // PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        // APIClass().API,
        'AIzaSyB3obNU-etSFBmOde_ZLDCeSk3QFngjBVk',
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(widget.destinationLat, widget.destinationLng));
    print(result.points);
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   APIClass().API,
    //   PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
    //   PointLatLng(destination.latitude, destination.longitude),
    // );
    print(
        'Lattitude:${PointLatLng(sourceLocation.latitude, sourceLocation.longitude)}');
    if (result.points.isNotEmpty) {
      print('it is working');
      // ignore: avoid_function_literals_in_foreach_calls
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        FirebaseFirestore.instance
            .collection("Customer")
            .doc(customerController.auth.currentUser!.uid)
            .update({'location': GeoPoint(point.latitude, point.longitude)});
      });

      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : FutureBuilder(
              future: getCurrentLocation(),
              builder: (context, snapshot) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!),
                      zoom: 12.5),
                  polylines: {
                    Polyline(
                        polylineId: const PolylineId("route"),
                        points: polylineCoordinates,
                        color: Colors.green,
                        width: 6),
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("currentLocation"),
                      position: LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!),
                    ),
                    Marker(
                      markerId: const MarkerId("source"),
                      position: sourceLocation,
                    ),
                    Marker(
                      markerId: MarkerId("destination"),
                      position: destination!,
                    ),
                  },
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                  },
                );
              }),
    );
  }
}
