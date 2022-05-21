library single_result_bloc;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_result_bloc/single_result_mixin.dart';

export 'single_result_bloc_builder.dart';

/// Interface for extending [Bloc] abilities to sending [SingleResult]
abstract class SingleResultBloc<Event, State, SingleResult>
    extends Bloc<Event, State>
    with SingleResultMixin<Event, State, SingleResult> {
  SingleResultBloc(State state) : super(state);
}
