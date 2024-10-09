import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.onInitializationComplete});
  final VoidCallback onInitializationComplete;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5))
        .then((_) => widget.onInitializationComplete());
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flickd_app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
