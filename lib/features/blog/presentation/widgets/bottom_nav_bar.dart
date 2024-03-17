import 'package:tdd_clean_architecture/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(22.0),
        topRight: Radius.circular(22.0),
      ),
      child: BottomAppBar(
        color: ThemeConstants.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (index) {
            Widget icon;
            String text;
            switch (index) {
              case 0:
                icon = Icon(
                  Icons.home,
                  size: 16,
                  color: _selectedIndex == index
                      ? ThemeConstants.primaryColor
                      : ThemeConstants.backgroundColor,
                );
                text = 'Home';
                break;
              case 1:
                icon = Icon(
                  Icons.favorite,
                  size: 16,
                  color: _selectedIndex == index
                      ? ThemeConstants.primaryColor
                      : ThemeConstants.backgroundColor,
                );
                text = 'Favorites';
                break;

              case 2:
                icon = Icon(
                  Icons.person,
                  size: 16,
                  color: _selectedIndex == index
                      ? ThemeConstants.primaryColor
                      : ThemeConstants.backgroundColor,
                );
                text = 'Profile';
                break;
              default:
                icon = const Icon(Icons.error);
                text = 'Error';
                break;
            }
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _onItemTapped(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: _selectedIndex == index
                          ? ThemeConstants.backgroundColor
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.10,
                          color: _selectedIndex == index
                              ? ThemeConstants.backgroundColor
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: icon,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ThemeConstants.backgroundColor,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0.11,
                    letterSpacing: 0.50,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
