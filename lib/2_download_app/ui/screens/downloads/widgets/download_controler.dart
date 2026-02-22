import 'package:flutter/material.dart';

class Ressource {
  final String name;
  final int size;   // in MB

  Ressource({required this.name, required this.size}); 
}

enum DownloadStatus { notDownloaded, downloading, downloaded }

class DownloadController extends ChangeNotifier {
  
  DownloadController(this.ressource);

  // DATA
  Ressource ressource;
  DownloadStatus _status = DownloadStatus.notDownloaded;
  double _progress = 0.0;         // 0.0 → 1.0

  // GETTERS
  DownloadStatus get status => _status;
  double get progress => _progress;
  double get percentOfSize => _progress * ressource.size;

  // ACTIONS
  void startDownload() async {
    if (_status == DownloadStatus.downloading || _status == DownloadStatus.downloaded) return;

    // 1 – set status to downloading
    _status = DownloadStatus.downloading;
    notifyListeners();

    // 2 – Loop 10 times and increment the download progress (0 -> 0.1 -> 0.2 )
    for (int i = 0; i < 10; i++) {
      _progress += 0.1;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1000));
    }

    // 3 – set status to downloaded
    _status = DownloadStatus.downloaded;
    notifyListeners();
  }
}


