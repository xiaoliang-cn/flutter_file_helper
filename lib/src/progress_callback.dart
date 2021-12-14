typedef ProgressCallback = Function(ProgressInfo progress);


///
///callback cut and merge progress info
class ProgressInfo {
  final ProgressType type;
  final int progress;

  ProgressInfo({required this.type, required this.progress});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"progress": progress, "type": type};
  }
}

enum ProgressType { cut, mrege, recover }
