import 'package:cuaca_kebun_ku/blocs/farm/farm_bloc.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_event.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_state.dart';
import 'package:cuaca_kebun_ku/models/address_picker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../models/farm_model.dart';

class AddFarm extends StatefulWidget {
  const AddFarm({super.key});

  @override
  State<AddFarm> createState() => _AddFarmState();
}

class _AddFarmState extends State<AddFarm> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'add_farm');

  final TextEditingController _namaKebun = TextEditingController();

  final TextEditingController _alamat = TextEditingController();

  final TextEditingController _latitude = TextEditingController();

  final TextEditingController _longitude = TextEditingController();

  FarmModel? _model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Farm'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocListener<FarmBloc, FarmState>(
        listener: (context, state) {
          if (state is Loading) {
            _showLoadingDialog(context);
          }
          if (state is SuccessCreateFarm) {
            _dismissLoadingDialog(context);
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text('Success Crate Farm'),
                content: Text(''),
                actions: [
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      context.pop(true);
                    },
                  ),
                ],
              );
            });
          }
        },
        child: Stack(
          children: [
            Form(
                key: _formKey,
                onChanged: () {
                  _model = FarmModel(
                      'id',
                      _namaKebun.value.text,
                      _alamat.value.text,
                      _toDouble(_latitude.value.text),
                      _toDouble(_longitude.value.text));
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _namaKebun,
                        decoration: InputDecoration(
                            labelText: 'Nama Kebun',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue, width: 2.0))),
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
                          controller: _alamat,
                          readOnly: true,
                          onTap: () {
                            GoRouter.of(context)
                                .push('/addFarm/locationPicker')
                                .then((result) {
                              if (result != null) {
                                final r = result as AddressPickerModel;
                                _alamat.text = r.address.toString();
                                _latitude.text = r.position.latitude.toString();
                                _longitude.text = r.position.longitude.toString();
                              }
                            });
                          },
                          decoration: InputDecoration(
                              labelText: 'Alamat',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.location_on),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0))),
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
                        controller: _latitude,
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'Latitude',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue, width: 2.0))),
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
                        controller: _longitude,
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'Longitude',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue, width: 2.0))),
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
                          if (_formKey.currentState!.validate()) context.read<FarmBloc>().add(AddFarmEvent(_model!));
                        },
                        child: Text('Tambah Kebun'),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
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

  double _toDouble(String number) {
    try {
      double parsedDouble = double.parse(number);
      return parsedDouble;
    } on FormatException catch (_) {
      return 0.0;
    }
  }
}
