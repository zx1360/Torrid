import 'package:hive_flutter/adapters.dart';
import 'package:torrid/models/essay/essay.dart';
import 'package:torrid/models/essay/label.dart';
import 'package:torrid/models/essay/year_summary.dart';

class EssayHiveService {
  // 表名
  static const String essayBoxName = 'essays';
  static const String yearSummaryBoxName = 'year_summaries';
  static const String labelBoxName = 'labels';

  // 初始化Hive
  static Future<void> init() async {
    // 注册适配器
    Hive.registerAdapter(YearSummaryAdapter());
    Hive.registerAdapter(EssayAdapter());
    Hive.registerAdapter(LabelAdapter());

    // 打开(创建)箱
    await Hive.openBox<YearSummary>(essayBoxName);
    await Hive.openBox<Essay>(yearSummaryBoxName);
    await Hive.openBox<Label>(labelBoxName);
  }

  // 关闭箱
  static Future<void> close() async {
    await Hive.close();
  }

  // 定义getter方法.
  static Box<YearSummary> get yearSummaries => Hive.box(yearSummaryBoxName);
  static Box<Essay> get essays => Hive.box(essayBoxName);
  static Box<Label> get labels => Hive.box(labelBoxName);

  // 按年份获取文章
  static List<Essay> getEssayByYear(int year) {
    return essays.values.where((essay) => essay.year == year).toList();
  }

  // 按标签获取文章
  static List<Essay> getEssayByLabel(String labelName) {
    return essays.values
        .where((essay) => essay.labels.contains(labelName))
        .toList();
  }

  // 添加日记

  // 删除日记

  // ######## 内部方法, 用于年份总信息和标签信息的更新
  static Future<void> _updateYearSummary() async {}

  static Future<void> _updateLabelCounts() async {}
}
