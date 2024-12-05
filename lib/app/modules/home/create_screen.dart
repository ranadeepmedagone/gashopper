import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/core/utils/widgets/custom_textfield.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_dropdown.dart';
import '../../core/utils/widgets/custom_elevation_button.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
        height: 80,
        decoration: BoxDecoration(color: GashopperTheme.appBackGrounColor, boxShadow: [
          BoxShadow(
            color: GashopperTheme.grey1.withOpacity(0.6),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ]),
        child: Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                title: 'Cancel',
                customBackgroundColor: GashopperTheme.appBackGrounColor,
                customBorderSide: const BorderSide(
                  color: GashopperTheme.black,
                  width: 1.5,
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomElevatedButton(
                title: 'Create',
                onPressed: () {},
              ),
            ),
          ],
        ).ltrbPadding(16, 16, 16, 16),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Sale',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: GashopperTheme.black,
                ),
              ).ltrbPadding(0, 0, 0, 8),
              CustomDropdownButton<List<String>>(
                value: const ['Level 01'],
                items: const [
                  DropdownMenuItem(
                    value: ['Level 01'],
                    child: Text(
                      'Empire Trucking',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
                hintText: 'Select',
                onChanged: (value) {
                  // Handle selection change
                  print("Selected Value: $value");
                },
                onSaved: (value) {
                  // Handle value save
                  print("Saved Value: $value");
                },
                borderRadius: BorderRadius.circular(12),
                borderColor: Colors.black,
                borderWidth: 1.5,
                padding: const EdgeInsets.all(8),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                dropdownShadow: BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(0, 4),
                  blurRadius: 16,
                ),
              ).ltrbPadding(0, 0, 0, 16),
              const CustomTextField(hintText: 'Enter amount').ltrbPadding(0, 0, 0, 16),
              const Text(
                'Payment type',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: GashopperTheme.black),
              ).ltrbPadding(0, 0, 0, 8),
              CustomDropdownButton<List<String>>(
                value: const ['Level 01'],
                items: const [
                  DropdownMenuItem(
                    value: ['Level 01'],
                    child: Text(
                      'Empire Trucking',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
                hintText: 'Select',
                onChanged: (value) {
                  // Handle selection change
                  print("Selected Value: $value");
                },
                onSaved: (value) {
                  // Handle value save
                  print("Saved Value: $value");
                },
                borderRadius: BorderRadius.circular(12),
                borderColor: Colors.black,
                borderWidth: 1.5,
                padding: const EdgeInsets.all(8),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                dropdownShadow: BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(0, 4),
                  blurRadius: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
