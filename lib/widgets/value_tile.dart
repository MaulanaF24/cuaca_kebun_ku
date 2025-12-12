import 'package:flutter/material.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? iconData;

  const ValueTile(this.label, this.value, this.iconData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(label),
        SizedBox(
          height: 5,
        ),
        iconData != null
            ? Icon(
                iconData,
                size: 20,
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        Text(
          value,
        ),
      ],
    );
  }
}
