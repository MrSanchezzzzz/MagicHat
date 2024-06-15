import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magic_hat/Utils/cache.dart';

import 'Screens/home_screen.dart';
import 'Screens/list_screen.dart';
import 'Utils/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    ));
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void setCountersFromFile() async{
    await FileManager.loadCountersIntoProviders(ref);
  }
  @override
  void initState() {
    super.initState();
    setCountersFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Magic hat"),
          actions: [
            Consumer(
              builder: (context,ref,child){
                return IconButton(
                    onPressed: (){
                      ref.read(totalCounterProvider.notifier).reset();
                      ref.read(successCounterProvider.notifier).reset();
                      ref.read(failedCounterProvider.notifier).reset();
                      FileManager.clear();
                      //ref.read(guessedPersonagesProvider.notifier);
                    },
                    icon: Icon(Icons.refresh));
              },
            )

          ],
          backgroundColor: Colors.amber[800],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
