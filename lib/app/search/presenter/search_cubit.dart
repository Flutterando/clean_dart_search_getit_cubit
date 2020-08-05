import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:rxdart/rxdart.dart';

import '../domain/usecases/search_by_text.dart';
import 'states/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchByText searchByText;

  CancelableOperation cancelable;

  SearchCubit(this.searchByText) : super(const StartState());

  Future<SearchState> execute(String textSearch) async {
    final response = await searchByText(textSearch);
    final result = response.fold(
      (failure) => ErrorState(failure),
      (success) => SuccessState(success),
    );
    return result;
  }

  Future<void> addSearch(String textSearch) async {
    await cancelable?.cancel();

    if (textSearch.isEmpty) {
      emit(StartState());
      return;
    }
    emit(const LoadingState());
    cancelable = CancelableOperation.fromFuture(
        Future.delayed(Duration(milliseconds: 800)));
    await cancelable.value;
    if (cancelable.isCompleted) {
      emit(await execute(textSearch));
    }
  }
}
