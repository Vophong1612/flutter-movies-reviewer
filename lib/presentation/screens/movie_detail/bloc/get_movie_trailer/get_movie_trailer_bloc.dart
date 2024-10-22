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

class GetMovieTrailerBloc
    extends Bloc<MovieTrailerEvent, GetMovieTrailerState> {
  GetMovieTrailerBloc({required GetMovieVideosUseCase getMovieVideosUseCase})
      : _getMovieVideosUseCase = getMovieVideosUseCase,
        super(GetMovieTrailerInitialState()) {
    on<GetMovieTrailerEvent>((event, emit) async {
      emit(GetMovieTrailerLoadingState());

      final result = await _getMovieVideos(event.movieId);
      switch (result) {
        case APISuccess<List<MovieVideo>>():
          result.value.sort((a, b) =>
              CustomDateUtils.getDateTime(a.publishedAt).compareTo(
                  CustomDateUtils.getDateTime(b.publishedAt)));
          final video = result.value.lastWhere((element) => element.type == "Trailer", orElse: () => const MovieVideo());
          emit(GetMovieTrailerSuccessState(movieVideo: video));
          break;
        case APIFailure<List<MovieVideo>>():
          emit(GetMovieTrailerErrorState(exception: result.exception));
          break;
      }
    });
  }

  final GetMovieVideosUseCase _getMovieVideosUseCase;

  Future<APIResult<List<MovieVideo>>> _getMovieVideos(int movieId) async {
    return await _getMovieVideosUseCase.invoice(movieId);
  }
}
