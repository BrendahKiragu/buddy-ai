import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:buddy_ai/providers/auth_provider.dart';
import 'package:buddy_ai/screens/landing_page.dart';
import 'package:buddy_ai/screens/login_page.dart';
import 'package:buddy_ai/screens/signup_page.dart';
import 'package:buddy_ai/screens/about_page.dart';
import 'package:buddy_ai/screens/secret_chats_page.dart';
import 'package:buddy_ai/screens/topic_detail_page.dart';
import 'package:buddy_ai/screens/blog_list_page.dart';
import 'package:buddy_ai/screens/blog_detail_page.dart';

GoRouter createRouter(AuthProvider authProvider) {
  return GoRouter(
    refreshListenable: authProvider,
    redirect: (context, state) {
      final isLoggedIn = authProvider.isLoggedIn;
      final isInitialized = authProvider.isInitialized;

      if (!isInitialized) return null;

      final isGoingToSecretChats = state.matchedLocation.startsWith('/secret-chats') ||
          state.matchedLocation.startsWith('/topic/');

      if (isGoingToSecretChats && !isLoggedIn) {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LandingPage(),
        ),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SignUpPage(),
        ),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AboutPage(),
        ),
      ),
      GoRoute(
        path: '/secret-chats',
        name: 'secret-chats',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SecretChatsPage(),
        ),
      ),
      GoRoute(
        path: '/topic/:id',
        name: 'topic',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoTransitionPage(
            child: TopicDetailPage(topicId: id),
          );
        },
      ),
      GoRoute(
        path: '/blogs',
        name: 'blogs',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: BlogListPage(),
        ),
      ),
      GoRoute(
        path: '/blog/:id',
        name: 'blog',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoTransitionPage(
            child: BlogDetailPage(blogId: id),
          );
        },
      ),
    ],
  );
}
