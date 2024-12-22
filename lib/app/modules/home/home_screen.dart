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
    return GetBuilder<HomeController>(
        initState: (state) {},
        builder: (c) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: GashopperTheme.appBackGrounColor,
            appBar: CustomAppBar(
              isTitleCentered: true,
              title: 'Business Unit',
              customLeadingWidget: c.isAppInputsLoading
                  ? null
                  : IconButton(
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
                    height: 80,
                    decoration:
                        BoxDecoration(color: GashopperTheme.appBackGrounColor, boxShadow: [
                      BoxShadow(
                        color: GashopperTheme.grey1.withOpacity(0.6),
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
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: 'Request',
                                  customBackgroundColor: GashopperTheme.appBackGrounColor,
                                  customBorderSide: Border.all(
                                    color: GashopperTheme.black,
                                    width: 1.5,
                                  ),
                                  onPressed: c.onPressRequest,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomButton(
                                  title: 'Report',
                                  customBackgroundColor: GashopperTheme.appBackGrounColor,
                                  customBorderSide: Border.all(
                                    color: GashopperTheme.black,
                                    width: 1.5,
                                  ),
                                  onPressed: c.onPressReport,
                                ),
                              ),
                            ],
                          ).ltrbPadding(0, 0, 0, 16),
                          Divider(
                            color: GashopperTheme.grey1.withOpacity(0.3),
                            thickness: 1,
                          ).ltrbPadding(0, 0, 0, 16),
                          CustomButton(
                            title: 'Veeder root',
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
                            title: 'Ruby report',
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
                  color: isToday ? GashopperTheme.grey1.withOpacity(0.4) : GashopperTheme.black,
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
