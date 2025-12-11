import 'package:appwrite/models.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_bloc.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_event.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_state.dart';
import 'package:cuaca_kebun_ku/models/farm_model.dart';
import 'package:cuaca_kebun_ku/widgets/farm_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListFarm extends StatefulWidget {
  const ListFarm({super.key});

  @override
  State<ListFarm> createState() => _ListFarmState();
}

class _ListFarmState extends State<ListFarm> {
  List<Document> listFarm = [];

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    context.read<FarmBloc>().add(FetchListFarm());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Daftar Kebun'),
      ),
      body: BlocListener<FarmBloc, FarmState>(
        listener: (bloc, state) {
          if (state is Loading) {}
          if (state is SuccessFetchListFarm) {
            _refreshController.refreshCompleted(resetFooterState: false);
            listFarm = state.farmList;
            setState(() {});
          }
          if (state is Error) {
            _refreshController.refreshCompleted(resetFooterState: false);
          }
        },
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh: () {
            context.read<FarmBloc>().add(FetchListFarm());
          },
          child: listFarm.isEmpty
              ? const Center(
                  child: Text("No farm yet!"),
                )
              : ListView.builder(
                  itemCount: listFarm.length,
                  itemBuilder: (context, index) {
                    final farm = listFarm[index];
                    final farmModel = FarmModel(
                        farm.$id,
                        farm.data['nama_kebun'],
                        farm.data['alamat'],
                        farm.data['latitude'],
                        farm.data['longitude']);
                    return FarmItemWidget(farmModel: farmModel);
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: () {
          GoRouter.of(context).push('/addFarm').then((result) {
            if (result != null) {
              if (result is bool && result) {
                _refreshController.requestRefresh();
              }
            }
          });
        },
        tooltip: 'Add Farm',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
