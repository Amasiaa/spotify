// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/get_news_songs_usecase.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final GetNewsSongsUseCase getNewsSongsUseCase;

  SongBloc({
    required this.getNewsSongsUseCase,
  }) : super(SongsLoading()) {
    on<GetNewsSongsEvent>(_onGetNewsSongs);
  }

  FutureOr<void> _onGetNewsSongs(
    GetNewsSongsEvent event,
    Emitter<SongState> emit,
  ) async {
    emit(SongsLoading());
    try {
      final result = await getNewsSongsUseCase.call();

      result.fold(
        (error) {
          emit(SongsLoadFailure());
          debugPrint('SONGBLOC ERROR.....: ${error.toString()}');
        },
        (songs) {
          emit(SongsLoaded(songs: songs));
          debugPrint('SONGBLOC DATA.....: ${songs.toString()}');
        },
      );
    } catch (e) {
      emit(SongsLoadFailure());
    }
  }
}
