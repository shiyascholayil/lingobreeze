
import '../../domain/entities/word.dart';

class WordModel {
  final String id;
  final String word;
  final String meaning;
  final String translation;
  final int createdAt;
  final int updatedAt;

  WordModel({
    required this.id,
    required this.word,
    required this.meaning,
    required this.translation,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json['id'] ?? '',
      word: json['word'] ?? '',
      meaning: json['meaning'] ?? '',
      translation: json['translation'] ?? '',
      createdAt: json['createdAt'] ?? DateTime.now().millisecondsSinceEpoch,
      updatedAt: json['updatedAt'] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'meaning': meaning,
      'translation': translation,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Word toEntity() {
    return Word(
      id: id,
      word: word,
      meaning: meaning,
      translation: translation,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory WordModel.fromEntity(Word entity) {
    return WordModel(
      id: entity.id,
      word: entity.word,
      meaning: entity.meaning,
      translation: entity.translation,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}