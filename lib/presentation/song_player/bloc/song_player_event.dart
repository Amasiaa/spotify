part of 'song_player_bloc.dart';

sealed class SongPlayerEvent extends Equatable {
  const SongPlayerEvent();

  @override
  List<Object> get props => [];
}

class LoadSongEvent extends SongPlayerEvent {
  final String url;

  const LoadSongEvent({required this.url});

  @override
  List<Object> get props => [url];
}
