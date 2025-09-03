import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:torrid/services/booklet_hive_service.dart';

class HiveService {
  static Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    // 获取应用外部私有存储目录（Android的getExternalFilesDir，iOS的Documents）
    final directory = await getExternalStorageDirectory();
    if (directory == null) return;
    final bookletImgDir = path.join(directory.path, "img_storage/booklet");
    final essayImgDir = path.join(directory.path, "img_storage/essay");

    // 确保目录存在
    await Directory(bookletImgDir).create(recursive: true);
    await Directory(essayImgDir).create(recursive: true);
  }



  // # 同步数据, 从pc请求数据覆盖本地.
  // 同步booklet数据
  static Future<void> syncBooklet() async {
    try {
      final response = await get(
        Uri.parse("http://192.168.5.114:4215/sync/booklet"),
      );
      await BookletHiveService.syncData(jsonDecode(response.body));
    } catch (err) {
      // print(response);
      throw Exception("同步booklet数据出错.\n $err");
    }
  }

  // 同步essay数据
  static Future<void> syncEssay() async {
    try {
      final response = await get(
        Uri.parse("http://192.168.5.114:4215/sync/essay"),
      );
      // await EssayHiveService....
      print(response.body);
    } catch (err) {
      throw Exception("同步essay数据出错.");
    }
  }



  // # 更新数据, 本地数据上传到PC.
  static Future<void> updateBooklet() async {
    try {
      final packedData = BookletHiveService.packUp();
      final response = await post(
        Uri.parse("http://192.168.5.114:4215/update/booklet"),
        headers: {"Content-Type": "application/json"},
        body: packedData,
      );
      await BookletHiveService.uploadImgs();
    } catch (err) {
      throw Exception("同步booklet数据出错.\n");
    }
  }

  // 更新essay数据
  static Future<void> updateEssay()async{}

  
}
