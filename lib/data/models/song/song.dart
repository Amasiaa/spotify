import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entities/song/song.dart';

class SongModel extends SongEntity {
  const SongModel({
    required super.title,
    required super.artist,
    required super.duration,
    required super.releaseDate,
    required super.isFavorite,
    required super.songId,
  });

  SongModel.fromMap(Map<String, dynamic> map)
      : this(
          songId: map['songId'],
          title: map['title'],
          artist: map['artist'],
          duration: map['duration'],
          releaseDate: map['releaseDate'],
          isFavorite: map['isFavorite'],
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'songId': songId,
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate,
      'isFavorite': isFavorite,
    };
  }

  SongEntity toEntity() {
    return SongEntity(
      songId: songId,
      title: title,
      artist: artist,
      duration: duration,
      releaseDate: releaseDate,
      isFavorite: isFavorite,
    );
  }

  @override
  SongModel copyWith({
    String? songId,
    String? title,
    String? artist,
    num? duration,
    bool? isFavorite,
    Timestamp? releaseDate,
  }) {
    return SongModel(
      songId: songId ?? this.songId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
