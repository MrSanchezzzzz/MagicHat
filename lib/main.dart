import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magic_hat/Utils/cache.dart';
import 'package:magic_hat/Wigets/alert_dialog.dart';

import 'Screens/home_screen.dart';
import 'Screens/list_screen.dart';
import 'Utils/provider.dart';
import 'constants/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
      title: 'Flutter Demo',
      theme: Themes.defaultTheme,
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

  void setCountersFromFile() async {
    await FileManager.loadCountersIntoProviders(ref);
  }

  @override
  void initState() {
    super.initState();
    setCountersFromFile();
  }

  void clearPersonages() async {
    String title = 'Obliviate';
    String text = 'Do you really want to clear all guessed characters and forget them..?';
    String? response = await showAdaptiveDialog<String>(
        builder: (BuildContext context) => MagicAlertDialog(
              title: title,
              text: text,
            ),
        context: context);
    if (response != null) {
      if (response == 'OK') {
        ref.read(totalCounterProvider.notifier).reset();
        ref.read(successCounterProvider.notifier).reset();
        ref.read(failedCounterProvider.notifier).reset();
        FileManager.clear();
        ref.refresh(guessedPersonagesProvider);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const iconSize = 24.0;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'Images/logo.png',
                width: 36,
                height: 36,
              ),
              SizedBox(width: 8),
              const Text("Magic hat"),
            ],
          ),
          actions: [
            Row(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return IconButton(
                        onPressed: clearPersonages,
                        icon: Image.asset(
                          'Images/forget.png',
                          width: 36,
                          height: 36,
                        ));
                  },
                ),
                SizedBox(
                  width: 8,
                )
              ],
            )
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: _selectedIndex == 0 ? Colors.amber.withOpacity(0.5) : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(48))),
                child: Image.asset(
                  'Images/houses_logo.png',
                  width: iconSize,
                  height: iconSize,
                  fit: BoxFit.scaleDown,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: _selectedIndex == 1 ? Colors.amber.withOpacity(0.5) : Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(48))),
                  child: Image.asset('Images/book.png', width: iconSize, height: iconSize, fit: BoxFit.scaleDown),
                ),
                label: ''),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
