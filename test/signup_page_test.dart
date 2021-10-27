import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/auth/signup_page.dart';

void main() {
  const signupIcon = Key('signupIcon');
  const signupEmailInput = Key('signupEmailInput');
  const signupPasswordInput = Key('signupPasswordInput');
  const signupButton = Key('signupButton');
  const popButton = Key('popButton');

  testWidgets('finds SignupPage widgets', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupPage()));

    expect(find.byKey(signupIcon), findsOneWidget);
    expect(find.byKey(signupEmailInput), findsOneWidget);
    expect(find.byKey(signupPasswordInput), findsOneWidget);
    expect(find.byKey(signupButton), findsOneWidget);
    expect(find.byKey(popButton), findsOneWidget);
  });

  testWidgets('add email and password', (WidgetTester tester) async {
    const email = 'test@email.com';
    const password = 'password123X';

    await tester.pumpWidget(const MaterialApp(home: SignupPage()));
    await tester.enterText(find.byKey(signupEmailInput), email);
    await tester.enterText(find.byKey(signupPasswordInput), password);
    await tester.tap(find.byKey(signupButton));
    await tester.pump();

    expect(find.text(email), findsOneWidget);
    expect(find.text(password), findsOneWidget);
  });
}
