import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juniper/core/utils/utils.dart';
import 'package:juniper/main.dart';

void main() {
  group('MainApp Widget Tests', () {
    late SharedPreferences prefs;

    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    testWidgets('Counter increments smoke test', (WidgetTester tester) async {
      final isOnboardingCompleted = prefs.getBool('onboarding_complete') ?? false;
      final router = AppRouter.createRouter(isOnboardingCompleted);

      await tester.pumpWidget(MainApp(router: router));

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    });
  });
}
