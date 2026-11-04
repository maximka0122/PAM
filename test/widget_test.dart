import 'package:flutter_test/flutter_test.dart';
import 'package:gemstore_app/main.dart';

void main() {
  testWidgets('GemStore App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('GemStore'), findsOneWidget);
    expect(find.text('Feature Products'), findsOneWidget);
  });
}
