library single_result_bloc;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Mixin for extending [Bloc] abilities with support of [SingleResult]
mixin SingleResultMixin<Event, State, SingleResult> on Bloc<Event, State>
    implements
        SingleResultProvider<SingleResult>,
        SingleResultEmmiter<SingleResult> {
  @protected
  final StreamController<SingleResult> _singleResultController =
      StreamController.broadcast();

  @override
  Stream<SingleResult> get singleResults => _singleResultController.stream;

  @override
  void addSingleResult(SingleResult singleResult) {
    final observer = Bloc.observer;
    if (observer is SingleResultBlocObserver) {
      observer.onSingleResult(this, singleResult);
    }
    if (!_singleResultController.isClosed) {
      _singleResultController.add(singleResult);
    }
  }

  @override
  Future<void> close() async {
    // ignore: avoid-ignoring-return-values
    await _singleResultController.close();

    return super.close();
  }
}

/// Interface for providing [SingleResult] event stream
abstract class SingleResultProvider<SingleResult> {
  Stream<SingleResult> get singleResults;
}

/// Interface for handling [SingleResult] events
abstract class SingleResultEmmiter<SingleResult> {
  void addSingleResult(SingleResult singleResult);
}

/// Extension Observer for support of logging [SingleResult] events
abstract class SingleResultBlocObserver<SingleResult> extends BlocObserver {
  @protected
  @mustCallSuper
  void onSingleResult(Bloc bloc, SingleResult singleResult);
}
