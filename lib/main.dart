import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qltynhdsmcxqhlzjsmvw.supabase.co', // ganti
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsdHluaGRzbWN4cWhsempzbXZ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc5MDk4MDgsImV4cCI6MjA3MzQ4NTgwOH0.mpq6zK9a8VEN6gvviMxbmTwlrEXnXE2XfNK3J__LtYE', // ganti
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Data Diri Siswa',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}
