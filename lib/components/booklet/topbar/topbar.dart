import 'package:flutter/material.dart';
import 'package:torrid/components/booklet/topbar/stat_item.dart';

// 统计信息卡片组件.
class Topbar extends StatelessWidget {
  const Topbar({super.key, required this.stats});

  final Map<String, dynamic> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.yellow.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.shade200.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StatItem(
            label: "累计打卡",
            value: "${stats["validCheckIn"]}天",
            icon: Icons.calendar_today,
          ),
          StatItem(
            label: "全通天数",
            value: "${stats["fullyDone"]}天",
            icon: Icons.star,
          ),
          StatItem(
            label: "最长连续",
            value: "${stats["longestStreak"]}天",
            icon: Icons.fireplace,
          ),
        ],
      ),
    );
  }
}
