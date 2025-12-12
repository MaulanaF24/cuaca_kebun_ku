import 'package:cuaca_kebun_ku/app_route.dart';
import 'package:cuaca_kebun_ku/blocs/schedule/schedule_bloc.dart';
import 'package:cuaca_kebun_ku/blocs/schedule/schedule_event.dart';
import 'package:cuaca_kebun_ku/blocs/schedule/schedule_state.dart';
import 'package:cuaca_kebun_ku/models/maintenance_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../models/farm_model.dart';

class FarmSchedule extends StatefulWidget {
  final FarmModel farmModel;

  const FarmSchedule(this.farmModel, {super.key});

  @override
  State<FarmSchedule> createState() => _FarmScheduleState();
}

class _FarmScheduleState extends State<FarmSchedule> {
  List<MaintenanceSchedule> scheduleList = [];

  @override
  void initState() {
    super.initState();
    _fetchScheduleList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScheduleBloc, ScheduleState>(
      listener: (context, state) {
        if (state is LoadingScheduleState) {
          _showLoadingDialog(context);
        }
        if (state is SuccessFetchListSchedule) {
          _dismissLoadingDialog(context);
          scheduleList = state.scheduleList;
          setState(() {});
        }
        if (state is SuccessCreateSchedule) {
          _dismissLoadingDialog(context);
          _fetchScheduleList();
        }
        if (state is ErrorScheduleState) {
          _dismissLoadingDialog(context);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Error Occurred'),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.home, color: Colors.blue, size: 24.0),
                      SizedBox(width: 8),
                      Text(widget.farmModel.namaKebun,
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(widget.farmModel.alamat),
                  SizedBox(height: 8.0),
                  Text(widget.farmModel.latitude.toString()),
                  SizedBox(height: 8.0),
                  Text(widget.farmModel.longitude.toString()),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                        minimumSize: Size.fromHeight(50),
                      ),
                      onPressed: () {
                        context.pushNamed(RouteNamesConst.addScheduleRouteName,
                            extra: widget.farmModel);
                      },
                      child: Text('Tambah Jadwal Pemeliharaan'))
                ],
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.library_books_sharp, color: Colors.blue, size: 24.0),
              SizedBox(width: 8),
              Text('Daftar Jadwal Pemeliharaan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8.0),
          Expanded(
              child: scheduleList.isEmpty
                  ? const Center(
                      child: Text("No schedule yet!"),
                    )
                  : ListView.builder(
                      itemCount: scheduleList.length,
                      itemBuilder: (context, index) {
                        final schedule = scheduleList[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 4.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            elevation: 4.0,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.library_books_sharp,
                                          color: Colors.blue, size: 24.0),
                                      SizedBox(width: 8),
                                      Text(schedule.jenisPemeliharaan,
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(schedule.tanggalPemeliharaan),
                                  SizedBox(height: 8.0),
                                  Text('${schedule.luasLahan} m2'),
                                  SizedBox(height: 8.0),
                                  Text(schedule.kegiatan),
                                  SizedBox(height: 8.0),
                                  Text(schedule.catatan),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ))
        ],
      ),
    );
  }

  void _fetchScheduleList() {
    context.read<ScheduleBloc>().add(FetchListSchedule(widget.farmModel.id));
  }

  void _dismissLoadingDialog(BuildContext context) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showLoadingDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Text("Loading...")),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
