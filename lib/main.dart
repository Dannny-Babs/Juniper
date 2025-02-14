import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'core/utils/utils.dart';
import 'features/navigation/presentation/bloc/navigation_bloc.dart';
import 'features/onboarding/bloc/onboarding_bloc.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database properly
  await initializeDependencies();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final isOnboardingCompleted = prefs.getBool('onboarding_complete') ?? false;

  final router = AppRouter.createRouter(isOnboardingCompleted);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              OnboardingBloc(prefs: prefs)..add(OnboardingStarted()),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(prefs),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
      ],
      child: MainApp(router: router),
    ),
  );
}

Future<void> initializeDependencies() async {
  try {
    final appDocDir = await getApplicationDocumentsDirectory();
    await Directory(appDocDir.path).create(recursive: true);

    final dbPath = path.join(appDocDir.path, 'juniper.db');

    // Open database with minimal configuration first
    final database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS properties (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT,
            image_url TEXT,
            price REAL,
            location TEXT
          )
        ''');
      },
    );

    // Configure database after it's open
    try {
      // Set basic PRAGMA values one at a time
      await database.rawQuery('PRAGMA foreign_keys = ON');
      await database.rawQuery('PRAGMA synchronous = NORMAL');
      await database.rawQuery('PRAGMA cache_size = 2000');
      await database.rawQuery('PRAGMA temp_store = MEMORY');
      await database.rawQuery('PRAGMA journal_mode = DELETE');
    } catch (e) {
      debugPrint('Error configuring database: $e');
    }

    await CacheManager.initialize();
  } catch (e, stack) {
    debugPrint('Database initialization error: $e\n$stack');
    rethrow;
  }
}

class CacheManager {
  static Future<void> initialize() async {
    final cacheDir = await getTemporaryDirectory();
    await cacheDir.create(recursive: true);
  }
}

class MainApp extends StatelessWidget {
  final GoRouter router;

  const MainApp({
    super.key,
    required this.router,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}
