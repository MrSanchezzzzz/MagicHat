import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magic_hat/Utils/provider.dart';
import 'package:magic_hat/Wigets/counters_fragment.dart';

import '../Wigets/list_item.dart';

class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({Key? key}):super(key:key);

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final personages=ref.watch(guessedPersonagesProvider).value??[];
    return Padding(
      padding: EdgeInsets.all(16),
      child:Column(
        children: <Widget>[
          const CountersFragment(),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search characters...',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 16.0),

          Expanded(
            child: ListView.builder(
              itemCount: personages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListItem(personage: personages[index]);
              },

            ),
          ),
        ],
      )
      ,
    );
  }
}
