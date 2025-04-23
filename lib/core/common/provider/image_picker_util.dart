import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../config/navigation/navigation_service.dart';

class ImagePickerUtil {
  static Future<File?> pickImage({
    required BuildContext context,
    required ImageSource source,
  }) async {
    // if (source == ImageSource.camera) {
    //   final status = await Permission.camera.request();
    //   if (status.isDenied || status.isPermanentlyDenied) {
    //     return null;
    //   }
    // } else {
    //   final status = await Permission.photos.request();
    //   if (status.isDenied || status.isPermanentlyDenied) {
    //     return null;
    //   }
    // }

    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      // Handle error
      return null;
    }
  }

  static void showImagePickerOptions({
    required BuildContext context,
    required WidgetRef ref,
    required Function(File?) onImagePicked,
    bool crop = false,
  }) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).inputDecorationTheme.fillColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () async {
                final image = await pickImage(
                    context: context, source: ImageSource.camera,);
                onImagePicked(image);
                ref.read(navigationServiceProvider).goBack();
              },
              style: ButtonStyle(
                foregroundColor:
                    WidgetStateProperty.all(Theme.of(context).primaryColor),
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).primaryColor.withOpacity(0.2)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.camera, size: 20,),
                  SizedBox(width: 12),
                  Text(
                    'Camera',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () async {
                final image = await pickImage(
                    context: context, source: ImageSource.gallery);
                onImagePicked(image);
                ref.read(navigationServiceProvider).goBack();
              },
              style: ButtonStyle(
                foregroundColor:
                    WidgetStateProperty.all(Theme.of(context).primaryColor),
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).primaryColor.withOpacity(0.2)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.gallery, size: 20,),
                  SizedBox(width: 12),
                  Text(
                    'Gallery',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
