import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torrid/router.dart';

import 'package:torrid/services/hive_service.dart';
import 'package:torrid/services/booklet_hive_service.dart';
import 'package:torrid/services/essay_hive_service.dart';

void main() async {
  // // 1.确保Flutter绑定初始化
  WidgetsFlutterBinding.ensureInitialized();
  // // 2.其他初始化(Hive)
  await HiveService.init();
  await BookletHiveService.init();
  await EssayHiveService.init();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "torrid",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),

      // 关联路由配置
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
