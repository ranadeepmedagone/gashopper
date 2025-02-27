import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_button.dart';
import '../../core/utils/widgets/custom_loader.dart';
import 'photo_upload_controller.dart';

class PhotoUploadScreen extends StatelessWidget {
  PhotoUploadScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final photoUploadController = Get.find<PhotoUploadController>();

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    return GetBuilder<PhotoUploadController>(builder: (controller) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: GashopperTheme.appBackGrounColor,
        appBar: const CustomAppBar(
          title: 'Business Unit',
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: GashopperTheme.appBackGrounColor,
            boxShadow: [
              BoxShadow(
                color: GashopperTheme.grey1.withAlphaOpacity(0.6),
                offset: const Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: controller.fileUploading
              ? const Center(child: CustomLoader())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.selectedImageFile != null
                      ? CustomButton(
                          title: 'Upload Photo',
                          onPressed: () {
                            controller.uploadImage();
                          },
                        ).ltrbPadding(0, 0, 0, 16)
                      : Row(
                          children: [
                            CustomButton(
                              title: 'Go Back',
                              onPressed: () {
                                Get.back();
                              },
                              customBackgroundColor: GashopperTheme.appBackGrounColor,
                            ).ltrbPadding(0, 0, 0, 16),
                            if (controller.selectedImageFile == null)
                              Expanded(
                                child: CustomButton(
                                  title: 'Take Photo',
                                  onPressed: () {
                                    controller.isAttachmentUpload
                                        ? null
                                        : controller.onCaptureImage();
                                  },
                                  leftIcon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: GashopperTheme.black,
                                    size: 26,
                                  ).ltrbPadding(8, 0, 24, 0),
                                  rightIcon: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: GashopperTheme.black,
                                    size: 18,
                                  ),
                                  isLeftIcon: true,
                                  isRightIconEnd: true,
                                ).ltrbPadding(0, 0, 0, 16),
                              ),
                          ],
                        ),
                ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.selectedImageFile == null
                  ? [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                              width: mQ.size.width / 2.5,
                              height: mQ.size.height / 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                color: GashopperTheme.grey2,
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.cancel_sharp,
                                  color: GashopperTheme.red,
                                  size: 80,
                                ),
                              ),
                            ),
                            imageUrl: 'https://picsum.photos/id/10/200/300',
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            width: mQ.size.width / 2.5,
                            height: mQ.size.height / 3,
                            placeholder: (context, url) => Container(
                              width: mQ.size.width / 2.5,
                              height: mQ.size.height / 3,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://picsum.photos/id/10/200/300'),
                                  fit: BoxFit.cover,
                                ),
                                color: GashopperTheme.grey2,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.cancel_sharp,
                                  color: GashopperTheme.red,
                                  size: 80,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.cancel_sharp,
                              color: GashopperTheme.red,
                              size: 80,
                            ),
                          ),
                          CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                              width: mQ.size.width / 2.5,
                              height: mQ.size.height / 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                color: GashopperTheme.grey2,
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.check_circle_sharp,
                                  color: Colors.green,
                                  size: 80,
                                ),
                              ),
                            ),
                            imageUrl: 'https://picsum.photos/id/10/200/300',
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            width: mQ.size.width / 2.5,
                            height: mQ.size.height / 3,
                            placeholder: (context, url) => Container(
                              width: mQ.size.width / 2.5,
                              height: mQ.size.height / 3,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://picsum.photos/id/10/200/300'),
                                  fit: BoxFit.cover,
                                ),
                                color: GashopperTheme.grey2,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.check_circle_sharp,
                                  color: Colors.green,
                                  size: 80,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.check_circle_sharp,
                              color: Colors.green,
                              size: 80,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Instructions',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: GashopperTheme.black),
                      ).ltrbPadding(0, 0, 0, 16),
                      const Text(
                        '1. Take a picture of the item you want to upload',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: GashopperTheme.black),
                      ).ltrbPadding(0, 0, 0, 16),
                      const Text(
                        '2. Upload the picture',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: GashopperTheme.black),
                      ).ltrbPadding(0, 0, 0, 16),
                    ]
                  : [
                      ImageChip(
                        imageFile: controller.selectedImageFile!,
                        onDelete: () => controller.deleteImage(),
                      ),
                    ],
            ),
          ),
        ),
      );
    });
  }
}

class ImageChip extends StatelessWidget {
  final File imageFile;
  final Function()? onDelete;

  const ImageChip({
    super.key,
    required this.imageFile,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = path.basename(imageFile.path);

    final mQ = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(8), right: Radius.circular(8)),
                child: SizedBox(
                  height: mQ.height / 1.4,
                  width: mQ.width / 1.1,
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 28),
                onPressed: onDelete,
                color: GashopperTheme.black,
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
              ).ltrbPadding(0, 8, 12, 0),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              fileName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
