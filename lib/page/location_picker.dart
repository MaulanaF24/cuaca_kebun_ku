import 'package:cuaca_kebun_ku/blocs/user_location/user_location_bloc.dart';
import 'package:cuaca_kebun_ku/models/address_picker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  String? _address;

  @override
  void initState() {
    super.initState();
    context.read<UserLocationBloc>().add(GetUserLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pilih Alamat'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: BlocListener<UserLocationBloc, UserLocationState>(
          listener: (context, state) async {
            if (state is LocationIsDenied) {
              AlertDialog(
                title: Text('Location is Denied'),
                content: Text('Turn Location Permission On'),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Dismiss the dialog
                    },
                  ),
                ],
              );
            }
            if (state is ShowUserLocation) {
              _selectedLocation = state.userLocation;
              _address = await _getAddressFromLatLong(state.userLocation);
              _mapController?.animateCamera(
                CameraUpdate.newLatLng(_selectedLocation!),
              );
              setState(() {});
            }
          },
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: _selectedLocation != null
                        ? _selectedLocation!
                        : LatLng(-6.200000, 106.816666),
                    zoom: 20.0),
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                onCameraMove: (position) {
                  _selectedLocation = position.target;
                },
                onCameraIdle: () async {
                  _address = await _getAddressFromLatLong(_selectedLocation!);
                  setState(() {});
                },
                markers: _selectedLocation == null
                    ? {}
                    : {
                        Marker(
                          markerId: MarkerId('selectedLocation'),
                          position: _selectedLocation!,
                        ),
                      },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          _address != null ? _address! : 'No Location Yet',
                        ),
                        SizedBox(height: 8.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            minimumSize: Size.fromHeight(50),
                          ),
                          onPressed: () {
                            if (_address != null && _selectedLocation != null) {
                              context.pop(AddressPickerModel(address: _address!, position: _selectedLocation!));
                            }
                          },
                          child: Text(
                            'Confirm Location',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<String> _getAddressFromLatLong(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        return address;
      } else {
        return "No address found for these coordinates.";
      }
    } catch (e) {
      return "Error getting address: $e";
    }
  }
}
