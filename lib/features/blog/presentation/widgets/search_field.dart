import 'package:tdd_clean_architecture/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchInputField extends StatefulWidget {
  @override
  _SearchInputFieldState createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 50.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search Doctor ',
          hintStyle: const TextStyle(
            color: ThemeConstants.hintTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 0.11,
            letterSpacing: 0.50,
          ),
          contentPadding: const EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: ThemeConstants.hintTextColor,
            ),
          ),
        ),
        onSubmitted: (String value) {},
      ),
    );
  }
}
