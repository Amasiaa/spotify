import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/get_play_list_usecase.dart';

part 'play_list_event.dart';
part 'play_list_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  final GetPlayListUseCase getPlayListUseCase;

  PlayListBloc({required this.getPlayListUseCase}) : super(PlayListLoading()) {
    on<GetPlayListEvent>(_onGetPlayList);
  }

  FutureOr<void> _onGetPlayList(
    GetPlayListEvent event,
    Emitter<PlayListState> emit,
  ) async {
    emit(PlayListLoading());
    try {
      final result = await getPlayListUseCase.call();

      result.fold(
        (error) => emit(PlayListLoadFailure()),
        (songs) => emit(PlayListLoaded(songs: songs)),
      );
    } catch (e) {
      emit(PlayListLoadFailure());
    }
  }
}
