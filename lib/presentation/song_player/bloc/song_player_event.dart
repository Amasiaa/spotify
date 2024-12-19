part of 'song_player_bloc.dart';

sealed class SongPlayerEvent extends Equatable {
  const SongPlayerEvent();

  @override
  List<Object> get props => [];
}

class LoadSongEvent extends SongPlayerEvent {
  final String url;
  final bool isPlaying;

  const LoadSongEvent({required this.url, this.isPlaying = true});

  @override
  List<Object> get props => [url, isPlaying];
}

class PlayOrPauseSongEvent extends SongPlayerEvent {
  final bool isPlaying;
  final double progress;

  const PlayOrPauseSongEvent({required this.isPlaying, this.progress = 0.0});

  @override
  List<Object> get props => [isPlaying, progress];
}

class UpdateSongPlayerEvent extends SongPlayerEvent {
  final double progress;

  const UpdateSongPlayerEvent({required this.progress});

  @override
  List<Object> get props => [progress];
}
