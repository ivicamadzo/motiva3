import 'package:flutter/material.dart';

import '../../../core/firebase/firebase_support.dart';
import '../../home/screens/home_screen.dart';
import '../../panic/screens/panic_home_screen.dart';
import '../../appsupport/screens/appsupport_screen.dart';
import '../screens/auth_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    if (!FirebaseSupport.isEnabled) {
      return const _AuthenticatedShell();
    }

    return StreamBuilder(
      stream: FirebaseSupport.auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const _AuthenticatedShell();
        }

        return const AuthScreen();
      },
    );
  }
}

class _AuthenticatedShell extends StatefulWidget {
  const _AuthenticatedShell();

  @override
  State<_AuthenticatedShell> createState() => _AuthenticatedShellState();
}

class _AuthenticatedShellState extends State<_AuthenticatedShell> {
  int _currentIndex = 0;

  static const _screens = [HomeScreen(), PanicHomeScreen(), AppsupportScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Почетна',
          ),
          NavigationDestination(
            icon: Icon(Icons.spa_outlined),
            selectedIcon: Icon(Icons.spa),
            label: 'Релаксација',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Поддржи',
          ),
        ],
      ),
    );
  }
}
