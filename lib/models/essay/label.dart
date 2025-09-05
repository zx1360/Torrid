import 'package:hive/hive.dart';
import 'package:torrid/util/util.dart';

part 'label.g.dart';

@HiveType(typeId: 2)
class Label {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int essayCount;

  Label({required this.id, required this.name, required this.essayCount});

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      id: Util.generateId(),
      name: json['name'],
      essayCount: json['essayCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "essayCount": essayCount};
  }
}
