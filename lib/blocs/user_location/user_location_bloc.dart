import 'package:cuaca_kebun_ku/blocs/user_location/user_location_event.dart';
import 'package:cuaca_kebun_ku/blocs/user_location/user_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

export 'package:cuaca_kebun_ku/blocs/user_location/user_location_event.dart';
export 'package:cuaca_kebun_ku/blocs/user_location/user_location_state.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState> {
  Position? position;

  UserLocationBloc(super.initialState);

  UserLocationState get initialState => InitialUserLocationState();

  Stream<UserLocationState> mapEventToState(UserLocationEvent event) async* {
    if (event is GetUserLocation) {
      yield* mapGetUserLocationToState(event);
    }
  }

  Stream<UserLocationState> mapGetUserLocationToState(
      GetUserLocation event) async* {
    try {
      PermissionStatus permission = await Permission.location.request();
      if (permission == PermissionStatus.granted) {
        position = await Geolocator.getCurrentPosition(
            locationSettings: LocationSettings(
              accuracy: LocationAccuracy.best,
              distanceFilter: 0
            ));
        final locationEnabled = await Geolocator.isLocationServiceEnabled();
        if (locationEnabled) {
          yield ShowUserLocation(LatLng(position!.latitude, position!.longitude));
        } else {
          yield LocationIsDisable();
        }
      } else {
        yield LocationIsDenied();
      }
    } catch (e) {
      yield FailedUserLocation(e.toString());
    }
  }
}
