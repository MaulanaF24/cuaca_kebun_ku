import 'package:cuaca_kebun_ku/models/maintenance_schedule.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ScheduleEvent {}

class FetchListSchedule extends ScheduleEvent {
  final String kebunId;

  FetchListSchedule(this.kebunId);

  @override
  String toString() => 'fetch list schedule : $kebunId';
}

class AddScheduleEvent extends ScheduleEvent {
  final String kebunId;
  final MaintenanceSchedule model;

  AddScheduleEvent(this.kebunId, this.model);

  @override
  String toString() => 'add schedule id : $kebunId';
}

class DeleteScheduleEvent extends ScheduleEvent {
  final String id;

  DeleteScheduleEvent(this.id);

  @override
  String toString() => 'delete schedule : $id';
}