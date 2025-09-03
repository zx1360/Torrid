import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class IoService {
  // 删除目录下的所有内容但保留目录本身
  static Future<void> deleteDirectoryContents(Directory dir)async{
    if (!await dir.exists()) return;

    // 遍历目录中的所有内容
    await for (final entity in dir.list()) {
      if (entity is File) {
        // 删除文件
        await entity.delete();
        print("已删除文件: ${entity.path}");
      } else if (entity is Directory) {
        // 递归删除子目录
        await entity.delete(recursive: true);
        print("已删除目录: ${entity.path}");
      }
    }
  }

  // 清除外部私有空间中的指定目录
  static Future<void> clearSpecificDirectory(String relativePath) async {
    try {
      // 获取应用外部私有存储根目录
      final externalDir = await getExternalStorageDirectory();
      if (externalDir == null) {
        throw Exception("无法获取应用外部私有存储目录");
      }

      // 构建目标目录的完整路径
      final targetDir = Directory(path.join(externalDir.path, relativePath));

      // 检查目录是否存在
      if (await targetDir.exists()) {
        // 递归删除该目录及其所有内容
        await targetDir.delete(recursive: true);
        print("已清除指定目录: ${targetDir.path}");
      } else {
        print("指定目录不存在: ${targetDir.path}");
      }
    } catch (e) {
      throw Exception("清除指定目录失败: $e");
    }
  }

  static Future<File?> getImageFile(String imgUrl) async {
  try {
    final externalDir = await getExternalStorageDirectory();
    if (externalDir == null) {
      throw Exception("无法获取应用外部私有存储目录");
    }
    final pureUrl = imgUrl.startsWith("/")
        ? imgUrl.replaceFirst("/", "")
        : imgUrl;
    final filePath = '${externalDir.path}/$pureUrl';
    // print(filePath);
    final file = File(filePath);
    // print(file.exists());
    return await file.exists() ? file : null;
  } catch (e) {
    debugPrint('图片路径处理错误: $e');
    return null;
  }
}
}