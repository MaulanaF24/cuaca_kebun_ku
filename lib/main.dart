import 'package:appwrite/models.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_bloc.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_event.dart';
import 'package:cuaca_kebun_ku/blocs/farm/farm_state.dart';
import 'package:cuaca_kebun_ku/utilities/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuaca Kebun Ku',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => FarmBloc(),
          child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Document> listFarm = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FarmBloc>(context).add(FetchListFarm());
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
          if (state is Loading) {

          }
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
            BlocProvider.of<FarmBloc>(context).add(FetchListFarm());
          },
          child: listFarm.isEmpty
              ? const Center(
            child: Text("No farm yet!"),
          ) : ListView.builder(
            itemCount: listFarm.length,
            itemBuilder: (context, index) {
              final farm = listFarm[index];
              return Dismissible(
                key: Key(farm.$id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Delete', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                      Icon(Icons.delete, color: Colors.white),
                    ],
                  ),
                ),
                child: CheckboxListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)
                  ),
                  side: WidgetStateBorderSide.resolveWith(
                          (states) => BorderSide(width: 1.0, color: Colors.blue)
                  ),
                  title: Text(farm.data['nama_kebun']),
                  subtitle: Text(farm.data['alamat']),
                  value: false,
                  onChanged: (value) {
                    if (value != null) {
                      //updateNotes(notes.$id, value);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed:() {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Notes'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(labelText: 'Description'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
                          //createNotes(titleController.text, descriptionController.text);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              });
        },
        tooltip: 'Add Farm',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



