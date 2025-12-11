import 'package:cuaca_kebun_ku/blocs/map_weather/map_weather_bloc.dart';
import 'package:cuaca_kebun_ku/utilities/cluster_google_map.dart';
import 'package:cuaca_kebun_ku/widgets/weather_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final LatLng latLng;

  const Maps(this.latLng, {super.key});

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> with AutomaticKeepAliveClientMixin {
  final ClusterGoogleMapController _clusterGoogleMapController = ClusterGoogleMapController();
  bool isCollapsed = true;

  @override
  void initState() {
    super.initState();
    context.read<MapWeatherBloc>().add(FetchMapWeather(widget.latLng));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MapWeatherBloc, MapWeatherState>(
      builder: (context, state) {
        if (state is ShowMapWeather) {
          final weatherList = state.weatherList;
          return Column(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: ClusterGoogleMap(
                    key: Key(''),
                    center: widget.latLng,
                    controller: _clusterGoogleMapController,
                    markerList: state.mapMarkerList,
                  )),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Text('City List'),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        child: Icon(
                          isCollapsed
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isCollapsed) {
                              isCollapsed = false;
                            } else {
                              isCollapsed = true;
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              if (isCollapsed)
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: weatherList.length,
                    itemBuilder: (context, index) {
                      final weather = weatherList[index];
                      return WeatherItemWidget(weather: weather!);
                    },
                  ),
                )
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
