

import '../entities/word.dart';
import '../repositories/word_repository.dart';

class GetWordsUseCase {
  final WordRepository repository;

  GetWordsUseCase({required this.repository});

  Future<List<Word>> call() async {
    return await repository.getWords();
  }
}