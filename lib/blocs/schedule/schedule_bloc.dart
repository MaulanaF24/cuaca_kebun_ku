import 'package:cuaca_kebun_ku/blocs/schedule/schedule_event.dart';
import 'package:cuaca_kebun_ku/blocs/schedule/schedule_state.dart';
import 'package:cuaca_kebun_ku/models/maintenance_schedule.dart';
import 'package:cuaca_kebun_ku/repositories/schedule_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleRepository repository = ScheduleRepository();

  ScheduleBloc() : super(InitialScheduleState()) {
    on<FetchListSchedule>((event, state) async {
      try {
        List<MaintenanceSchedule> listSchedule = [];
        listSchedule.clear();
        state(LoadingScheduleState());
        final response = await repository.getListSchedule(event.kebunId);
        for (final document in response) {
          listSchedule.add(MaintenanceSchedule.toModel(document));
        }
        state(SuccessFetchListSchedule(listSchedule));
      } catch (e) {
        state(ErrorScheduleState(e.toString()));
      }
    });

    on<AddScheduleEvent>((event, state) async {
      try {
        state(LoadingScheduleState());
        await repository.createSchedule(event.kebunId, event.model);
        state(SuccessCreateSchedule());
      } catch (e) {
        state(ErrorScheduleState(e.toString()));
      }
    });
  }

}