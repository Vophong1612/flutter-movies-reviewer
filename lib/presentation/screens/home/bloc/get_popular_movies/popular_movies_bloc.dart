import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movies_reviewer/domain/models/movie.dart';
import 'package:flutter_movies_reviewer/domain/usecase/get_popular_movies_usecase.dart';
import 'package:meta/meta.dart';

part 'popular_movies_event.dart';

part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc(
      {required GetPopularMoviesUseCase getPopularMoviesUseCase}
      ): _getPopularMoviesUseCase = getPopularMoviesUseCase,
        super(PopularMoviesInitialState()) {
    on<GetPopularMoviesEvent>((event, emit) async {
      emit(PopularMoviesLoadingState());
      final list = await _getPopularMovies(event, emit);
      emit(PopularMoviesSuccessState(movies: list));
    });
  }

  final GetPopularMoviesUseCase _getPopularMoviesUseCase;

  Future<List<Movie>> _getPopularMovies(PopularMoviesEvent event, Emitter<PopularMoviesState> emit) async {
    final list = await _getPopularMoviesUseCase.invoke();
    return list;
  }
}
