
import '../entities/word.dart';

abstract class WordRepository {
  Future<List<Word>> getWords();
  Future<Word> saveWord(Word word);
  Future<void> deleteWord(String id);
}