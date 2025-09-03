import 'package:flutter/material.dart';

class ButtonInfo {
  final String name;
  final IconData icon;
  final String route;

  ButtonInfo({required this.name, required this.icon, required this.route});
}

class MenuButton extends StatelessWidget {
  final ButtonInfo info;
  final Function func;
  const MenuButton({super.key, required this.info, required this.func});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // 确保背景透明
      child: InkWell(
        // 点击反馈区域扩展到整行
        onTap: () => func(info.route),
        // 自定义点击水波纹颜色
        splashColor: Colors.grey[200],
        // 点击高亮颜色
        highlightColor: Colors.grey[100],
        // 圆角水波纹
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 56, // 固定高度确保一致的点击区域
          child: Row(
            children: [
              Icon(info.icon, color: const Color(0xFF495057), size: 24),
              const SizedBox(width: 20), // 替代horizontalTitleGap
              Text(
                info.name,
                style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
