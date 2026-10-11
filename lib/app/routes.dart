import '../features/auth/widgets/auth_gate.dart';

class AppRoutes {
  static const initial = '/';

  static final routes = {'/': (context) => const AuthGate()};
}
