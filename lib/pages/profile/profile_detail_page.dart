import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人详细页"),
      ),
      body: GoRouter.of(context).routerDelegate.build(context)
    );
  }
}