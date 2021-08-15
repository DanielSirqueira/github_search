import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: TextField(
              onChanged: bloc.add,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Search'),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: bloc.stream,
              builder: (context, snapshot) {
                final state = bloc.state;

                if (state is SearchStart) {
                  return const Center(
                    child: Text("Digite um texto."),
                  );
                }

                if (state is SearchError) {
                  return const Center(
                    child: Text("Houve um error."),
                  );
                }

                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final list = (state as SearchSuccess).list;

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, id) {
                    final item = list[id];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(item.img),
                      ),
                      title: Text(item.title),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
