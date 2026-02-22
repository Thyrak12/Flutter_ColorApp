import 'package:flutter/material.dart';
 
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  IconData getIcon() {
    switch (controller.status){
      case DownloadStatus.downloaded :
        return Icons.folder;
      case DownloadStatus.downloading :
        return Icons.downloading;
      case DownloadStatus.notDownloaded :
        return Icons.download;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => controller.startDownload(),
          child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // File name
                    Text(
                      controller.ressource.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Progress text
                    Text(
                      "${(controller.progress * 100).toStringAsFixed(2)}% completed - "
                      "${(controller.percentOfSize.toStringAsFixed(2))} of ${controller.ressource.size} MB",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              Icon(
                getIcon(),
                size: 32,
                color: Colors.grey.shade700,
              ),
            ],
          ),
        ),
        );
      },
    );
  }
}
