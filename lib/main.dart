import 'package:coffee/cupping/model_provider.dart/cupping_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // 1. Import package provider
import 'package:coffee/login/loginPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      // 3. คลุม MyApp ด้วย MultiProvider
      // เพื่อให้ข้อมูล CuppingProvider ส่งไปถึงทุกหน้าในแอป
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => CuppingProvider())],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.brown, fontFamily: 'Sukhumvit'),
      home: const LoginPage(),
    );
  }
}
