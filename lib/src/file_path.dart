import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FilePath {
  ///
  ///返回一个String结构的路径
  ///路径目录还未创建完成
  /// etApplicationDocumentsDirectory 
  Future<String> getPath(String dirPath) async {
    var dir = await getApplicationDocumentsDirectory();
    var saveDir = dir.path + dirPath;
    return saveDir;
  }

  ///
  ///返回一个已经创建好的目录使用
  /// ApplicationDocumentsDirectory 
  Future<Directory> getFilesDirectory(String dirName) async {
    var dir = await getApplicationDocumentsDirectory();
    var saveDir = dir.path + dirName;
    var newDir = Directory(saveDir);
    var b = await newDir.exists();
    if (!b) {
      await newDir.create(recursive: true);
    }
    return newDir;
  }

  ///
  ///返回一个已经创建好的目录使用
  /// etApplicationDocumentsDirectory 
  Future<Directory> getCacheDirectory(String dirName) async {
    var dir = await getTemporaryDirectory();
    var saveDir = dir.path + dirName;
    var newDir = Directory(saveDir);
    var b = await newDir.exists();
    if (!b) {
      newDir.create(recursive: true);
    }
    return newDir;
  }

  /// 返回文件的名字
  /// 'user/data/aaa.png' return [aaa.png]
  // String getBaseName(String filePath) {
  //   return basename(filePath);
  // }
}
