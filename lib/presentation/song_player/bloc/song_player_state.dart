part of 'song_player_bloc.dart';

enum SongStatus { playing, pause, stopped }

class SongPlayerState extends Equatable {
  final bool isPlaying;
  final double progress;
  final bool isFavourite;
  final String? fileUrl;
  final SongStatus status;

  const SongPlayerState({
    this.isPlaying = true,
    this.progress = 0.0,
    this.isFavourite = false,
    this.fileUrl,
    this.status = SongStatus.stopped,
  });

  SongPlayerState copyWith(
      {bool? isPlaying,
      double? progress,
      bool? isFavourite,
      SongStatus? status,
      String? fileUrl}) {
    return SongPlayerState(
      isFavourite: isFavourite ?? this.isFavourite,
      isPlaying: isPlaying ?? this.isPlaying,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }

  @override
  List<Object> get props => [
        isPlaying,
        progress,
        isFavourite,
        fileUrl ?? '',
        status,
      ];
}

final class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {}

class SongPlayerFailure extends SongPlayerState {}
