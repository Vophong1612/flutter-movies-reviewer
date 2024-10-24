import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_reviewer/domain/models/movie_video.dart';
import 'package:flutter_movies_reviewer/domain/result.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_movie_videos_use_case.dart';
import 'package:flutter_movies_reviewer/domain/utils/custom_date_utils.dart';
import 'package:meta/meta.dart';

part 'get_movie_trailer_event.dart';

part 'get_movie_trailer_state.dart';

class GetMovieTrailerBloc extends Bloc<MovieTrailerEvent, GetMovieTrailerState> {
  GetMovieTrailerBloc(this._getMovieVideosUseCase) : super(GetMovieTrailerInitialState()) {
    on<GetMovieTrailerEvent>(_getMovieVideos);
  }

  final GetMovieVideosUseCase _getMovieVideosUseCase;

  Future<void> _getMovieVideos(GetMovieTrailerEvent event, Emitter<GetMovieTrailerState> emit) async {
    emit(GetMovieTrailerLoadingState());
    final result = await _getMovieVideosUseCase.invoke(event.movieId);
    switch (result) {
      case APISuccess<List<MovieVideo>>():
        result.value.sort(
            (a, b) => CustomDateUtils.getDateTime(a.publishedAt).compareTo(CustomDateUtils.getDateTime(b.publishedAt)));
        final video = result.value.lastWhere((element) => element.type == "Trailer", orElse: () => const MovieVideo());
        emit(GetMovieTrailerSuccessState(movieVideo: video));
        break;
      case APIFailure<List<MovieVideo>>():
        emit(GetMovieTrailerErrorState(exception: result.exception));
        break;
    }
  }
}
