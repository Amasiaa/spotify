import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';
import 'package:spotify/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavorite(String songId);
  Future<bool> isFavoriteSong(String songId);
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
        //debugPrint('DATA_MODEL...: ${songModel.toString()}');
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
          params: element.reference.id,
        );
        //debugPrint("ISFAVORITE: $isFavorite");
        songModel.copyWith(
          isFavorite: isFavorite,
          songId: element.reference.id,
        );
        songs.add(songModel.toEntity());
        //debugPrint('DATA...: ${songs.toString()}');
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
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
          params: element.reference.id,
        );
        songModel.copyWith(
          isFavorite: isFavorite,
          songId: element.reference.id,
        );
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
  Future<Either> addOrRemoveFavorite(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      late bool isFavorite;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favoriteSnapshot = await firestore
          .collection('Users')
          .doc(uid)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSnapshot.docs.isNotEmpty) {
        await favoriteSnapshot.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firestore
            .collection('Users')
            .doc(uid)
            .collection('Favorites')
            .add({
          'songId': songId,
          'addedDate': Timestamp.now(),
        });
        isFavorite = true;
      }

      return Right(isFavorite);
    } catch (e) {
      return const Left('An error occured, please try again...');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favoriteSnapshot = await firestore
          .collection('Users')
          .doc(uid)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
