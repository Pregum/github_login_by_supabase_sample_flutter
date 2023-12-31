import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_login_by_supabase_sample_flutter/login_after_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './login_page.dart';
import './splash_page.dart';

Future<void> main() async {
  await dotenv.load();

  final supabaseUrl = dotenv.get('SUPABASE_URL', fallback: '');
  final anonKey = dotenv.get('SUPABASE_ANONKEY', fallback: '');
  debugPrint('SUPABASE_URL: $supabaseUrl');
  debugPrint('ANON_KEY: $anonKey');

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: anonKey,
    authFlowType: AuthFlowType.pkce,
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Login Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/login-after': (_) => const LoginAfterPage(),
      },
    );
  }
}
