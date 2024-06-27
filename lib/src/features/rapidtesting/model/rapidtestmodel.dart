// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class RapidModel {
  final String? id;
  final String? title;
  final String? body;
  final String? image;
  final List<String>? instructions;
  final String? video;

  RapidModel({
    this.id,
    this.title,
    this.body,
    this.image,
    this.instructions,
    this.video,
  });

  RapidModel copyWith({
    String? id,
    String? title,
    String? body,
    String? image,
    List<String>? instructions,
    String? video,
  }) {
    return RapidModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      image: image ?? this.image,
      instructions: instructions ?? this.instructions,
      video: video ?? this.video,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'image': image,
      'instructions': instructions,
      'video': video,
    };
  }

  factory RapidModel.fromMap(Map<String, dynamic> map) {
    return RapidModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      instructions: map['instructions'] != null
          ? map['instructions'] as List<String>
          : null,
      video: map['video'] != null ? map['video'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RapidModel.fromJson(String source) =>
      RapidModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RapidModel(id: $id, title: $title, body: $body, image: $image, instructions: $instructions, video: $video)';
  }

  @override
  bool operator ==(covariant RapidModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.body == body &&
        other.image == image &&
        listEquals(other.instructions, instructions) &&
        other.video == video;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        image.hashCode ^
        instructions.hashCode ^
        video.hashCode;
  }
}
