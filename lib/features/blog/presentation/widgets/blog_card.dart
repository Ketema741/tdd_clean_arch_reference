import 'package:tdd_clean_architecture/core/constants/theme_constants.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/widgets/speciality_lable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.specialities,
    required this.name,
    required this.rating,
    required this.yearsOfExperience,
  });
  final List<String> specialities;
  final String name;
  final String rating;
  final String yearsOfExperience;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 320.w,
          height: 250.h,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://via.placeholder.com/52x52"),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 220.w,
                            child: Text(
                              name,
                              style: const TextStyle(
                                color: ThemeConstants.secondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.10,
                              ),
                              softWrap: true,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          SizedBox(
                            width: 220.w,
                            child: Text(
                              yearsOfExperience,
                              style: const TextStyle(
                                color: ThemeConstants.secondaryColorLight,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              softWrap: true,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10.w),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Color(0xFFFF9620),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            rating,
                            style: const TextStyle(
                              color: ThemeConstants.secondaryColorLight,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 0.11,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8.w),
                      const Icon(
                        Icons.favorite,
                        size: 14,
                        color: Color(0xFFFF9620),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: ThemeConstants.primaryColorLight,
                thickness: 2,
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: specialities.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          right: index < specialities.length - 1 ? 10 : 0),
                      child: SpecialityLable(title: specialities[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
