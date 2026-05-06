import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/auth/presentation/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_helpers/pump_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('LoginScreen renders without crashing', (
    WidgetTester tester,
  ) async {
    await pumpAppWidget(tester, child: const LoginScreen());

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
