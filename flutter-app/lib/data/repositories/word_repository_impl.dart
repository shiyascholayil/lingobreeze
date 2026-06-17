
import '../../domain/entities/word.dart';
import '../../domain/repositories/word_repository.dart';
import '../datasources/word_remote_datasource.dart';
import '../models/word_model.dart';

class WordRepositoryImpl implements WordRepository {
  final WordRemoteDataSource remoteDataSource;

  WordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Word>> getWords() async {
    final wordModels = await remoteDataSource.getWords();
    return wordModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Word> saveWord(Word word) async {
    final wordModel = WordModel.fromEntity(word);
    final savedModel = await remoteDataSource.saveWord(wordModel);
    return savedModel.toEntity();
  }

  @override
  Future<void> deleteWord(String id) async {
    await remoteDataSource.deleteWord(id);
  }
}