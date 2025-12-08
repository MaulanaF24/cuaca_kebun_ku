import 'package:appwrite/models.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_event.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_state.dart';
import 'package:cuaca_kebun_ku/repositories/farm_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmBloc extends Bloc<FarmEvent, FarmState> {
  FarmRepository repository = FarmRepository();
  List<Document>? listFarm;

  FarmBloc() : super(InitialFarmState()) {
    on<FetchListFarm>((event, state) async {
      try {
        state(Loading());
        final response = await repository.fetchListFarm();
        if (response.isNotEmpty) {
          state(SuccessFetchListFarm(response));
        } else {
          state(SuccessFetchListFarm([]));
        }
      } catch (e) {
        state(Error(e.toString()));
      }
    });

    on<AddFarm>((event, state) async {
      try {
        state(Loading());
        final model = event.farmModel;
        final response = await repository.createFarm(
            model.namaKebun, model.alamat, model.latitude, model.longitude);
        state(SuccessCreateFarm(response));
      } catch (e) {
        state(Error(e.toString()));
      }
    });
  }
}
