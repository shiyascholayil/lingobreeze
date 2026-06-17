import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/word_bloc.dart';
import '../bloc/word_event.dart';
import '../bloc/word_state.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/word_card.dart';
import 'add_word_page.dart';

class MyVocabularyPage extends StatefulWidget {
  const MyVocabularyPage({super.key});

  @override
  State<MyVocabularyPage> createState() => _MyVocabularyPageState();
}

class _MyVocabularyPageState extends State<MyVocabularyPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'My Vocabulary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => _refreshWords(),
            icon: const Icon(Icons.refresh),
            color: Colors.grey[700],
          ),
        ],
      ),
      body: BlocConsumer<WordBloc, WordState>(
        listener: (context, state) {
          if (state is WordSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('✓ "${state.word.word}" saved successfully!'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is WordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('⚠ ${state.message}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is WordLoading) {
            return const LoadingWidget();
          } else if (state is WordError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: _refreshWords,
            );
          } else if (state is WordLoaded) {
            if (state.words.isEmpty) {
              return EmptyStateWidget(
                onAddWord: _navigateToAddWord,
              );
            }
            return RefreshIndicator(
              onRefresh: _refreshWords,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: state.words.length,
                itemBuilder: (context, index) {
                  final word = state.words[index];
                  return WordCard(
                    word: word,
                    onDelete: () => _showDeleteConfirmation(word.id),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: BlocBuilder<WordBloc, WordState>(
        builder: (context, state) {
          if (state is WordLoaded && state.words.isNotEmpty) {
            return FloatingActionButton(
              onPressed: _navigateToAddWord,
              child: const Icon(Icons.add),
              backgroundColor: Colors.blue[600],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _navigateToAddWord() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<WordBloc>(),
          child: const AddWordPage(),
        ),
      ),
    );
    context.read<WordBloc>().add(RefreshWordsEvent());

  }

  Future<void> _refreshWords() async {
    context.read<WordBloc>().add(RefreshWordsEvent());
  }

  void _showDeleteConfirmation(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Word'),
        content: const Text('Are you sure you want to remove this word from your vocabulary?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              print("DELETE CLICKED: $id");
              Navigator.pop(context);


              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Word deleted successfully'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}