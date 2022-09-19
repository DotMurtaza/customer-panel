// import 'package:flutter/material.dart';
// import 'package:foodbari_deliver_app/utils/constants.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   static const _initialCameraPosition =
//       CameraPosition(target: LatLng(37.773972, -122.431297), zoom: 11.5);
//   GoogleMapController? _googleMapController;

//   @override
//   void dispose() {
//     _googleMapController!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         myLocationButtonEnabled: false,
//         zoomControlsEnabled: false,
//         initialCameraPosition: _initialCameraPosition,
//         onMapCreated: (controller) => _googleMapController = controller,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.black,
//         onPressed: () => _googleMapController!.animateCamera(
//             CameraUpdate.newCameraPosition(_initialCameraPosition)),
//         child: const Icon(Icons.center_focus_strong),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destinationLocation = LatLng(37.33429383, -122.06600055);

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAtM8lId-fAURr8doyrJa1CiBjN_2k-lp4',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: sourceLocation, zoom: 12.5),
      polylines: {
        Polyline(
          polylineId: PolylineId("route"),
          points: polylineCoordinates,
        ),
      },
      markers: {
        const Marker(
          markerId: MarkerId("Source"),
          position: sourceLocation,
        ),
        const Marker(
          markerId: MarkerId("destination"),
          position: destinationLocation,
        ),
      },
    );
  }
}
