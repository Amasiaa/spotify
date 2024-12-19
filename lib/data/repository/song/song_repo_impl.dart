import 'package:dartz/dartz.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repository/song/song_repo.dart';

class SongRepositoryImpl extends SongRepository {
  final SongFirebaseService songFirebaseService;

  SongRepositoryImpl({required this.songFirebaseService});

  @override
  Future<Either> getNewsSongs() async {
    return await songFirebaseService.getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await songFirebaseService.getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavorite() async {
    return await songFirebaseService.addOrRemoveFavorite();
  }
}
