import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/auth/signin_page.dart';

void main() {
  const signinIcon = Key('signinIcon');
  const signinEmailInput = Key('signinEmailInput');
  const signinPasswordInput = Key('signinPasswordInput');
  const signinButton = Key('signinButton');
  const popButton = Key('popButton');
  testWidgets('finds SigninPage widgets', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SigninPage()));

    expect(find.byKey(signinIcon), findsOneWidget);
    expect(find.byKey(signinEmailInput), findsOneWidget);
    expect(find.byKey(signinPasswordInput), findsOneWidget);
    expect(find.byKey(signinButton), findsOneWidget);
    expect(find.byKey(popButton), findsOneWidget);
  });

  testWidgets('add email and password', (WidgetTester tester) async {
    const email = 'test@email.com';
    const password = 'password123X';

    await tester.pumpWidget(const MaterialApp(home: SigninPage()));

    await tester.enterText(find.byKey(signinEmailInput), email);
    await tester.enterText(find.byKey(signinPasswordInput), password);
    await tester.tap(find.byKey(signinButton));
    await tester.pump();

    expect(find.text(email), findsOneWidget);
    expect(find.text(password), findsOneWidget);
  });
}
