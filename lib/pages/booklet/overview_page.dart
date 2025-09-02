import 'package:flutter/material.dart';
import 'package:torrid/pages/booklet/mission/mission_overview.dart';
import 'package:torrid/pages/booklet/routine/routine_overview.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  // # 打卡页和挑战页之间的切换实现.
  int _curIndex = 0;
  final List<Widget Function()> _pages = [
    () => RoutineOverviewPage(),
    () => MissionOverViewPage(),
  ];
  void _switchIndex(int index) {
    setState(() {
      _curIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 底部栏
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: _curIndex,
        onTap: _switchIndex,
        backgroundColor: Colors.white70, // 白色背景与页面风格统一
        selectedItemColor: Colors.yellow.shade700, // 选中项黄色
        unselectedItemColor: Colors.grey.shade500, // 未选中项灰色
        elevation: 4, // 轻微阴影增强层次感
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              size: 22, // 稍大图标提升识别度
            ),
            activeIcon: Container(
              // 选中项添加黄色背景圈
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.book, size: 22, color: Colors.yellow.shade700),
            ),
            label: "日常打卡", // 更直观的中文标签
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task, size: 22),
            activeIcon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.task, size: 22, color: Colors.yellow.shade700),
            ),
            label: "攻克难关", // 更直观的中文标签
          ),
        ],
      ),

      // 内容
      body: Center(child: _pages[_curIndex]()),
    );
  }
}
