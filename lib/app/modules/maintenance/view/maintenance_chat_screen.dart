import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/core/utils/widgets/custom_appbar.dart';
import 'package:gashopper/app/core/utils/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../controller/maintenance_controller.dart';

class MaintenanceChatScreen extends StatelessWidget {
  const MaintenanceChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;

    return GetBuilder<MaintenanceController>(builder: (controller) {
      return Scaffold(
        appBar: const CustomAppBar(
          title: 'Business Unit',
          isTitleCentered: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final messageData = controller.messages[index];

                    bool isSender = messageData.containsKey("sender");
                    String senderName =
                        isSender ? messageData["sender"] : messageData["receiver"];
                    String message = messageData["message"];
                    String timestamp = controller.formatTime(messageData["timestamp"]);

                    return Align(
                      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment:
                            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!isSender)
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: GashopperTheme.appYellow,
                              child: Text(
                                senderName[0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSender ? GashopperTheme.grey2 : GashopperTheme.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (messageData.containsKey("image"))
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(messageData["image"]),
                                        height: 200,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  if (messageData.containsKey("image"))
                                    const SizedBox(height: 8),
                                  Text(
                                    message,
                                    style: TextStyle(
                                      color: isSender
                                          ? GashopperTheme.black
                                          : GashopperTheme.grey2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    timestamp,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (isSender)
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: GashopperTheme.appYellow,
                              child: Text(
                                senderName[0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ).ltrbPadding(0, 0, 0, 12),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.selectedImage != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              controller.selectedImage!,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 4,
                            top: 4,
                            child: GestureDetector(
                              onTap: controller.removeImage,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: GashopperTheme.black,
                        ),
                        onPressed: controller.takePhoto,
                      ),
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Send a message',
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            textTheme.bodyMedium!.copyWith(
                              color: GashopperTheme.grey1,
                              fontSize: 14,
                            ),
                          ),
                          borderRadius: 12,
                          borderColor: Colors.grey,
                          focusedBorderColor: GashopperTheme.appYellow,
                          borderWidth: 1.5,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          controller: controller.messageController,
                          keyboardType: TextInputType.text, // Changed from number to text
                          onChanged: (value) {},
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: GashopperTheme.black),
                        onPressed: () {
                          if (controller.messageController.text.isNotEmpty ||
                              controller.selectedImage != null) {
                            controller.sendMessage(controller.messageController.text);
                            controller.messageController.clear();
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
