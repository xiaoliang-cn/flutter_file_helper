// if (xFileHelper.getFileBytesSize(bytes) > maxFileSupport) {
//       var cutList = await xFileHelper.cutFile(bytes);
//       List<Uint8List> enBytes = [];
//       for (var byte in cutList) {
//         var enByte = encrypter.encryptBytes(byte, iv: iv);
//         enBytes.add(enByte.bytes);
//       }
//       for (int i = 0; i < enBytes.length; i++) {
//         if (i == 0) {
//           await file.writeAsBytes(enBytes[i]);
//         } else {
//           await file.writeAsBytes(enBytes[i], mode: FileMode.append);
//         }
//       }
//     }
//  if (xFileHelper.getFileBytesSize(bytes) > maxFileSupport) {
//       var cutList = await xFileHelper.cutFile(bytes);
//       List<int> deBytes = [];
//       for (var byte in cutList) {
//         var ed = encrypt.Encrypted(byte);
//         var de = encrypter.decryptBytes(ed);
//         deBytes.addAll(de);
//       }
//       return deBytes;
//     } else {

import 'dart:io';

import 'dart:typed_data';

import 'progress_callback.dart';

class FileMerge {
  Future<File> fromFile(List<Uint8List> listBytes, File wirteFile,
          {ProgressCallback? progressCallback}) async =>
      await _mergeFile(listBytes, wirteFile,
          progressCallback: progressCallback);
  Future<List<int>> fromListInt(List<Uint8List> listBytes) async =>
      await _mergeBytes(listBytes);

  ///
  ///byte data merge to a file
  ///合并成一个新文件 并且返回
  Future<File> _mergeFile(List<Uint8List> listBytes, File wirteFile,
      {ProgressCallback? progressCallback}) async {
    //确保这个文件是干净的
    wirteFile.writeAsStringSync('');
    for (var i = 0; i < listBytes.length; i++) {
      if (progressCallback != null) {
        progressCallback(ProgressInfo(type: ProgressType.recover, progress: i));
      }
      await wirteFile.writeAsBytes(listBytes[i], mode: FileMode.append);
    }

    return wirteFile;
  }

  ///
  ///合并成一个Uint8List 并且返回
  Future<List<int>> _mergeBytes(List<Uint8List> listBytes,
      {ProgressCallback? progressCallback}) async {
    List<int> data = [];
    //确保这个文件是干净的
    for (var i = 0; i < listBytes.length; i++) {
      if (progressCallback != null) {
        progressCallback(ProgressInfo(type: ProgressType.recover, progress: i));
      }
      data.addAll(listBytes[i]);
    }
    return data;
  }
}
