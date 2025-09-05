// 追加留言的数据类, 对于以前的日记/大任务的中途留言. 似乎也只需要时间和内容两项.
import 'package:hive/hive.dart';
import 'package:torrid/util/util.dart';

@HiveType(typeId: 9)
class Message {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final String content;

  Message({required this.id, required this.timestamp, required this.content});

  Message.noId({required this.timestamp, required this.content})
    : id = Util.generateId();

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: Util.generateId(),
      timestamp: json['time'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "timestamp": timestamp.toLocal().toString().split('.').first,
      "content": content,
    };
  }
}
