import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/common/blocs/favorite_button/favorite_button_bloc.dart';
import 'package:spotify/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify/data/repository/song/song_repo_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repo.dart';
import 'package:spotify/domain/repository/song/song_repo.dart';
import 'package:spotify/domain/usecases/auth/signin_usecase.dart';
import 'package:spotify/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify/domain/usecases/song/get_news_songs_usecase.dart';
import 'package:spotify/domain/usecases/song/get_play_list_usecase.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';
import 'package:spotify/presentation/home/bloc/play_list_bloc.dart';
import 'package:spotify/presentation/home/bloc/song_bloc.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // *************** SERVICES ****************
  sl.registerLazySingleton<AuthFirebaseService>(
    () => AuthFirebaseServiceImpl(),
  );

  sl.registerLazySingleton<SongFirebaseService>(
    () => SongFirebaseServiceImpl(),
  );

  // ****************** REPOSITORIES *************

  sl.registerLazySingleton<AuthUserRepository>(
    () => AuthRepositoryImpl(authFirebaseService: sl()),
  );

  sl.registerLazySingleton<SongRepository>(
    () => SongRepositoryImpl(songFirebaseService: sl()),
  );

  // ************** USECASES *******************
  sl.registerLazySingleton<SignupUseCase>(
    () => SignupUseCase(authRepository: sl()),
  );

  sl.registerLazySingleton<SigninUseCase>(
    () => SigninUseCase(authRepository: sl()),
  );

  sl.registerLazySingleton<GetNewsSongsUseCase>(
    () => GetNewsSongsUseCase(songRepository: sl()),
  );

  sl.registerLazySingleton<GetPlayListUseCase>(
    () => GetPlayListUseCase(songRepository: sl()),
  );

  sl.registerLazySingleton<AddOrRemoveFavoriteSongUseCase>(
    () => AddOrRemoveFavoriteSongUseCase(songRepository: sl()),
  );

  sl.registerLazySingleton<IsFavoriteSongUseCase>(
    () => IsFavoriteSongUseCase(songRepository: sl()),
  );

  // ************** BLOCS **************
  sl.registerFactory(
    () => SongBloc(
      getNewsSongsUseCase: sl<GetNewsSongsUseCase>(),
    ),
  );

  sl.registerFactory(
    () => PlayListBloc(
      getPlayListUseCase: sl<GetPlayListUseCase>(),
    ),
  );

  sl.registerFactory(
    () => SongPlayerBloc(audioPlayer: sl<AudioPlayer>()),
  );

  sl.registerFactory(
    () => FavoriteButtonBloc(
      addOrRemoveFavoriteSongUseCase: sl<AddOrRemoveFavoriteSongUseCase>(),
    ),
  );
}
