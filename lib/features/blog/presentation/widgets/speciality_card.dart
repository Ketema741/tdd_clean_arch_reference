import 'package:tdd_clean_architecture/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SpecialityCard extends StatelessWidget {
  const SpecialityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 153.w,
          height: 158.h,
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: ThemeConstants.primaryColorLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 45.w,
                      height: 45.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Row(children: [
                        SvgPicture.asset(
                          "assets/images/child_care.svg",
                          semanticsLabel: 'SVG Icon',
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22.h),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Pediatry',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeConstants.secondaryColorLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 0.10,
                        letterSpacing: 0.10,
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      '25 Doctors',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeConstants.secondaryColorLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 0.11,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
