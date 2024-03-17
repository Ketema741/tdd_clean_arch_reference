import 'package:tdd_clean_architecture/core/constants/route_constants.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/screens/blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: RouteConstants.spalashRouteName,
      builder: (BuildContext context, GoRouterState state) {
        return const BlogScreen();
      },
    ),
  ],
);
