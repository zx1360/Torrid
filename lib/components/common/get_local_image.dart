import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> getImageFile(String imgUrl) async {
  try {
    final externalDir = await getExternalStorageDirectory();
    if (externalDir == null) {
      throw Exception("无法获取应用外部私有存储目录");
    }
    final pureUrl = imgUrl.startsWith("/")
        ? imgUrl.replaceFirst("/", "")
        : imgUrl;
    final filePath = '${externalDir.path}/$pureUrl';
    print(filePath);
    final file = File(filePath);
    print(file.exists());
    return await file.exists() ? file : null;
  } catch (e) {
    debugPrint('图片路径处理错误: $e');
    return null;
  }
}
