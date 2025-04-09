import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final int score;
  final String text;
  final DocumentReference? self;

  const Review({
    required this.score,
    required this.text,
    this.self,
  });

  Review copyWith({
    int? score,
    String? text,
    DocumentReference? self,
  }) {
    return Review(
      score: score ?? this.score,
      text: text ?? this.text,
      self: self ?? this.self,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'score': score,
      'text': text,
    };
  }

  factory Review.fromMap(DocumentReference self, Map<String, dynamic> map) {
    return Review(
      score: map['score'] as int,
      text: map['text'] as String,
      self: self,
    );
  }

  @override
  String toString() => 'Review(score: $score, text: $text, self: $self)';
}
