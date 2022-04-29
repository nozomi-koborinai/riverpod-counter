import 'package:counter_riverpod/data/count_data.dart';

class Logic {
  //状態管理をするためのインスタンスを生成
  CountData _countData = const CountData(count: 0, countUp: 0, countDown: 0);

  //getter
  get countData => _countData;

  //カウントアップ
  void increase() {
    _countData = _countData.copyWith(
        count: _countData.count + 1, countUp: _countData.countUp + 1);
  }

  //カウントダウン
  void decrease() {
    _countData = _countData.copyWith(
        count: _countData.count - 1, countDown: _countData.countDown + 1);
  }

  //初期化
  void reset() {
    _countData = const CountData(count: 0, countUp: 0, countDown: 0);
  }
}
