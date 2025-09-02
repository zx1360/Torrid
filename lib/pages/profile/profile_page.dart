import 'package:flutter/material.dart';
import 'package:torrid/services/hive_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;

  void changeLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(child: Text("稍等..."))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.pink[400]),
                  child: Text(
                    "备份数据到其他设备\n 没完全实现. 点了就卡死!  (●'◡'●)",
                    style: TextStyle(color: const Color.fromARGB(255, 62, 15, 1)),
                  ),
                ),
                TextButton.icon(
                  onPressed: () async {
                    changeLoading(true);
                    await HiveService.syncBooklet();
                    changeLoading(false);
                  },
                  icon: Icon(Icons.sync),
                  label: Text("同步到本地"),
                ),
                TextButton.icon(
                  onPressed: () async {
                    changeLoading(true);
                    await HiveService.updateBooklet();
                    changeLoading(false);
                  },
                  icon: Icon(Icons.upload),
                  label: Text("更新到外部"),
                ),
              ],
            ),
    );
  }
}
