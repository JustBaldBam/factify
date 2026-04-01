import 'package:flutter_test/flutter_test.dart';
import 'package:newssports/main.dart';

void main() {
  testWidgets('Factify app renders bottom navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const FactifyApp());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Saved'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
