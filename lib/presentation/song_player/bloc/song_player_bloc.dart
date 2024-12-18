import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'song_player_event.dart';
part 'song_player_state.dart';

class SongPlayerBloc extends Bloc<SongPlayerEvent, SongPlayerState> {
  SongPlayerBloc() : super(SongPlayerLoading()) {
    on<LoadSongEvent>(_onLoadSong);
  }

  FutureOr<void> _onLoadSong(
    LoadSongEvent event,
    Emitter<SongPlayerState> emit,
  ) async {
    AudioPlayer audioPlayer = AudioPlayer();
    try {
      await audioPlayer.setUrl(event.url);
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerFailure());
    }
    // TODO: implement event handler
  }
}
