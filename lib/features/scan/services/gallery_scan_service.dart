import 'dart:io';

import 'package:image_picker/image_picker.dart';

class GalleryScanService {
  GalleryScanService._();

  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (image == null) {
      return null;
    }

    return File(image.path);
  }
}
