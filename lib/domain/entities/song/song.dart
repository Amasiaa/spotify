// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SongEntity extends Equatable {
  final String songId;
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final bool isFavorite;

  const SongEntity({
    required this.songId,
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [
        title,
        artist,
        duration,
        releaseDate,
        isFavorite,
        songId,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'songId': songId,
      'title': title,
      'artist': artist,
      'duration': duration,
      'isFavorite': isFavorite,
      'releaseDate': releaseDate.toDate(),
    };
  }

  factory SongEntity.fromMap(Map<String, dynamic> map) {
    return SongEntity(
      songId: map['songId'],
      title: map['title'],
      artist: map['artist'],
      duration: map['duration'],
      isFavorite: map['isFavorite'],
      releaseDate: map['releaseDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SongEntity.fromJson(String source) =>
      SongEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  SongEntity copyWith({
    String? songId,
    String? title,
    String? artist,
    num? duration,
    bool? isFavorite,
    Timestamp? releaseDate,
  }) {
    return SongEntity(
      songId: songId ?? this.songId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool get stringify => true;
}
