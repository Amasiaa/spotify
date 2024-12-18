import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      //debugPrint('DATA...: ${data.docs.length}');

      for (var element in data.docs) {
        var songModel = SongModel.fromMap(element.data());
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } on FirebaseException catch (e) {
      return Left('Firebase error occured ${e.message!}');
    } catch (e) {
      return const Left('An error occured, please try again...');
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .get();

      //debugPrint('DATA...: ${data.docs.length}');

      for (var element in data.docs) {
        var songModel = SongModel.fromMap(element.data());
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } on FirebaseException catch (e) {
      return Left('Firebase error occured ${e.message!}');
    } catch (e) {
      return const Left('An error occured, please try again...');
    }
  }
}
