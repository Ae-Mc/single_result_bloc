import 'package:flutter_test/flutter_test.dart';

import 'package:single_result_bloc/single_result_bloc.dart';

class TestState {}

class TestSingleResult {
  final String result;

  TestSingleResult(this.result);

  @override
  bool operator ==(Object other) =>
      other is TestSingleResult && other.result == result;

  @override
  int get hashCode => result.hashCode;
}

class TestEvent {}

class TestEventSendSingleResult extends TestEvent {
  final String result;

  TestEventSendSingleResult(this.result);
}

class TestBloc
    extends SingleResultBloc<TestEvent, TestState, TestSingleResult> {
  TestBloc() : super(TestState()) {
    on((event, emit) {
      if (event is TestEventSendSingleResult) {
        addSingleResult(TestSingleResult(event.result));
      }
    });
  }
}

void main() {
  test('single results sending', () async {
    final singleResultBloc = TestBloc();
    final List<TestSingleResult> singleResults = [];
    final singleResultSubscription = singleResultBloc.singleResults
        .listen((event) => singleResults.add(event));
    expect(singleResults.isEmpty, true);
    singleResultBloc.add(TestEventSendSingleResult('Test'));
    await Future.delayed(const Duration(milliseconds: 5));
    expect(singleResults, [TestSingleResult('Test')]);
    expect(singleResults.length, 1);
    singleResultSubscription.cancel();
  });
}
