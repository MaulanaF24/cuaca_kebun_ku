import 'package:cuaca_kebun_ku/blocs/get_weather/get_weather_bloc.dart';
import 'package:cuaca_kebun_ku/blocs/get_weather/get_weather_event.dart';
import 'package:cuaca_kebun_ku/blocs/get_weather/get_weather_state.dart';
import 'package:cuaca_kebun_ku/models/farm_model.dart';
import 'package:cuaca_kebun_ku/utilities/cluster_google_map.dart';
import 'package:cuaca_kebun_ku/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final FarmModel farmModel;

  const Maps(this.farmModel, {super.key});

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> with AutomaticKeepAliveClientMixin {
  final ClusterGoogleMapController _clusterGoogleMapController =
      ClusterGoogleMapController();
  bool isCollapsed = true;
  LatLng? latLng;

  @override
  void initState() {
    super.initState();
    latLng = LatLng(widget.farmModel.latitude, widget.farmModel.longitude);
    context.read<GetWeatherBloc>().add(FetchWeather(latLng!));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<GetWeatherBloc, GetWeatherState>(
      builder: (context, state) {
        if (state is ShowWeatherState) {
          return Column(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: ClusterGoogleMap(
                    key: Key(''),
                    center: latLng!,
                    controller: _clusterGoogleMapController,
                    markerList: state.markerList,
                  )),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Prakiraan Cuaca Kebun',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
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
                    child: WeatherWidget(
                        weather: state.weatherModel,
                        farmModel: widget.farmModel))
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
