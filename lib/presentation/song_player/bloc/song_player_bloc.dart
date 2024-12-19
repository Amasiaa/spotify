import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'song_player_event.dart';
part 'song_player_state.dart';

class SongPlayerBloc extends Bloc<SongPlayerEvent, SongPlayerState> {
  final AudioPlayer audioPlayer;
  Timer? timer;
  bool isPlaying = false;
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerBloc({
    required this.audioPlayer,
  }) : super(SongPlayerLoading()) {
    on<LoadSongEvent>(_onLoadSong);
    on<PlayOrPauseSongEvent>(_onPlayOrPauseSong);
    on<UpdateSongPlayerEvent>(_onUpdateSongPlayer);

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });

    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      add(UpdateSongPlayerEvent(progress: position.inSeconds.toDouble()));
    });
  }

  FutureOr<void> _onLoadSong(
    LoadSongEvent event,
    Emitter<SongPlayerState> emit,
  ) async {
    try {
      await audioPlayer.setUrl(event.url);
      audioPlayer.play();
      isPlaying = true;
      double progress = 0.0;

      emit(state.copyWith(
        isPlaying: true,
        status: SongStatus.playing,
        fileUrl: event.url,
      ));
      //emit(SongPlayerLoaded());
      Timer.periodic(
        const Duration(milliseconds: 1),
        (timer) {
          progress = audioPlayer.duration == null
              ? 0.0
              : audioPlayer.position.inMilliseconds /
                  audioPlayer.duration!.inMilliseconds;
          add(UpdateSongPlayerEvent(progress: progress));
          if (progress >= 1.0) {
            timer.cancel();
          }
        },
      );
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  void _onPlayOrPauseSong(
    PlayOrPauseSongEvent event,
    Emitter<SongPlayerState> emit,
  ) {
    try {
      if (isPlaying) {
        audioPlayer.pause();
        emit(state.copyWith(isPlaying: false));
      } else {
        audioPlayer.play();
        emit(state.copyWith(isPlaying: true));
      }
      isPlaying = event.isPlaying;
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  void _onUpdateSongPlayer(
    UpdateSongPlayerEvent event,
    Emitter<SongPlayerState> emit,
  ) {
    if (event.progress == 1.0) {
      add(LoadSongEvent(url: state.fileUrl!));
    } else {
      emit(state.copyWith(
        progress: event.progress,
      ));
    }
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
