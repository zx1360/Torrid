import 'package:torrid/components/booklet/mission_widget.dart';
import 'package:torrid/models/common/message.dart';

List<MissionWidget> generateMissionExamples() {
  final now = DateTime.now();
  final yesterday = now.subtract(const Duration(days: 1));
  final tomorrow = now.add(const Duration(days: 1));
  final lastWeek = now.subtract(const Duration(days: 7));
  final nextWeek = now.add(const Duration(days: 7));
  final twoWeeksAgo = now.subtract(const Duration(days: 14));
  final oneMonthLater = now.add(const Duration(days: 30));

  final commonMessages = [
    Message.noId(
      content: "开始规划任务细节，确定了主要里程碑",
      timestamp: twoWeeksAgo.add(const Duration(hours: 10)),
    ),
    Message.noId(
      content: "完成了第一阶段目标，进展顺利",
      timestamp: lastWeek.add(const Duration(hours: 15)),
    ),
  ];

  return [
    // 1. 有图片 + 有消息
    MissionWidget(
      title: "季度产品迭代",
      description: "完成V2.3版本核心功能开发，包括用户画像和推荐系统优化",
      img: "https://picsum.photos/id/237/400/200",
      messages: [
        ...commonMessages,
        Message.noId(
          content: "推荐算法测试通过，准备进入集成阶段",
          timestamp: yesterday.add(const Duration(hours: 16)),
        ),
      ],
      startDate: twoWeeksAgo,
      status: 0,
      deadline: oneMonthLater,
      setState: () {},
    ),

    // 2. 无图片 + 有消息
    MissionWidget(
      title: "用户体验优化",
      description: "持续收集用户反馈，逐步改进产品交互流程和视觉设计，重点优化首页和个人中心",
      // 不传递img参数，即为无图片
      messages: [
        Message.noId(
          content: "完成首页布局调整方案",
          timestamp: lastWeek.add(const Duration(hours: 9)),
        ),
      ],
      startDate: lastWeek,
      status: 0,
      deadline: null,
      setState: () {},
    ),

    // 3. 有图片 + 无消息
    MissionWidget(
      title: "市场调研报告",
      description: "完成Q3季度行业竞争分析及市场机会评估，包含5家主要竞争对手的详细分析",
      img: "https://picsum.photos/id/240/400/200",
      // 不传递messages参数，使用默认空列表
      startDate: twoWeeksAgo,
      terminateDate: yesterday,
      status: 1,
      deadline: tomorrow,
      setState: () {},
    ),

    // 4. 无图片 + 无消息
    MissionWidget(
      title: "旧系统迁移",
      description: "将 legacy 系统数据迁移至新平台，计划逐步过渡，分三阶段完成",
      // 无图片
      // 无消息
      startDate: twoWeeksAgo,
      terminateDate: yesterday,
      status: 2,
      deadline: nextWeek,
      setState: () {},
    ),

    // 5. 有图片 + 有消息（进行中）
    MissionWidget(
      title: "月度财务报表",
      description: "整理并提交7月份财务数据及分析报告，包括营收、成本和利润分析",
      img: "https://picsum.photos/id/244/400/200",
      messages: [
        Message.noId(
          content: "开始收集各部门财务数据",
          timestamp: yesterday.add(const Duration(hours: 9)),
        ),
      ],
      startDate: yesterday,
      status: 0,
      deadline: tomorrow,
      setState: () {},
    ),
  ];
}
    