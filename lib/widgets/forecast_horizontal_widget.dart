import 'package:cuaca_kebun_ku/models/weather_model.dart';
import 'package:cuaca_kebun_ku/widgets/value_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForecastHorizontal extends StatelessWidget {
  const ForecastHorizontal({
    required Key key,
    required this.weathers,
  }) : super(key: key);

  final List<Weather?>? weathers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: weathers?.length ?? 0,
        separatorBuilder: (context, index) => Divider(
          height: 100,
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = weathers?[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: ValueTile(
              DateFormat('E, ha').format(
                  DateTime.fromMillisecondsSinceEpoch(item!.time! * 1000)),
              '${item.temperature}°',
              item.getIconData(),
            )),
          );
        },
      ),
    );
  }
}
