import 'dart:io';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:image_picker/image_picker.dart';

class FilesUtils {
  static Future<File?> takeImage({bool isCamera = true}) async {
    if (isCamera) {}
    final ImagePicker imagePicker = ImagePicker();
    final XFile? photo = await imagePicker.pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (photo == null) {
      return null;
    }
    return File(photo.path);
  }

  static Future<File?> pickPdfFile() async {
    final path = await FlutterDocumentPicker.openDocument(
      params: FlutterDocumentPickerParams(
        allowedFileExtensions: ['pdf'],
        allowedMimeTypes: ['application/pdf'],
      ),
    );

    if (path != null) {
      return File(path);
    }
    return null;
  }
}
