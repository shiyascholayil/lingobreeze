import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';


import 'injection/dependency_injection.dart';
import 'presentation/ page/my_vocabulary_page.dart';
import 'presentation/bloc/word_bloc.dart';
import 'presentation/bloc/word_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDed8Wc-AkhOByUWmivC0X5pm3XDJ2JEXI',
      appId: '1:155156404991:android:223a6567fb7d695a48caca',
      messagingSenderId: '155156404991',
      projectId: 'lingobreeze-14e41',
      storageBucket: 'lingobreeze-14e41.firebasestorage.app',
    ),
  );

  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LingoBreeze',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => getIt<WordBloc>()..add(LoadWordsEvent()),
        child: const MyVocabularyPage(),
      ),
    );
  }
}