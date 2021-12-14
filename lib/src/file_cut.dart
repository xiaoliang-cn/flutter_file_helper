import 'dart:typed_data';

import 'progress_callback.dart';

class FileCut {
  ///
  ///切割一个文件,默认切割10份，如果觉得文件不需要切割那么大
  ///even = 2 && cutNumber=5 就会切割5份
  ///even 越大 切割份数约小
  ///radix 这个最好不要随便乱改
  ///even and cutNumber and radix 有很大的关联，修改需要多加测试
  Future<List<Uint8List>> cutFile(Uint8List fileBytes,
      {int even = 1,
      int cutNumber = 10,
      radix = 10,
      ProgressCallback? progressCallback}) async {
    var operatrList = fileBytes.toList();
    //获取最初的文件大小
    var residue = operatrList.length % 10;
    if (residue != 0) {
      for (int i = 0; i < 10 - residue; i++) {
        operatrList.add(0);
      }
    }
    var fileNeedCutLength = operatrList.length * (even / radix);
    int len = 0;
    int alreadyLength = fileNeedCutLength.toInt();
    List<List<int>> lists = [];
    for (int i = 1; i <= cutNumber; i++) {
      // print("cuting.......");
      if (progressCallback != null) {
        progressCallback(ProgressInfo(type: ProgressType.cut, progress: i));
      }
      var list = operatrList.getRange(len, alreadyLength * i).toList();
      len = alreadyLength * i;
      lists.add(list);
    }

    ///
    ///after cut redundant unit8 data remove
    var lastList = lists.last;
    if (residue != 0) {
      // print("recover......");
      for (int i = 0; i < 10 - residue; i++) {
        lastList.removeLast();
      }
    }
    List<Uint8List> bytes = [];

    for (int i = 0; i < lists.length; i++) {
      if (progressCallback != null) {
        progressCallback(ProgressInfo(type: ProgressType.recover, progress: i));
      }
      bytes.add(Uint8List.fromList(lists[i]));
      lists[i].clear();
    }

    return bytes;
  }
}
