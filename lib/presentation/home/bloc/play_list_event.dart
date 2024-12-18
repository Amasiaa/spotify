part of 'play_list_bloc.dart';

sealed class PlayListEvent extends Equatable {
  const PlayListEvent();

  @override
  List<Object> get props => [];
}

class GetPlayListEvent extends PlayListEvent {}
