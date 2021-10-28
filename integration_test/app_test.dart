import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:social_network_x/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('signinButton')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('signinPageKey')), findsOneWidget);

      await tester.tap(find.byKey(const Key('popButton')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('initPageKey')), findsOneWidget);

      await tester.tap(find.byKey(const Key('signupButton')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('signupPageKey')), findsOneWidget);

      await tester.tap(find.byKey(const Key('popButton')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('initPageKey')), findsOneWidget);
    });
  });
}
