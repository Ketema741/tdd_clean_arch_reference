import 'package:tdd_clean_architecture/core/routes/route_config.dart';
import 'package:tdd_clean_architecture/features/blog/data/models/blog_hive_model.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'dependency_injection.dart' as di;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BlogModelAdapter());
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<BlogBloc>(
              create: (context) => di.sl<BlogBloc>(),
            ),
          ],
          child: MaterialApp.router(
            theme: ThemeData(
              fontFamily: 'Poppins',
            ),
            debugShowCheckedModeBanner: false,
            title: 'Blog',
            routerConfig: router,
          ),
        );
      },
    );
  }
}
