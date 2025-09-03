import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:torrid/components/home/menu_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // 随机获取一张图片作为大屏壁纸
  final randomIndex = (Random().nextInt(9) + 1).toString();

  // 动画控制器，用于管理菜单滑入滑出动画
  late AnimationController _controller;
  // 侧边菜单滑行动画
  late Animation<Offset> _slideAnimation;
  // 背景遮罩透明度动画
  late Animation<double> _opacityAnimation;
  // 菜单是否打开的状态
  bool _isMenuOpen = false;

  // 菜单按钮数据列表
  final List<ButtonInfo> _buttonInfos = [
    ButtonInfo(name: "积微", icon: Icons.book, route: "booklet"),
    ButtonInfo(name: "随笔", icon: Icons.description, route: "essay"),
    ButtonInfo(name: "其他", icon: Icons.account_tree_rounded, route: "others"),
    ButtonInfo(name: "个人", icon: Icons.person, route: "profile"),
    ButtonInfo(name: "帮助", icon: Icons.help, route: "help"),
  ];

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器，时长300毫秒
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    // 侧边菜单滑入动画：从左侧屏幕外滑到屏幕内
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // 背景遮罩动画：从完全透明到半透明
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    // 释放动画控制器资源
    _controller.dispose();
    super.dispose();
  }

  // 切换菜单显示/隐藏状态
  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      // 根据菜单状态控制动画播放方向
      _isMenuOpen ? _controller.forward() : _controller.reverse();
    });
  }

  // 导航到指定路由
  void _navigateTo(String route) {
    // 使用go_router进行路由跳转
    context.pushNamed(route);
    // 导航后关闭菜单
    if (_isMenuOpen) {
      _toggleMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // 侧边菜单宽度为屏幕宽度的70%
    final menuWidth = size.width * 0.7;

    return Scaffold(
      body: Stack(
        children: [
          // 1. 主内容区域 - 点击任意位置触发菜单
          GestureDetector(
            // 只有当菜单关闭时，点击主区域才会打开菜单
            onTap: !_isMenuOpen ? _toggleMenu : null,
            child: Container(
              constraints: BoxConstraints.expand(),
              child: Image.asset(
                "assets/images/$randomIndex.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. 背景遮罩 - 只在菜单打开时显示，点击遮罩关闭菜单
          if (_isMenuOpen)
            FadeTransition(
              opacity: _opacityAnimation,
              child: GestureDetector(
                onTap: _toggleMenu,
                // 遮罩只覆盖菜单以外的区域
                child: Container(color: Colors.black),
              ),
            ),

          // 3. 侧边菜单
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              width: menuWidth,
              height: size.height,
              // 添加柔和阴影增强层次感
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/soldier.png"),
                  fit: BoxFit.cover,
                  opacity: 0.15
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000), // 淡黑色半透明0x1A000000
                    blurRadius: 12,
                    spreadRadius: 0,
                    offset: Offset(4, 0), // 右侧阴影
                  ),
                ],
              ),
              // 使用AbsorbPointer替代空onTap，更高效地阻止事件传递
              child: AbsorbPointer(
                absorbing: false, // 允许子组件接收事件
                child: Column(
                  children: [
                    // 菜单标题区域
                    const SizedBox(height: 60),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "那么, 你需要的是什么.",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600, // 使用w600替代bold，更精确
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 30,
                      thickness: 1,
                      color: Color(0xFFf1f3f5),
                    ),

                    // 菜单列表
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _buttonInfos.length-1,
                        itemBuilder: (context, index) {
                          final button = _buttonInfos[index];
                          return MenuButton(info: button, func: _navigateTo);
                        },
                      ),
                    ),

                    // 底部Helper选项, 点击查看说明
                    MenuButton(info: _buttonInfos.last, func: _navigateTo),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
