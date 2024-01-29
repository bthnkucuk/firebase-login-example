import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/view/login_view.dart';
import '../../../features/auth/view/register_view.dart';

part 'auth.g.dart';

@TypedGoRoute<AuthRoute>(
    path: '/auth',
    name: 'Auth',
    routes: <TypedRoute<RouteData>>[
      TypedGoRoute<LoginRoute>(path: 'login', name: 'Login'),
      TypedGoRoute<RegisterRoute>(path: 'register', name: 'Register'),
    ])
class AuthRoute extends GoRouteData {
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginView();
}

class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginView();
}

class RegisterRoute extends GoRouteData {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RegisterView();
}
