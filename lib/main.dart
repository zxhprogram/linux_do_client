import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linux_do/pages/HomePage.dart';
import 'package:linux_do/pages/TopicDetailPage.dart';
import 'package:linux_do/state/GlobalStateProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GlobalStateProvider()),
    ],
    child: const App(),
  ));
}

PageRouteBuilder _createPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(seconds: 3),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // 从右侧滑入
      const end = Offset.zero; // 到达目标位置
      const curve = Curves.ease; // 动画曲线

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

final GoRouter _router = GoRouter(initialLocation: '/', routes: [
  ShellRoute(
      builder: (ctx, state, child) {
        return HomePage(secondPart: child);
      },
      routes: [
        ShellRoute(
            builder: (ctx, state, child) {
              return SecondNavigationPart(child);
            },
            routes: [
              GoRoute(
                path: '/',
                pageBuilder: (ctxg, stateg) {
                  print('----> ${stateg.extra}');
                  return CustomTransitionPage(
                    child: TopicDetailPage(
                      topicId:
                          stateg.extra == null ? null : stateg.extra as int,
                    ),
                    transitionsBuilder:
                        (c1, animation, secondaryAnimation, child) {
                      return _createPageRoute(child).buildTransitions(
                          c1, animation, secondaryAnimation, child);
                    },
                  );
                },
              ),
              GoRoute(
                path: '/childPage1',
                pageBuilder: (ctxg, stateg) {
                  return CustomTransitionPage(
                    child: Container(
                      color: Colors.red,
                    ),
                    transitionsBuilder:
                        (c1, animation, secondaryAnimation, child) {
                      return _createPageRoute(child).buildTransitions(
                          c1, animation, secondaryAnimation, child);
                    },
                  );
                },
              ),
            ]),
        ShellRoute(
            builder: (ctx, state, child) {
              return ThirdNavigationPart(child);
            },
            routes: [
              GoRoute(
                path: '/page2',
                pageBuilder: (ctxg, stateg) {
                  return CustomTransitionPage(
                    child: Container(
                      color: Colors.yellowAccent,
                    ),
                    transitionsBuilder:
                        (c1, animation, secondaryAnimation, child) {
                      return _createPageRoute(child).buildTransitions(
                          c1, animation, secondaryAnimation, child);
                    },
                  );
                },
              ),
              GoRoute(
                path: '/childPage2',
                pageBuilder: (ctxg, stateg) {
                  return CustomTransitionPage(
                    child: Container(
                      color: Colors.black26,
                    ),
                    transitionsBuilder:
                        (c1, animation, secondaryAnimation, child) {
                      return _createPageRoute(child).buildTransitions(
                          c1, animation, secondaryAnimation, child);
                    },
                  );
                },
              ),
            ]),
      ]),
]);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(Colors.pinkAccent),
          thickness: WidgetStateProperty.all(2.0),
          trackBorderColor: WidgetStatePropertyAll(Colors.blue),
        ),
      ),
      routerConfig: _router,
    );
  }
}
