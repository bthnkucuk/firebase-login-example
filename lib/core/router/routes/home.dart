import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/view/home_view.dart';

part 'home.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/home',
  name: 'Home',
  routes: <TypedGoRoute<GoRouteData>>[],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeView();
}
