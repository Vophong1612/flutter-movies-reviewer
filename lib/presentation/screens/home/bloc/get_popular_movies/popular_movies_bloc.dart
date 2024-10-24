import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_popular_movies_usecase.dart';
import 'package:meta/meta.dart';

part 'popular_movies_event.dart';

part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc(this._getPopularMoviesUseCase) : super(PopularMoviesInitialState()) {
    on<GetPopularMoviesEvent>(_getPopularMovies);
  }

  final GetPopularMoviesUseCase _getPopularMoviesUseCase;

  Future<void> _getPopularMovies(GetPopularMoviesEvent event, Emitter<PopularMoviesState> emit) async {
    emit(PopularMoviesLoadingState());
    final popularMoviesResult = await _getPopularMoviesUseCase.invoke();
    switch (popularMoviesResult) {
      case APISuccess<List<Movie>>():
        final list = popularMoviesResult.value;
        emit(PopularMoviesSuccessState(movies: list));
        break;
      case APIFailure<List<Movie>>():
        final ex = popularMoviesResult.exception;
        emit(PopularMoviesFailureState(exception: ex));
        break;
    }
  }
}
