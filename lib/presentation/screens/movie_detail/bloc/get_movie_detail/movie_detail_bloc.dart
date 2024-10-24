import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_detail.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_movie_detail_usecase.dart';
import 'package:meta/meta.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class GetMovieDetailBloc extends Bloc<MovieDetailEvent, GetMovieDetailState> {
  GetMovieDetailBloc(this._getMovieDetailUseCase) : super(GetMovieDetailInitialState()) {
    on<GetMovieDetailEvent>(_getMovieDetail);
  }

  final GetMovieDetailUseCase _getMovieDetailUseCase;

  Future<void> _getMovieDetail(GetMovieDetailEvent event, Emitter<GetMovieDetailState> emit) async {
    emit(GetMovieDetailLoadingState());
    final movieDetailResult = await _getMovieDetailUseCase.invoke(movieId: event.movieId);
    switch (movieDetailResult) {
      case APISuccess<MovieDetail>():
        final detail = movieDetailResult.value;
        emit(GetMovieDetailSuccessState(movieDetail: detail));
        break;
      case APIFailure<MovieDetail>():
        final ex = movieDetailResult.exception;
        emit(GetMovieDetailFailureState(exception: ex));
        break;
    }
  }
}
