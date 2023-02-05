import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserState with ChangeNotifier {
  String _name = 'John Doe';

  String get name => _name;

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class ThemeState with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void updateTheme(bool newTheme) {
    _isDark = newTheme;
    notifyListeners();
  }
}

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserState()),
        ChangeNotifierProvider(create: (context) => ThemeState()),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserState>(context, listen: false);
    var theme = Provider.of<ThemeState>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<UserState>(
              builder: (context, userState, child) {
                return Text('Hello ${user.name}');
              },
            ),
            ElevatedButton(
              child: Text('Update Name'),
              onPressed: () => user.updateName('Jhonny Doe'),
            ),
            SizedBox(height: 10),
            Consumer<ThemeState>(
              builder: (context, userState, child) {
                return Text('Dark Mode: ${theme.isDark ? 'On' : 'Off'}');
              },
            ),
            ElevatedButton(
              child: Text('Toggle Dark Mode'),
              onPressed: () => theme.updateTheme(!theme.isDark),
            ),
          ],
        ),
      ),
    );
  }
}
