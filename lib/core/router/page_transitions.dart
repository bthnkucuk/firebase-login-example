import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

enum PageTransitionType { no, slideUp }

/// NOT: [PageTransitions] is used to define the page transitions.
class PageTransitions<T> extends Page<T> {
  final GoRouterState state;
  final Widget child;
  final PageTransitionType pageTransitionType;

  PageTransitions({
    required this.child,
    required this.state,
    this.pageTransitionType = PageTransitionType.no,
  }) : super(
          name: state.name,
          key: state.pageKey,
          arguments: state.extra,
        );

  @override
  Route<T> createRoute(BuildContext context) {
    switch (pageTransitionType) {
      case PageTransitionType.no:
        return CupertinoPageRoute<T>(
          settings: this,
          builder: (context) => child,
        );
      case PageTransitionType.slideUp:
        return PageRouteBuilder<T>(
          settings: this,
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ),
              ),
              child: child,
            );
          },
        );

      // case PageTransitionTypes.noTransition:
      //   return PageRouteBuilder<T>(
      //     settings: this,
      //     pageBuilder: (context, animation, secondaryAnimation) => child,
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       return child;
      //     },
      //   );

      // case PageTransitionTypes.modalPopup:
      //   return CupertinoModalPopupRoute<T>(
      //     settings: this,
      //     builder: (context) => child,
      //   );
    }
  }
}
