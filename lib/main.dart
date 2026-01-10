import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vcard/pages/homepage.dart';
import 'package:vcard/pages/scanpage.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple, brightness: Brightness.dark), 
        useMaterial3: true
      ),
      
    );
  }
}

final _router =GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: HomePage.routeName,
    name: HomePage.routeName,
    builder:(context, state) => const HomePage(),
    routes: [
      GoRoute(path: ScanPage.routeName,
      name: ScanPage.routeName,
      builder: (context, state) => 
        const ScanPage(),
      
      ),
    ]
    ),

  ]
);