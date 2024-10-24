import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_top_rated_movies_usecase.dart';
import 'package:meta/meta.dart';

part 'toprated_movies_event.dart';

part 'toprated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  TopRatedMoviesBloc(this._getTopRatedMoviesUseCase) : super(TopRatedInitialState()) {
    on<TopRatedMoviesEvent>(_getTopRatedMovies);
  }

  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;

  Future<void> _getTopRatedMovies(TopRatedMoviesEvent event, Emitter<TopRatedMoviesState> emit) async {
    emit(TopRatedInitialState());
    final popularMoviesResult = await _getTopRatedMoviesUseCase.invoke();
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
  }
}
