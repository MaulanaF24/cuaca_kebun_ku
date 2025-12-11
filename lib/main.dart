import 'package:cuaca_kebun_ku/app_route.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_bloc.dart';
import 'package:cuaca_kebun_ku/blocs/map_weather/map_weather_bloc.dart';
import 'package:cuaca_kebun_ku/blocs/user_location/user_location_bloc.dart';
import 'package:cuaca_kebun_ku/utilities/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);
    return MultiBlocProvider(
        providers: [
          BlocProvider<FarmBloc>(create: (context) => FarmBloc()),
          BlocProvider<UserLocationBloc>(create: (context) => UserLocationBloc()),
          BlocProvider<MapWeatherBloc>(create: (context) => MapWeatherBloc())
        ],
        child: BlocBuilder<UserLocationBloc, UserLocationState>(
          builder: (context, state) {
            return MaterialApp.router(
                routerConfig: goRouter,
                title: 'Cuaca Kebun Ku',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
                  useMaterial3: true,
                ));
          },
        ));
  }
}
