part of 'favorite_button_bloc.dart';

sealed class FavoriteButtonEvent extends Equatable {
  const FavoriteButtonEvent();

  @override
  List<Object> get props => [];
}

class FavoriteButtonUpdatedEvent extends FavoriteButtonEvent {
  final String songId;

  const FavoriteButtonUpdatedEvent({required this.songId});

  @override
  List<Object> get props => [songId];
}
