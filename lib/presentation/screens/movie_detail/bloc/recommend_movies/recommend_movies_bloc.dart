import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_recommend_movies_usecase.dart';
import 'package:meta/meta.dart';

part 'recommend_movies_event.dart';

part 'recommend_movies_state.dart';

class GetRecommendMoviesBloc
    extends Bloc<RecommendMoviesEvent, GetRecommendMoviesState> {
  GetRecommendMoviesBloc({required GetRecommendMoviesUseCase getRecommendMoviesUseCase})
      : _getRecommendUseCase = getRecommendMoviesUseCase,
        super(GetRecommendMovieInitialState()) {
    on<GetRecommendMoviesEvent>((event, emit) async {
      emit(GetRecommendMovieLoadingState());

      final recommendMoviesResult = await _getRecommendMovies(event.movieId);
      switch (recommendMoviesResult) {
        case APISuccess<List<Movie>>():
          print(recommendMoviesResult.value);
          final list = recommendMoviesResult.value;
          emit(GetRecommendMovieSuccessState(recommendMovies: list));
          break;
        case APIFailure<List<Movie>>():
          final ex = recommendMoviesResult.exception;
          print(ex);
          emit(GetRecommendMovieFailureState(exception: ex));
          break;
      }
    });
  }

  final GetRecommendMoviesUseCase _getRecommendUseCase;

  Future<APIResult<List<Movie>>> _getRecommendMovies(int movieId) async {
    final list = await _getRecommendUseCase.invoke(movieId: movieId);
    return list;
  }
}
