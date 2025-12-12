import 'package:cuaca_kebun_ku/blocs/schedule/schedule_bloc.dart';
import 'package:cuaca_kebun_ku/blocs/schedule/schedule_event.dart';
import 'package:cuaca_kebun_ku/blocs/schedule/schedule_state.dart';
import 'package:cuaca_kebun_ku/models/maintenance_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../models/farm_model.dart';

class AddSchedule extends StatefulWidget {
  final FarmModel farmModel;
  const AddSchedule(this.farmModel, {super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'add_schedule');
  final TextEditingController _jenisPemeliharaan = TextEditingController();
  final TextEditingController _luasLahan = TextEditingController();
  final TextEditingController _jenisPupuk = TextEditingController();
  final TextEditingController _tanggalPemeliharaan = TextEditingController();
  final TextEditingController _catatan = TextEditingController();
  final TextEditingController _kegiatan = TextEditingController();
  final List<String> _jenisOptions = ['Pemupukan', 'Pemeliharaan', 'Panen'];
  DateTime? _selectedDate;
  MaintenanceSchedule? _model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Farm'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocListener<ScheduleBloc, ScheduleState>(
        listener: (context, state) {
          if (state is SuccessCreateSchedule) {
            context.pop();
          }
        },
        child: Form(
            key: _formKey,
            onChanged: () {
              _model = MaintenanceSchedule(
                  id: 'id',
                  kebunId: widget.farmModel.id,
                  jenisPemeliharaan: _jenisPemeliharaan.value.text,
                  luasLahan: _luasLahan.value.text,
                  jenisPupuk: _jenisPupuk.value.text,
                  tanggalPemeliharaan: _tanggalPemeliharaan.value.text,
                  catatan: _catatan.value.text,
                  kegiatan: _kegiatan.value.text);
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                      controller: _jenisPemeliharaan,
                      readOnly: true,
                      onTap: _showJenisPemeliharaanPicker,
                      decoration: InputDecoration(
                          labelText: 'Jenis Pemeliharaan',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.location_on),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey, width: 2.0))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tidak Boleh Kosong';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _luasLahan,
                    decoration: InputDecoration(
                        labelText: 'Luas Lahan (m2)',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey, width: 2.0))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tidak Boleh Kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _jenisPupuk,
                    decoration: InputDecoration(
                        labelText: 'Jenis Pupuk',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey, width: 2.0))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tidak Boleh Kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _tanggalPemeliharaan,
                    readOnly: true,
                    onTap: () {
                      _showDatePicker(context);
                    },
                    decoration: InputDecoration(
                        labelText: 'Tanggal Pemeliharaan',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey, width: 2.0))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tidak Boleh Kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _kegiatan,
                    decoration: InputDecoration(
                        labelText: 'Kegiatan',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey, width: 2.0))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tidak Boleh Kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _catatan,
                    decoration: InputDecoration(
                        labelText: 'Catatan',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey, width: 2.0))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tidak Boleh Kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      minimumSize: Size.fromHeight(50),
                    ),
                    onPressed: () {
                      if (_model != null) context.read<ScheduleBloc>().add(AddScheduleEvent(widget.farmModel.id, _model!));
                    },
                    child: Text('Tambah Jadwal Pemeliharaan'),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _tanggalPemeliharaan.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _showJenisPemeliharaanPicker() async {
    final String? selected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Pilih Jenis Pemeliharaan'),
          children: _jenisOptions.map((String value) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, value);
              },
              child: Text(value),
            );
          }).toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _jenisPemeliharaan.text = selected;
      });
    }
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
      barrierDismissible: false, // Prevents dismissal by tapping outside
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
