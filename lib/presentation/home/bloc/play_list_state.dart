part of 'play_list_bloc.dart';

sealed class PlayListState extends Equatable {
  const PlayListState();

  @override
  List<Object> get props => [];
}

final class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;

  const PlayListLoaded({required this.songs});

  @override
  List<Object> get props => [songs];
}

class PlayListLoadFailure extends PlayListState {}
