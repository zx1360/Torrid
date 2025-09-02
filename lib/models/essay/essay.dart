import 'package:hive/hive.dart';
import 'package:torrid/models/common/message.dart';
import 'package:torrid/util/util.dart';

part 'essay.g.dart';

@HiveType(typeId: 1)
class Essay {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final int isPublic;

  @HiveField(3)
  final int wordCount;

  @HiveField(4)
  final String content;

  @HiveField(5)
  final List<String> imgs;

  @HiveField(6)
  final List<String> labels;

  @HiveField(7)
  final List<Message> messages;

  // TODO: 对以前的日记的留言, 也许像链表一样再接上另一个Essay实例?

  Essay({
    required this.id,
    required this.date,
    required this.isPublic,
    required this.wordCount,
    required this.content,
    required this.imgs,
    required this.labels,
    this.messages = const [],
  });

  factory Essay.fromJson(Map<String, dynamic> json) {
    return Essay(
      id: Util.generateId(),
      date: json['create_time'],
      isPublic: json['is_public'],
      wordCount: json['wordCount'],
      content: json['content'],
      imgs: json['imgs'],
      labels: json['labels'],
      messages: (json['messages'] as List)
          .map((item) => Message.fromJson(item))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date..toLocal().toString().split('.').first,
      "isPublic": isPublic,
      "wordCount": wordCount,
      "content": content,
      "imgs": imgs,
      "labels": labels,
      "messages": messages.map((item)=>item.toJson()).toList(),
    };
  }

  int get year => date.year;
  int get month => date.month;
}
