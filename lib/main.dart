import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory, getTemporaryDirectory;
import 'core/utils/utils.dart';
import 'features/property_details/data/repositories/property_repository_impl.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Clear any hanging PIF transfer sessions that might cause issues
  try {
    final tempDir = await getTemporaryDirectory();
    final pifDir = Directory('${tempDir.path}/PIFSession');
    if (await pifDir.exists()) {
      await pifDir.delete(recursive: true);
    }
  } catch (e) {
    debugPrint('Failed to clear PIF sessions: $e');
  }

  // Initialize database properly
  await initializeDependencies();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final isOnboardingCompleted = prefs.getBool('onboarding_complete') ?? false;

  // Register error handlers
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('Flutter error: ${details.exception}');
  };

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
        BlocProvider<PropertyDetailsBloc>(
          create: (context) => PropertyDetailsBloc(
            propertyRepository: PropertyRepositoryImpl(),
          ),
          // Don't lazy load this BLoC
          lazy: false,
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

    // Try to delete any problematic lockfiles that might cause PIF transfer issues
    try {
      final lockFile = File('$dbPath-shm');
      if (await lockFile.exists()) {
        await lockFile.delete();
      }
      final journalFile = File('$dbPath-wal');
      if (await journalFile.exists()) {
        await journalFile.delete();
      }
    } catch (e) {
      debugPrint('Failed to clear database lock files: $e');
      // Continue anyway
    }

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
      // Add timeout to prevent hanging
      singleInstance: true,
      readOnly: false,
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
