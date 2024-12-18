import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repository/song/song_repo.dart';

class GetNewsSongsUseCase implements UseCase<Either, dynamic> {
  final SongRepository songRepository;

  const GetNewsSongsUseCase({required this.songRepository});

  @override
  Future<Either> call({params}) async {
    return songRepository.getNewsSongs();
  }
}
