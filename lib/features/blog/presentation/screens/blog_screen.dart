import 'package:tdd_clean_architecture/core/constants/theme_constants.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/widgets/bottom_nav_bar.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/widgets/blog_card.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/widgets/search_field.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/widgets/speciality_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the BlogBloc instance
    final BlogBloc blogBloc = BlocProvider.of<BlogBloc>(context);

    // Add event to fetch blogs when the widget is built
    blogBloc.add(GetBlogsEvent());

    ScreenUtil.init(context, designSize: const Size(360, 690));

    final List<String> specialities = [
      'Cardiologist',
      'Neurologist',
      'Pediatrician',
      'Surgeon',
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
              child: InkWell(
                onTap: () {
                  _showPopup(context);
                },
                child: SvgPicture.asset(
                  "assets/images/mi_filter.svg",
                  semanticsLabel: 'SVG Icon',
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'General Practitioners',
                    style: TextStyle(
                      color: ThemeConstants.secondaryColorLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                      letterSpacing: 0.15,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push('/doctors-list');
                    },
                    child: const Text(
                      'See all',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeConstants.secondaryColorLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        // height: 0.11,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              BlocBuilder<BlogBloc, BlogState>(
                builder: (context, state) {
                  if (state is BlogLoadingState) {
                    return const CircularProgressIndicator(); // Show loading indicator
                  } else if (state is BlogSuccessState) {
                    return SizedBox(
                      height: 290.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.blogs.length,
                        itemBuilder: (context, index) {
                          var blog = state.blogs[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                right: index < state.blogs.length - 1 ? 10 : 0),
                            child: BlogCard(
                              name: blog.title,
                              specialities: specialities,
                              yearsOfExperience: blog.body,
                              rating: '4.5',
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is BlogFailureState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                        ),
                      );
                    });
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 32.h),
                      const Text(
                        'Specialities',
                        style: TextStyle(
                          color: ThemeConstants.secondaryColorLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 0.09,
                          letterSpacing: 0.15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'See all',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeConstants.secondaryColorLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 0.11,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 24.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SpecialityCard(),
                  SpecialityCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.drag_handle_outlined,
                          color: Color.fromARGB(255, 134, 134, 134)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 224, 224, 224),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            // Perform action for "Institute" button
                          },
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Speciality',
                                style: TextStyle(
                                    color: ThemeConstants.secondaryColor)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            // Perform action for "Experience" button
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 224, 224, 224),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Institute',
                                style: TextStyle(
                                    color: ThemeConstants.secondaryColor)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            // Perform action for "Education" button
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 224, 224, 224),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('year of Experiance',
                                style: TextStyle(
                                    color: ThemeConstants.secondaryColor)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            // Perform action for "Gender" button
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 224, 224, 224),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Gender',
                                style: TextStyle(
                                    color: ThemeConstants.secondaryColor)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ThemeConstants.primaryColor),
                      ),
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(104, 164, 244, 1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: ThemeConstants.primaryColor),
                      ),
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: TextButton(
                        onPressed: () {
                          // Perform action for the filter button
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Filter',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
