import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repository/song/song_repo.dart';

class IsFavoriteSongUseCase implements UseCase<bool, String> {
  final SongRepository songRepository;

  const IsFavoriteSongUseCase({
    required this.songRepository,
  });

  @override
  Future<bool> call({String? params}) {
    return songRepository.isFavoriteSong(params!);
  }
}
