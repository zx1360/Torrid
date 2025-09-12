import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:torrid/services/booklet_hive_service.dart';
import 'package:torrid/services/essay_hive_service.dart';
import 'package:torrid/services/http_service.dart';

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

  static Future getPcIp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("PC_IP");
  }

  // # 同步数据, 从pc请求数据覆盖本地.
  static Future<void> syncDatas() async {
    await syncBooklet();
    await syncEssay();
    await syncViewhub();
  }

  // 同步booklet打卡
  static Future<void> syncBooklet() async {
    try {
      final pcIp = await getPcIp();
      final response = await get(Uri.parse("http://$pcIp:4215/sync/booklet"));
      await BookletHiveService.syncData(jsonDecode(response.body));
    } catch (err) {
      // print(response);
      throw Exception("同步booklet数据出错.\n $err");
    }
  }

  // 同步essay随笔
  static Future<void> syncEssay() async {
    try {
      final pcIp = await getPcIp();
      final response = await get(Uri.parse("http://$pcIp:4215/sync/essay"));
      await EssayHiveService.syncData(jsonDecode(response.body));
    } catch (err) {
      throw Exception("同步essay数据出错.$err\n");
    }
  }

  // 同步viewhub媒体阅读器
  static Future<void> syncViewhub() async {}

  // # 更新数据, 本地数据上传到PC.
  static Future<void> updateDatas() async {
    await updateBooklet();
    await updateEssay();
    await updateViewhub();
  }

  // 同步booklet打卡
  static Future<void> updateBooklet() async {
    try {
      final packedData = BookletHiveService.packUp();
      final pcIp = await getPcIp();
      await post(
        Uri.parse("http://$pcIp:4215/update/booklet"),
        headers: {"Content-Type": "application/json"},
        body: packedData,
      );
      List<String> urls = BookletHiveService.getImgsPath();
      ImageUploader.uploadImages(
        urls,
        "http://$pcIp:4215/update/booklet_imgs",
      ).catchError((error) {
        print("上传出错.");
      });
    } catch (err) {
      throw Exception("同步booklet数据出错.\n$err");
    }
  }

  // 更新essay随笔
  static Future<void> updateEssay() async {
    try {
      final packedData = EssayHiveService.packUp();
      final pcIp = await getPcIp();
      await post(
        Uri.parse("http://$pcIp:4215/update/essay"),
        headers: {"Content-Type": "application/json"},
        body: packedData,
      );
      List<String> urls = EssayHiveService.getImgsPath();
      ImageUploader.uploadImages(
        urls,
        "http://$pcIp:4215/update/essay_imgs",
      ).catchError((error) {
        print("上传出错.");
      });
    } catch (err) {
      throw Exception("同步booklet数据出错.\n$err");
    }
  }

  // 更新viewhub媒体阅读器
  static Future<void> updateViewhub() async {}
}
