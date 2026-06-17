import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final String id;
  final String word;
  final String meaning;
  final String translation;
  final int createdAt;
  final int updatedAt;

  const Word({
    required this.id,
    required this.word,
    required this.meaning,
    required this.translation,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, word, meaning, translation];
}