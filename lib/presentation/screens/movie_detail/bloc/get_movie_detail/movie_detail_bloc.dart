import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_detail.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_movie_detail_usecase.dart';
import 'package:meta/meta.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class GetMovieDetailBloc
    extends Bloc<MovieDetailEvent, GetMovieDetailState> {
  GetMovieDetailBloc({required GetMovieDetailUseCase getMovieDetailUseCase})
      : _getMovieDetailUseCase = getMovieDetailUseCase,
        super(GetMovieDetailInitialState()) {
    on<GetMovieDetailEvent>((event, emit) async {
      emit(GetMovieDetailLoadingState());

      final movieDetailResult = await _getMovieDetail(event.movieId);
      switch (movieDetailResult) {
        case APISuccess<MovieDetail>():
          print(movieDetailResult.value);
          final detail = movieDetailResult.value;
          emit(GetMovieDetailSuccessState(movieDetail: detail));
          break;
        case APIFailure<MovieDetail>():
          final ex = movieDetailResult.exception;
          print(ex);
          emit(GetMovieDetailFailureState(exception: ex));
          break;
      }
    });
  }

  final GetMovieDetailUseCase _getMovieDetailUseCase;

  Future<APIResult<MovieDetail>> _getMovieDetail(int movieId) async {
    final list = await _getMovieDetailUseCase.invoke(movieId: movieId);
    return list;
  }
}
