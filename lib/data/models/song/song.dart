import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entities/song/song.dart';

class SongModel extends SongEntity {
  const SongModel({
    required super.title,
    required super.artist,
    required super.duration,
    required super.releaseDate,
  });

  SongModel.fromMap(Map<String, dynamic> map)
      : this(
          title: map['title'],
          artist: map['artist'],
          duration: map['duration'],
          releaseDate: map['releaseDate'],
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate,
    };
  }

  SongEntity toEntity() {
    return SongEntity(
      title: title,
      artist: artist,
      duration: duration,
      releaseDate: releaseDate,
    );
  }

  @override
  SongModel copyWith({
    String? title,
    String? artist,
    num? duration,
    Timestamp? releaseDate,
  }) {
    return SongModel(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }
}
