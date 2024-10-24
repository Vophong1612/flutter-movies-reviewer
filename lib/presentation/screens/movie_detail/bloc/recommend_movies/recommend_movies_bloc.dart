import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_recommend_movies_usecase.dart';
import 'package:meta/meta.dart';

part 'recommend_movies_event.dart';

part 'recommend_movies_state.dart';

class GetRecommendMoviesBloc extends Bloc<RecommendMoviesEvent, GetRecommendMoviesState> {
  GetRecommendMoviesBloc(this._getRecommendUseCase) : super(GetRecommendMovieInitialState()) {
    on<GetRecommendMoviesEvent>(_getRecommendMovies);
  }

  final GetRecommendMoviesUseCase _getRecommendUseCase;

  Future<void> _getRecommendMovies(GetRecommendMoviesEvent event, Emitter<GetRecommendMoviesState> emit) async {
    emit(GetRecommendMovieLoadingState());
    final recommendMoviesResult = await _getRecommendUseCase.invoke(movieId: event.movieId);
    switch (recommendMoviesResult) {
      case APISuccess<List<Movie>>():
        final list = recommendMoviesResult.value;
        emit(GetRecommendMovieSuccessState(recommendMovies: list));
        break;
      case APIFailure<List<Movie>>():
        final ex = recommendMoviesResult.exception;
        emit(GetRecommendMovieFailureState(exception: ex));
        break;
    }
  }
}
