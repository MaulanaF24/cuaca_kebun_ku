import 'package:cuaca_kebun_ku/models/farm_model.dart';
import 'package:cuaca_kebun_ku/page/farm_schedule.dart';
import 'package:cuaca_kebun_ku/page/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailFarm extends StatefulWidget {
  final FarmModel farmModel;

  const DetailFarm(this.farmModel, {super.key});

  @override
  State<DetailFarm> createState() => _DetailFarmState();
}

class _DetailFarmState extends State<DetailFarm> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Cuaca Kebun')),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(text: 'Peta Cuaca'),
              Tab(text: 'Detail Kebun'),
            ]),
            Expanded(
              child: TabBarView(children: [
                Maps(LatLng(widget.farmModel.latitude, widget.farmModel.longitude)),
                FarmSchedule(widget.farmModel),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
