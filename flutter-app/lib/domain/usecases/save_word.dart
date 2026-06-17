
import '../entities/word.dart';
import '../repositories/word_repository.dart';

class SaveWordUseCase {
  final WordRepository repository;

  SaveWordUseCase({required this.repository});

  Future<Word> call(Word word) async {
    return await repository.saveWord(word);
  }
}