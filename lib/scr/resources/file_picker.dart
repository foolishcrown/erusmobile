import 'dart:io';
import 'package:file_picker/file_picker.dart';

Future<File> pickFileChooser() async {
  File result = await FilePicker.getFile(
    type: FileType.CUSTOM,
    fileExtension: 'pdf',
  );

  if (result != null) {
    File file = result;
    return file;
  } else {
    // User canceled the picker
    return null;
  }
}
