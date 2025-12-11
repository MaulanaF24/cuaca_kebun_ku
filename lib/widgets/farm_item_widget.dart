import 'package:cuaca_kebun_ku/app_route.dart';
import 'package:cuaca_kebun_ku/models/farm_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FarmItemWidget extends StatelessWidget {
  final FarmModel farmModel;

  const FarmItemWidget({super.key, required this.farmModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(RouteNamesConst.farmRouteName, extra: farmModel);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 2.0, right: 10.0, top: 6.0, bottom: 6.0),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.home,
                      size: 48.0,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            farmModel.namaKebun ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 10.0),
                          ),
                          Text(
                            farmModel.alamat ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14.0),
                          ),
                          Text(farmModel.latitude.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 10.0)),
                          Text(
                            farmModel.longitude.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 10.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
