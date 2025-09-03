import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:torrid/pages/help/help_page.dart';

import 'package:torrid/pages/home/home_page.dart';

import 'package:torrid/pages/booklet/booklet_page.dart';
import 'package:torrid/pages/booklet/overview_page.dart';

import 'package:torrid/pages/essay/essay_page.dart';
import 'package:torrid/pages/others/others_page.dart';
import 'package:torrid/pages/profile/profile_page.dart';

final GoRouter router = GoRouter(
  initialLocation: "/home",

  routes: [
    // #### 栈底页: 桌面页
    // HOME页.
    GoRoute(
      path: "/home",
      name: "home",
      builder: (context, state) => HomePage(),
    ),

    // #### 主要页
    // 积微页, 打卡/挑战.
    GoRoute(
      path: "/booklet",
      name: "booklet",
      builder: (context, state) => BookletPage(),
    ),
    GoRoute(
      path: "/booklet_overview",
      name: "booklet_overview",
      builder: (context, state) => OverviewPage(),
    ),

    // 随笔页,
    GoRoute(
      path: "/essay",
      name: "essay",
      builder: (context, state) => EssayPage(),
    ),

    // 其他页.
    GoRoute(
      path: "/others",
      name: "others",
      builder: (context, state) => OthersPage(),
    ),

    // 个人信息页
    GoRoute(
      path: "/profile",
      name: "profile",
      builder: (context, state) => ProfilePage(),
    ),

    // 应用帮助页
    GoRoute(
      path: "/help",
      name: "help",
      builder: (context, state) => HelpPage(),
    )
  ],

  // #### 页面不存在
  // 其他情况默认展示错误信息.
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text("页面不存在 ${state.fullPath}"))),
);
