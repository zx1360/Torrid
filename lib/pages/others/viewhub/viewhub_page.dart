import 'package:flutter/material.dart';
import 'package:torrid/pages/others/viewhub/hub_comic.dart';

class ViewhubPage extends StatelessWidget {
  const ViewhubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) => const HubComic()),
    );
  }
}