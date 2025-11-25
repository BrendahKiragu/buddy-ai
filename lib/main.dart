import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buddy_ai/providers/auth_provider.dart';
import 'package:buddy_ai/services/topic_service.dart';
import 'package:buddy_ai/services/blog_service.dart';
import 'package:buddy_ai/router.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final authProvider = AuthProvider();
  await authProvider.initialize();
  
  final topicService = TopicService();
  await topicService.initialize();
  
  final blogService = BlogService();
  await blogService.initialize();
  
  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;

  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: authProvider,
      child: Builder(
        builder: (context) {
          final authProvider = context.watch<AuthProvider>();
          return MaterialApp.router(
            title: 'Buddy AI',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            routerConfig: createRouter(authProvider),
          );
        },
      ),
    );
  }
}
