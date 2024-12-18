part of 'song_player_bloc.dart';

sealed class SongPlayerState extends Equatable {
  const SongPlayerState();

  @override
  List<Object> get props => [];
}

final class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {}

class SongPlayerFailure extends SongPlayerState {}
