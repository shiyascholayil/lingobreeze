import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/error_handler.dart';
import '../../domain/entities/word.dart';
import '../../domain/usecases/get_words.dart';
import '../../domain/usecases/save_word.dart';
import 'word_event.dart';
import 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final GetWordsUseCase getWordsUseCase;
  final SaveWordUseCase saveWordUseCase;

  WordBloc({
    required this.getWordsUseCase,
    required this.saveWordUseCase,
  }) : super(WordInitial()) {
    on<LoadWordsEvent>((event, emit) async {
      print('🔵 LoadWordsEvent triggered');
      emit(WordLoading());
      try {
        final words = await getWordsUseCase();
        print('✅ Loaded ${words.length} words');
        emit(WordLoaded(words: words));
      } catch (e) {
        print('❌ Error: $e');
        emit(WordError(message: ErrorHandler.getErrorMessage(e)));
      }
    });

    on<AddWordEvent>((event, emit) async {
      debugPrint("hi");
      debugPrint('🔵 AddWordEvent triggered for: ${event.word.word}');

      // Save current state to revert if needed
      final currentState = state;

      try {
        // Show loading
        emit(WordLoading());

        // Save the word
        final newWord = await saveWordUseCase(event.word);

        List<Word> currentWords = [];
        if (currentState is WordLoaded) {
          currentWords = currentState.words;
        }

        // Create updated list
        final updatedWords = [newWord, ...currentWords];


        emit(WordSaved(word: newWord));
        emit(WordLoaded(words: updatedWords));


      } catch (e) {

        final errorMessage = ErrorHandler.getErrorMessage(e);


        // Emit error
        emit(WordError(message: errorMessage));


        // Revert to previous state after a delay (so error is shown)
        Future.delayed(const Duration(milliseconds: 500), () {
          if (currentState is WordLoaded) {
            emit(currentState);
          } else {
            emit(WordInitial());
          }
        });
      }
    });

    on<RefreshWordsEvent>((event, emit) async {

      if (state is WordLoaded) {
        emit(WordLoading());
        try {
          final words = await getWordsUseCase();

          emit(WordLoaded(words: words));
        } catch (e) {

          emit(WordError(message: ErrorHandler.getErrorMessage(e)));
        }
      }
    });

  }
}