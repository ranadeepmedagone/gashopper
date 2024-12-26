import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gashopper/app/core/utils/helpers.dart';

import '../../values/constants.dart';

class ProfileImage extends StatelessWidget {
  final double size;
  final bool applyShadow;
  final String? imagePath;

  const ProfileImage({
    super.key,
    this.size = 100.0,
    this.imagePath,
    this.applyShadow = true,
  });

  bool get hasPic {
    return imagePath != null && imagePath!.trim() != '';
  }

  @override
  Widget build(BuildContext context) {
    final Widget imageDummy = Container(
      clipBehavior: Clip.antiAlias,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
      ),
      child: SvgPicture.asset(
        Constants.userAvatar,
        height: size,
        width: size,
        colorFilter: ColorFilter.mode(
          Colors.grey[300]!,
          BlendMode.srcIn,
        ),
      ),
    );

    // Profile Picture
    return Container(
      // Outer Grey Circle
      width: size + 8.0,
      height: size + 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueGrey[50],
      ),
      child: Container(
        // Inner Circle with Picture
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          boxShadow: [
            if (applyShadow)
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 4),
                color: Colors.grey[700]!.withAlphaOpacity(0.24),
              ),
          ],
        ),
        child: hasPic
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imagePath!,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                  placeholder: (context, url) => imageDummy,
                  errorWidget: (context, url, error) => imageDummy,
                ),
              )
            : imageDummy,
      ),
    );
  }
}
