import 'package:tdd_clean_architecture/core/constants/theme_constants.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/widgets/bottom_nav_bar.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/widgets/blog_card.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    final List<String> specialities = [
      'Cardiologist',
      'Neurologist',
      'Pediatrician',
      'Surgeon',
    ];
    final List<Map<String, dynamic>> doctors = [
      {
        'name': 'Dr. Esther Howard',
        'specialities': specialities,
        'experience': '8 Years of Experience',
        'rating': '4.5',
      },
      {
        'name': 'Dr. Esther Howard',
        'specialities': specialities,
        'experience': '8 Years of Experience',
        'rating': '4.5',
      },
      {
        'name': 'Dr. Esther Howard',
        'specialities': specialities,
        'experience': '8 Years of Experience',
        'rating': '4.5',
      },
      {
        'name': 'Dr. Esther Howard',
        'specialities': specialities,
        'experience': '8 Years of Experience',
        'rating': '4.5',
      },
      {
        'name': 'Dr. Esther Howard',
        'specialities': specialities,
        'experience': '8 Years of Experience',
        'rating': '4.5',
      },
      {
        'name': 'Dr. Esther Howard',
        'specialities': specialities,
        'experience': '8 Years of Experience',
        'rating': '4.5',
      },
    ];

    return Scaffold(
      backgroundColor: ThemeConstants.primaryColorLight,
      bottomNavigationBar: const CustomBottomNavBar(),
      appBar: AppBar(
        backgroundColor: ThemeConstants.primaryColorLight,
        surfaceTintColor: ThemeConstants.primaryColorLight,
        automaticallyImplyLeading: false,
        title: SearchInputField(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: Container(
              width: 50.w,
              height: 48.h,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: ThemeConstants.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: SvgPicture.asset(
                "assets/images/mi_filter.svg",
                semanticsLabel: 'SVG Icon',
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'List of Pediatricians',
                    style: TextStyle(
                      color: ThemeConstants.secondaryColorLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                      letterSpacing: 0.15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  var doctor = doctors[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index < doctors.length - 1 ? 10 : 0),
                    child: BlogCard(
                      name: doctor['name'] ?? 'Unknown Name',
                      specialities: doctor['specialities'] ?? <String>[],
                      yearsOfExperience:
                          doctor['experience'] ?? 'No experience information',
                      rating: doctor['rating'] ?? 'Not rated',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
