import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class FarmState {}

class InitialFarmState extends FarmState {}

class SuccessFetchListFarm extends FarmState {
  final List<Document> farmList;

  SuccessFetchListFarm(this.farmList);

  @override
  String toString() => 'list farm success';
}

class SuccessCreateFarm extends FarmState {
  final Document farmModel;

  SuccessCreateFarm(this.farmModel);

  @override
  String toString() => 'create farm success';
}

class Error extends FarmState {
  final String error;

  Error(this.error);

  @override
  String toString() => 'list farm error';
}

class Loading extends FarmState {}