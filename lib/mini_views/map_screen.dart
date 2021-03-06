import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizza_order/constants.dart';
import 'package:pizza_order/providers/location_provider.dart';
import 'package:pizza_order/providers/map_provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  // GoogleMapController? _mapController;
  // Set<Marker>? _markers = {};

  // void _setMarker(LatLng location) {
  //   Provider.of<LocationProvider>(context, listen: false)
  //       .getLocation(location: location);

  //   Marker _marker = Marker(
  //     markerId: const MarkerId('location'),
  //     icon: BitmapDescriptor.defaultMarker,
  //     position: location,
  //     infoWindow: const InfoWindow(
  //       title: 'location',
  //       snippet: 'Your current location',
  //     ),
  //   );
  //   setState(() {
  //     _markers!.add(_marker);
  //   });

  //   final CameraPosition _position = CameraPosition(
  //       target: LatLng(location.latitude, location.longitude), zoom: 14.4746);

  //   _mapController!.animateCamera(CameraUpdate.newCameraPosition(_position));
  // }

  @override
  Widget build(BuildContext context) {
    final _location = Constants.locationProvider(context);
    final _map = Constants.mapProvider(context);
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMaps(context, _location, _map),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 30),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 6.4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Current Address',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _location.address,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  GoogleMap _buildGoogleMaps(
      BuildContext context, LocationProvider _location, MapProvider _map) {
    return GoogleMap(
      onTap: (LatLng location) => _map.setMarker(context, location),
      initialCameraPosition: CameraPosition(
        target:
            LatLng(_location.location!.latitude, _location.location!.longitude),
        zoom: 14.4746,
      ),
      markers: _map.markers,
      mapType: MapType.hybrid,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      onMapCreated: (controller) => _map.setMapController(controller),
    );
  }
}
