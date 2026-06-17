import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


import '../data/datasources/word_remote_datasource.dart';
import '../data/repositories/word_repository_impl.dart';
import '../domain/repositories/word_repository.dart';
import '../domain/usecases/get_words.dart';
import '../domain/usecases/save_word.dart';
import '../presentation/bloc/word_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Data Sources
  getIt.registerLazySingleton<WordRemoteDataSource>(
        () => WordRemoteDataSource(dio: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<WordRepository>(
        () => WordRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetWordsUseCase>(
        () => GetWordsUseCase(repository: getIt()),
  );

  getIt.registerLazySingleton<SaveWordUseCase>(
        () => SaveWordUseCase(repository: getIt()),
  );


  // BLoC
  getIt.registerFactory<WordBloc>(
        () => WordBloc(
      getWordsUseCase: getIt(),
      saveWordUseCase: getIt(),

    ),
  );
}