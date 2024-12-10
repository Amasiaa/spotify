import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repo.dart';
import 'package:spotify/domain/usecases/auth/signin_usecase.dart';
import 'package:spotify/domain/usecases/auth/signup_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  sl.registerSingleton<AuthUserRepository>(
    AuthRepositoryImpl(authFirebaseService: sl()),
  );

  sl.registerSingleton<SignupUseCase>(
    SignupUseCase(authRepository: sl()),
  );

  sl.registerSingleton<SigninUseCase>(
    SigninUseCase(authRepository: sl()),
  );
}
