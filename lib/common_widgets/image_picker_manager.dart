import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerManager {
  static XFile? _pickedFileFromGallery;
  static XFile? _pickedFileFromCamera;
  static List<XFile>? _imageFileList;

  // ************************************** Gallery **************************************

  static Future<File?> getImageFromGallery(BuildContext context,
      {bool hasCroppedFunctionality = true}) async {
    final _picker = ImagePicker();

    try {
      _pickedFileFromGallery = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (_pickedFileFromGallery != null) {
        if (hasCroppedFunctionality == false) {
          return File(_pickedFileFromGallery!.path);
        }
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: _pickedFileFromGallery!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
        );
        if (croppedFile != null) {
          return File(croppedFile.path);
        }
        return null;
      }
      return null;
    } on Exception {
      return null;
    }
  }

  // ************************************** Camera **************************************
  static Future<File?> getImageFromCamera(BuildContext context,
      {bool hasCroppedFunctionality = true}) async {
    final _picker = ImagePicker();
    try {
      _pickedFileFromCamera =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (_pickedFileFromCamera != null) {
        if (hasCroppedFunctionality == false) {
          return File(_pickedFileFromCamera!.path);
        }
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: _pickedFileFromCamera!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
        );
        if (croppedFile != null) {
          return File(croppedFile.path);
        }
        return null;
      }
      return null;
    } on Exception {
      return null;
    }
  }

  // ************************************** Multi Gallery **************************************

  static Future<List<XFile>?> getMultiImageFromGallery(
      BuildContext context) async {
    // using pop to hide the image choose options menu

    final _picker = ImagePicker();

    try {
      _imageFileList = await _picker.pickMultiImage();
      if (_imageFileList != null) {
        return _imageFileList;
      }
      return null;
    } on Exception {
      return null;
    }
  }
}
