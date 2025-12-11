import 'package:cuaca_kebun_ku/models/farm_model.dart';
import 'package:cuaca_kebun_ku/page/add_farm.dart';
import 'package:cuaca_kebun_ku/page/detail_farm.dart';
import 'package:cuaca_kebun_ku/page/list_farm.dart';
import 'package:cuaca_kebun_ku/page/location_picker.dart';
import 'package:cuaca_kebun_ku/page/maps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteNamesConst {
  static const farmRouteName = 'farm';
  static const addFarmRouteName = 'add farm';
  static const locationPickerRouteName = 'location picker';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: '/', routes: [
    GoRoute(path: '/', builder: (context, state) => ListFarm()),
    GoRoute(
        path: '/farm',
        name: RouteNamesConst.farmRouteName,
        builder: (context, state) {
          final farmModel = state.extra as FarmModel;
          return DetailFarm(farmModel);
        }),
    GoRoute(path: '/addFarm', builder: (context, state) => AddFarm()),
    GoRoute(
        path: '/addFarm/locationPicker',
        builder: (_, state) => LocationPicker()),
  ]);
});
