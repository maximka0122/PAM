import 'package:flutter_test/flutter_test.dart';
import 'package:convertor_valutar/main.dart';

void main() {
  testWidgets('Currency converter UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CurrencyConverterApp());

    // Verify that title and key UI elements exist.
    expect(find.text('Convertor Valutar'), findsWidgets);
    expect(find.text('Suma de convertit'), findsOneWidget);
    expect(find.text('Rezultat Convertit'), findsOneWidget);
  });
}
