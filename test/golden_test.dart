import 'package:counter_riverpod/main.dart';
import 'package:counter_riverpod/provider.dart';
import 'package:counter_riverpod/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

class MockViewModel extends Mock implements ViewModel {}

void main() {
  //setUpAll：最初に1回実行
  //setUp：各テスト前に実行
  //tearDown：各テスト後に実行
  //tearDownAll：最後に1回実行
  setUpAll(() async {
    await loadAppFonts();
  });

  Device iPhone55 = const Device(
      size: Size(414, 736), name: 'iPhone55', devicePixelRatio: 3.0);
  List<Device> devices = [iPhone55];

  testGoldens('normal', (tester) async {
    ViewModel viewModel = ViewModel();

    await tester.pumpWidgetBuilder(ProviderScope(child: MyHomePage(viewModel)));

    await multiScreenGolden(tester, 'myHomePage_0init', devices: devices);

    await tester.tap(find.byIcon(CupertinoIcons.add));
    await tester.tap(find.byIcon(CupertinoIcons.add));
    await tester.tap(find.byIcon(CupertinoIcons.minus));
    await tester.pump();

    await multiScreenGolden(tester, 'myHomePage_1tapped', devices: devices);
  });

  testGoldens('viewModelTest', (tester) async {
    var mock = MockViewModel();
    when(() => mock.count).thenReturn(1123456789.toString());
    when(() => mock.countUp).thenReturn(1123456789.toString());
    when(() => mock.countDown).thenReturn(1123456789.toString());

    final mockTitleProvider = Provider<String>((ref) => 'mockTitle');
    final mockMessageProvider = Provider<String>((ref) => 'mockMessage');

    await tester.pumpWidgetBuilder(ProviderScope(
      child: MyHomePage(mock),
      overrides: [
        titleProvider.overrideWithProvider(mockTitleProvider),
        messageProvider.overrideWithValue('mockMessage')
      ],
    ));

    await multiScreenGolden(tester, 'myHomePage_mock', devices: devices);

    verifyNever(() => mock.onIncrease());
    verifyNever(() => mock.onDecrease());
    verifyNever(() => mock.onReset());

    await tester.tap(find.byIcon(CupertinoIcons.plus));
    verify(() => mock.onIncrease()).called(1);
    verify(() => mock.onDecrease()).called(0);
    verify(() => mock.onReset()).called(0);

    await tester.tap(find.byIcon(CupertinoIcons.minus));
    verify(() => mock.onIncrease()).called(1);
    verify(() => mock.onDecrease()).called(0);
    verify(() => mock.onReset()).called(0);
  });
}
