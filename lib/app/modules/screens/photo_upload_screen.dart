import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_elevation_button.dart';

class PhotoUploadScreen extends StatelessWidget {
  PhotoUploadScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: GashopperTheme.appBackGrounColor,
      appBar: const CustomAppBar(
        isTitleCentered: true,
        title: 'Business Unit',
      ),
      bottomNavigationBar: Container(
        margin: MediaQuery.of(context).padding.bottom > 12.0
            ? EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom - 12.0,
              )
            : null,
        height: mQ.size.height / 6,
        decoration: BoxDecoration(color: GashopperTheme.appBackGrounColor, boxShadow: [
          BoxShadow(
            color: GashopperTheme.grey1.withOpacity(0.6),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomElevatedButton(
                title: 'Take Photo',
                onPressed: () {},
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
              CustomElevatedButton(
                title: 'Go Back',
                onPressed: () {
                  Get.back();
                },
                customBackgroundColor: GashopperTheme.appBackGrounColor,
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
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
