import 'package:flutter/material.dart';
import 'package:flutter_application_1_news/src/pages/tabps_page.dart';
import 'package:flutter_application_1_news/src/services/new_service.dart';
import 'package:flutter_application_1_news/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        initialRoute: 'tab',
        routes: {
          'tab': (context) => const TabScreen(),
        },
      ),
    );
  }
}
