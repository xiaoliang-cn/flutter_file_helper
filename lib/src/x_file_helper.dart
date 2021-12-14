import 'dart:typed_data';
import 'file_cut.dart';
import 'file_merge.dart';
import 'file_path.dart';
import 'file_size.dart';
import 'model/xfile_model.dart';

class XFileHelper implements XFileModel {
  XFileHelper._();
  static final XFileHelper _instance = XFileHelper._();
  factory XFileHelper() => _instance;
  final _fileCut = FileCut();
  final _filePath = FilePath();
  final _fileMerge = FileMerge();
  FileCut get fileCut => _fileCut;
  FilePath get filePath => _filePath;
  FileMerge get fileMerge => _fileMerge;

  Future<List<Uint8List>> cutFile(Uint8List fileBytes,
      {int even = 1, int cutNumber = 10, radix = 10}) async {
    return fileCut.cutFile(fileBytes,
        even: even, cutNumber: cutNumber, radix: radix);
  }

  ///
  ///从 Uint8List 计算 返回 mb单元
  double getFileBytesSize(Uint8List bytes) {
    return (bytes.length / 1000000);
  }

  ///
  ///返回文件的小大
  ///getFilesize(1024) 1kb;
  String getFilesize(dynamic size, [int round = 2]) {
    return filesize(size);
  }
}
