import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtil {
  static Future<File?> pickImage({bool camera = true}) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );

    if (image == null) return null;
    return File(image.path);
  }

  static Future<String> saveFileToPermanentStorage(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    final newPath = '${directory.path}/${file.uri.pathSegments.last}';
    final newFile = await file.copy(newPath);
    return newFile.path;
  }
}
