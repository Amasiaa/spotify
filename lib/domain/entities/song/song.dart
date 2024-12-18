// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SongEntity extends Equatable {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;

  const SongEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [title, artist, duration, releaseDate];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate.toDate(),
    };
  }

  factory SongEntity.fromMap(Map<String, dynamic> map) {
    return SongEntity(
      title: map['title'],
      artist: map['artist'],
      duration: map['duration'],
      releaseDate: map['releaseDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SongEntity.fromJson(String source) =>
      SongEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  SongEntity copyWith({
    String? title,
    String? artist,
    num? duration,
    Timestamp? releaseDate,
  }) {
    return SongEntity(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }
}
