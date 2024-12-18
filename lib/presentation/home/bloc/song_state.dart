part of 'song_bloc.dart';

sealed class SongState extends Equatable {
  const SongState();

  @override
  List<Object> get props => [];
}

final class SongsLoading extends SongState {}

class SongsLoaded extends SongState {
  final List<SongEntity> songs;

  const SongsLoaded({required this.songs});

  @override
  List<Object> get props => [songs];
}

class SongsLoadFailure extends SongState {}
