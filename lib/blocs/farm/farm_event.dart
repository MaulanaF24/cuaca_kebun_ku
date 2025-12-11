import 'package:cuaca_kebun_ku/models/farm_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class FarmEvent {}

class FetchListFarm extends FarmEvent {
  @override
  String toString() => 'fetch list farm';
}

class AddFarmEvent extends FarmEvent {
  final FarmModel farmModel;

  AddFarmEvent(this.farmModel);

  @override
  String toString() => 'add farm';
}

class DeleteFarm extends FarmEvent {
  @override
  String toString() => 'delete farm';
}