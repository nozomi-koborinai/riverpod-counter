import 'package:counter_riverpod/logic.dart';
import 'package:counter_riverpod/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewModel {
  final Logic _logic = Logic();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  get count => _ref.watch(countDataProvider.state).state.count.toString();
  get countUp => _ref
      //selectによってコントロールの再構築範囲を狭める
      .watch(countDataProvider.state.select((value) => value.state.countUp))
      .toString();
  get countDown => _ref
      //selectによってコントロールの再構築範囲を狭める
      .watch(countDataProvider.state.select((value) => value.state.countDown))
      .toString();

  void onIncrease() {
    _logic.increase();
    _ref.watch(countDataProvider.state).state = _logic.countData;
  }

  void onDecrease() {
    _logic.decrease();
    _ref.watch(countDataProvider.state).state = _logic.countData;
  }

  void onReset() {
    _logic.reset();
    _ref.watch(countDataProvider.state).state = _logic.countData;
  }
}
