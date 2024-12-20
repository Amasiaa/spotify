import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repository/song/song_repo.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  final SongRepository songRepository;

  const AddOrRemoveFavoriteSongUseCase({
    required this.songRepository,
  });

  @override
  Future<Either> call({String? params}) {
    return songRepository.addOrRemoveFavorite(params!);
  }
}
