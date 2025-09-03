import 'package:flutter/material.dart';
import 'package:torrid/pages/others/entry_button.dart';

import 'package:torrid/pages/others/news/news_page.dart';
import 'package:torrid/pages/others/realm/realm_page.dart';
import 'package:torrid/pages/others/tuntun/tuntun_page.dart';
import 'package:torrid/pages/others/viewhub/viewhub_page.dart';

class OtherPagesData {
  static List<PageItem> get pages => [
        PageItem(
          label: "领域",
          icon: Icons.category,
          builder: (context) => RealmPage(),
        ),
        PageItem(
          label: "早报",
          icon: Icons.newspaper,
          builder: (context) => NewsPage(),
        ),
        // 影视页, 媒体查看.
        PageItem(
          label: "媒体",
          icon: Icons.grid_view,
          builder: (context) => ViewhubPage(),
        ),
        // 战利品页.
        PageItem(
          label: "藏品",
          icon: Icons.assessment,
          builder: (context) => TuntunPage(),
        ),
        // 未来添加新页面只需在这里添加
      ];
}