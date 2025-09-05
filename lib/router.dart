import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:torrid/pages/home/home_page.dart';

import 'package:torrid/pages/booklet/booklet_page.dart';
import 'package:torrid/pages/essay/essay_page.dart';
import 'package:torrid/pages/news/news_page.dart';
import 'package:torrid/pages/others/others_page.dart';

import 'package:torrid/pages/profile/profile_page.dart';
import 'package:torrid/pages/profile/profile_detail_page.dart';
import 'package:torrid/pages/profile/detail_page/profile_user.dart';
import 'package:torrid/pages/profile/detail_page/profile_preferences.dart';
import 'package:torrid/pages/profile/detail_page/profile_data.dart';
import 'package:torrid/pages/profile/detail_page/profile_account.dart';
import 'package:torrid/pages/profile/detail_page/profile_help.dart';
import 'package:torrid/pages/profile/detail_page/profile_abount.dart';

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

    // 随笔页,
    GoRoute(
      path: "/essay",
      name: "essay",
      builder: (context, state) => EssayPage(),
    ),

    // 早报页,
    GoRoute(
      path: "/news",
      name: "news",
      builder: (context, state) => NewsPage(),
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
    // 个人二级页
    ShellRoute(
      builder: (context, state, child){
        final params = state.extra as Map<String, dynamic>;
        return ProfileDetailPage(title: params['title'], child: child);
      },
      routes: [
        GoRoute(
          path: "/profile_user",
          name: "profile_user",
          builder: (context, state) => ProfileUser(),
        ),
        GoRoute(
          path: "/profile_preferences",
          name: "profile_preferences",
          builder: (context, state) => ProfilePreferences(),
        ),
        GoRoute(
          path: "/profile_data",
          name: "profile_data",
          builder: (context, state) => ProfileData(),
        ),
        GoRoute(
          path: "/profile_account",
          name: "profile_account",
          builder: (context, state) => ProfileAccount(),
        ),
        GoRoute(
          path: "/profile_help",
          name: "profile_help",
          builder: (context, state) => ProfileHelp(),
        ),
        GoRoute(
          path: "/profile_about",
          name: "profile_about",
          builder: (context, state) => ProfileAbout(),
        ),
      ],
    ),
  ],

  // #### 页面不存在
  // 其他情况默认展示错误信息.
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text("页面不存在 ${state.fullPath}"))),
);
