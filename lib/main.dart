import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/image_provider.dart'; // Import the provider
import 'screens/home_sceen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ImageProviderClass(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PicPick',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomeScreen(),
    );
  }
}
