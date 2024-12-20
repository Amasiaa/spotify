import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song.dart';

part 'favorite_button_event.dart';
part 'favorite_button_state.dart';

class FavoriteButtonBloc
    extends Bloc<FavoriteButtonEvent, FavoriteButtonState> {
  final AddOrRemoveFavoriteSongUseCase addOrRemoveFavoriteSongUseCase;

  FavoriteButtonBloc({required this.addOrRemoveFavoriteSongUseCase})
      : super(FavoriteButtonInitial()) {
    on<FavoriteButtonUpdatedEvent>((event, emit) async {
      var result = await addOrRemoveFavoriteSongUseCase.call(
        params: event.songId,
      );

      result.fold(
        (l) => emit(FavoriteButtonFailure()),
        (isFavorite) => emit(
          FavoriteButtonUpdated(isFavorite: isFavorite),
        ),
      );
    });
  }
}
