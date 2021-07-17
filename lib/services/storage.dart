import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageService extends GetxService {
  Future<bool> askPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  // https://stackoverflow.com/a/55614133
  Future<bool> downloadImage({String url}) async {
    if (await askPermission()) {
      try {
        final List<StorageInfo> dirs = await PathProviderEx.getStorageInfo();
        final File file = await DefaultCacheManager().getSingleFile(url);

        Directory finalDir =
            await new Directory('${dirs[0].rootDir}/Pictures/Binoculars')
                .create(recursive: true);

        await moveFile(file, finalDir.path, fileName: url.split("/").last);
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<File> moveFile(
    File sourceFile,
    String newPath, {
    String fileName,
  }) async {
    final String name = fileName ?? basename(sourceFile.path);

    final newFile = await sourceFile.copy(
      '$newPath/$name',
    );
    return newFile;
  }
}
