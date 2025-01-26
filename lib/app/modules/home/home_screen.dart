import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_button.dart';
import '../../core/utils/widgets/custom_loader.dart';
import '../../core/utils/widgets/custom_navbar.dart';
import '../../routes/app_pages.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    return GetBuilder<HomeController>(
        initState: (state) {},
        builder: (c) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: GashopperTheme.appBackGrounColor,
            appBar: CustomAppBar(
              showBackButton: false,
              title: 'Business Unit',
              customLeadingWidget: IconButton(
                color: GashopperTheme.black,
                tooltip: 'Menu',
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  size: 28,
                ),
              ).ltrbPadding(8, 0, 0, 0),
            ),
            bottomNavigationBar: c.isAppInputsLoading
                ? null
                : Container(
                    margin: MediaQuery.of(context).padding.bottom > 12.0
                        ? EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom - 12.0,
                          )
                        : null,
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration:
                        BoxDecoration(color: GashopperTheme.appBackGrounColor, boxShadow: [
                      BoxShadow(
                        color: GashopperTheme.grey1.withAlphaOpacity(0.6),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ]),
                    child: CustomButton(
                      title: 'Close Day',
                      customTextColor: GashopperTheme.appBackGrounColor,
                      customBackgroundColor: GashopperTheme.black,
                      onPressed: () {},
                    ).ltrbPadding(8, 8, 8, 8),
                  ),
            drawer: c.isAppInputsLoading
                ? null
                : NavDrawer(
                    onLogout: c.authService.logout,
                    loginUserEmail: c.registrationController.emailTextEditingController.text,
                  ),
            body: c.isAppInputsLoading
                ? const Center(child: CustomLoader())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Column(
                        children: [
                          const DateNavigator().ltrbPadding(0, 0, 0, 16),
                          CustomButton(
                            title: 'Sales',
                            customBackgroundColor: GashopperTheme.appBackGrounColor,
                            customBorderSide: Border.all(
                              color: GashopperTheme.black,
                              width: 1.5,
                            ),
                            onPressed: c.onPressSales,
                          ).ltrbPadding(0, 0, 0, 16),
                          CustomButton(
                            title: 'Expenses',
                            customBackgroundColor: GashopperTheme.appBackGrounColor,
                            customBorderSide: Border.all(
                              color: GashopperTheme.black,
                              width: 1.5,
                            ),
                            onPressed: c.onPressExpenses,
                          ).ltrbPadding(0, 0, 0, 16),
                          CustomButton(
                            title: 'Cash drop',
                            customBackgroundColor: GashopperTheme.appBackGrounColor,
                            customBorderSide: Border.all(
                              color: GashopperTheme.black,
                              width: 1.5,
                            ),
                            onPressed: c.onPressCashDrop,
                          ).ltrbPadding(0, 0, 0, 16),
                          CustomButton(
                            title: 'Maintenance',
                            customBackgroundColor: GashopperTheme.appBackGrounColor,
                            customBorderSide: Border.all(
                              color: GashopperTheme.black,
                              width: 1.5,
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.maintenanceMainScreen);
                            },
                            leftIcon: const Icon(
                              Icons.local_gas_station,
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
                          Divider(
                            color: GashopperTheme.grey1.withAlphaOpacity(0.3),
                            thickness: 1,
                          ).ltrbPadding(0, 0, 0, 16),
                          CustomButton(
                            title: 'Veeder root Open',
                            onPressed: () {
                              Get.toNamed(Routes.photoUploadScreen);
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
                          CustomButton(
                            title: 'End of Day Reports',
                            onPressed: () {
                              showModalBottomSheet(
                                showDragHandle: true,
                                context: context,
                                enableDrag: true,
                                isDismissible: true,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return PopScope(
                                    canPop: false,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                        left: 16,
                                        right: 16,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomButton(
                                            title: 'Ruby Tank report',
                                            onPressed: () {
                                              Get.toNamed(Routes.photoUploadScreen);
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
                                          CustomButton(
                                            title: 'Ruby Card report',
                                            onPressed: () {
                                              Get.toNamed(Routes.photoUploadScreen);
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
                                          CustomButton(
                                            title: 'Ruby Mobile report',
                                            onPressed: () {
                                              Get.toNamed(Routes.photoUploadScreen);
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
                                          CustomButton(
                                            title: 'Ruby Discount',
                                            onPressed: () {
                                              Get.toNamed(Routes.photoUploadScreen);
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
                                          CustomButton(
                                            title: 'Veeder root Close',
                                            onPressed: () {
                                              Get.toNamed(Routes.photoUploadScreen);
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
                                          ).ltrbPadding(0, 0, 0, 40),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
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
                          CustomButton(
                            title: 'Rate board',
                            onPressed: () {
                              Get.toNamed(Routes.photoUploadScreen);
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
                          CustomButton(
                            title: 'Change Price',
                            onPressed: () {
                              showModalBottomSheet(
                                showDragHandle: true,
                                context: context,
                                enableDrag: true,
                                isDismissible: true,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return PopScope(
                                    canPop: false,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom,
                                        left: 16,
                                        right: 16,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'New price',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.5,
                                              color: Colors.black,
                                            ),
                                          ).ltrbPadding(0, 0, 0, 16),
                                          CachedNetworkImage(
                                            imageBuilder: (context, imageProvider) => Container(
                                              width: mQ.size.width,
                                              height: mQ.size.height / 3,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                color: GashopperTheme.grey2,
                                                borderRadius:
                                                    const BorderRadius.all(Radius.circular(12)),
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
                                            width: mQ.size.width,
                                            height: mQ.size.height / 3,
                                            placeholder: (context, url) => Container(
                                              width: mQ.size.width / 2.5,
                                              height: mQ.size.height / 3,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://picsum.photos/id/10/200/300'),
                                                  fit: BoxFit.cover,
                                                ),
                                                color: GashopperTheme.grey2,
                                                borderRadius:
                                                    BorderRadius.all(Radius.circular(12)),
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
                                          ).ltrbPadding(0, 0, 0, 16),
                                          CustomButton(
                                            title: 'Accept',
                                            onPressed: () {},
                                          ).ltrbPadding(0, 0, 0, 16),
                                          Row(
                                            children: [
                                              CustomButton(
                                                title: 'Back',
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                customBackgroundColor:
                                                    GashopperTheme.appBackGrounColor,
                                              ).ltrbPadding(0, 0, 0, 16),
                                              Expanded(
                                                child: CustomButton(
                                                  title: 'Submit Photo',
                                                  onPressed: () {
                                                    Get.toNamed(
                                                      Routes.photoUploadScreen,
                                                    );
                                                  },
                                                ).ltrbPadding(0, 0, 0, 16),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
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
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}

class DateNavigator extends StatefulWidget {
  const DateNavigator({super.key});

  @override
  State<DateNavigator> createState() => _DateNavigatorState();
}

class _DateNavigatorState extends State<DateNavigator> {
  DateTime _selectedDate = DateTime.now();

  bool isToday = false;

  void _goToPreviousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
      isToday = false;
    });
  }

  void _goToNextDay() {
    setState(() {
      final DateTime today = DateTime.now();
      final DateTime todayWithoutTime = DateTime(today.year, today.month, today.day);
      final DateTime selectedDateWithoutTime =
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);

      isToday = selectedDateWithoutTime.isAtSameMomentAs(todayWithoutTime);

      if (isToday) {
        return;
      }

      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Navigator',
          style: GashopperTheme.fontWeightApplier(
            FontWeight.w700,
            textTheme.bodyMedium!.copyWith(
              color: GashopperTheme.black,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(color: GashopperTheme.black, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_left_outlined,
                  size: 28,
                  color: GashopperTheme.black,
                ),
                onPressed: () {
                  _goToPreviousDay();
                },
              ),
              const Icon(
                Icons.calendar_month_outlined,
                color: GashopperTheme.black,
              ),
              Text(
                DateFormat('MM-dd-yyyy').format(_selectedDate),
                style: GashopperTheme.fontWeightApplier(
                  FontWeight.w700,
                  textTheme.bodyMedium!.copyWith(
                    color: GashopperTheme.black,
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28,
                  color: isToday
                      ? GashopperTheme.grey1.withAlphaOpacity(0.4)
                      : GashopperTheme.black,
                ),
                onPressed: () {
                  if (!isToday) _goToNextDay();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
