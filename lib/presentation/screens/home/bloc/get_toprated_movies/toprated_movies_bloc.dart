import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_top_rated_movies_usecase.dart';
import 'package:meta/meta.dart';

part 'toprated_movies_event.dart';

part 'toprated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  TopRatedMoviesBloc({
    required GetTopRatedMoviesUseCase getTopRatedMoviesUseCase,
  })  : _getTopRatedMoviesUseCase = getTopRatedMoviesUseCase,
        super(TopRatedInitialState()) {
    on<TopRatedMoviesEvent>((event, emit) async {
      emit(TopRatedInitialState());
      final popularMoviesResult = await _getTopRatedMovies(event, emit);

      switch (popularMoviesResult) {
        case APISuccess<List<Movie>>():
          final list = popularMoviesResult.value;
          emit(TopRatedSuccessState(movies: list));
          break;
        case APIFailure<List<Movie>>():
          final ex = popularMoviesResult.exception;
          emit(TopRatedMoviesFailureState(exception: ex));
          break;
      }
    });
  }

  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;

  Future<APIResult<List<Movie>>> _getTopRatedMovies(
    TopRatedMoviesEvent event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    final list = await _getTopRatedMoviesUseCase.invoke();
    return list;
  }
}
