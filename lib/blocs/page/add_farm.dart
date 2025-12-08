import 'package:flutter/material.dart';

class AddFarm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _namaKebun = '';
  String _alamat = '';

  AddFarm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          onChanged: () {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama Kebun',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0
                      )
                    )
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak Boleh Kosong';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _namaKebun = value!;
                  },
                ),
                SizedBox(height: 8.0,),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'alamat',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0
                          )
                      )
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak Boleh Kosong';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _alamat = value!;
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _addFarm,
                  child: Text('Tambah Kebun'),
                ),
              ],
            ),
          )),
    );
  }

  void _addFarm () {

  }
}
