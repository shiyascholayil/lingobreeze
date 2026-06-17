import 'package:equatable/equatable.dart';

import '../../domain/entities/word.dart';

abstract class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object?> get props => [];
}

class LoadWordsEvent extends WordEvent {}

class AddWordEvent extends WordEvent {
  final Word word;

  const AddWordEvent({required this.word});

  @override
  List<Object?> get props => [word];
}

class DeleteWordEvent extends WordEvent {
  final String id;

  const DeleteWordEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class RefreshWordsEvent extends WordEvent {}