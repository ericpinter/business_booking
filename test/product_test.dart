import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:business_booking/storage.dart';
import 'package:business_booking/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Adding Product smoke test', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    ShopState(sharedPreferences);

    await tester.pumpWidget(MyApp());

    print("step 1");
    await tester.tap(find.text("Business Owner"));
    await tester.pumpAndSettle();

    print("step 2");

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();


    print("step 3");
    // Try and submit an invalid form
    await tester.tap(find.text("Submit"));
    await tester.pumpAndSettle();

    expect(find.text('Please enter some text'), findsOneWidget);
    expect(find.text('Please enter a number'), findsOneWidget);
    expect(find.text('Please enter the length in minutes'), findsOneWidget);

    // Exit out of form inconclusively. This tests if caller handles null products correctly
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);

  });
}