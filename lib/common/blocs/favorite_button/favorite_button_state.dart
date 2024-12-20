part of 'favorite_button_bloc.dart';

sealed class FavoriteButtonState extends Equatable {
  const FavoriteButtonState();

  @override
  List<Object> get props => [];
}

final class FavoriteButtonInitial extends FavoriteButtonState {}

class FavoriteButtonUpdated extends FavoriteButtonState {
  final bool isFavorite;

  const FavoriteButtonUpdated({required this.isFavorite});

  @override
  List<Object> get props => [isFavorite];
}

class FavoriteButtonFailure extends FavoriteButtonState {}
