import 'dart:convert';
import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../models/word_model.dart';

class WordRemoteDataSource {
  final Dio dio;

  WordRemoteDataSource({required this.dio});

  Future<List<WordModel>> getWords() async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.wordsEndpoint}',
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final wordsList = data['data'] as List;
        return wordsList.map((json) => WordModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load words');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<WordModel> saveWord(WordModel word) async {
    try {
      final response = await dio.post(
        '${AppConstants.baseUrl}${AppConstants.wordsEndpoint}',
        data: jsonEncode(word.toJson()),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;
        return WordModel.fromJson(data['data']);
      } else {
        throw Exception('Failed to save word');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteWord(String id) async {
    try {
      await dio.delete(
        '${AppConstants.baseUrl}${AppConstants.wordsEndpoint}/$id',
      );
    } catch (e) {
      rethrow;
    }
  }
}