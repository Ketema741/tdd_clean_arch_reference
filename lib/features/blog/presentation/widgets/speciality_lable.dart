import 'package:tdd_clean_architecture/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialityLable extends StatelessWidget {
  const SpecialityLable({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 105.w,
          height: 24.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: ShapeDecoration(
            color: ThemeConstants.primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: ThemeConstants.secondaryColorLight,
                  fontSize: 11,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0.13,
                  letterSpacing: 0.50,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
