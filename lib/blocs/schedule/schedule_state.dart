
import 'package:cuaca_kebun_ku/models/maintenance_schedule.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ScheduleState {}

class InitialScheduleState extends ScheduleState {}

class SuccessFetchListSchedule extends ScheduleState {
  final List<MaintenanceSchedule> scheduleList;

  SuccessFetchListSchedule(this.scheduleList);

  @override
  String toString() => 'success fetch list schedule';
}

class SuccessCreateSchedule extends ScheduleState {
  @override
  String toString() => 'success create schedule';
}

class ErrorScheduleState extends ScheduleState {
  final String error;

  ErrorScheduleState(this.error);

  @override
  String toString() => 'list schedule error';
}

class LoadingScheduleState extends ScheduleState {}