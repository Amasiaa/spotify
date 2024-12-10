import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/repository/auth/auth_repo.dart';

class SignupUseCase implements UseCase<Either, CreateUserReq> {
  final AuthUserRepository authRepository;

  const SignupUseCase({required this.authRepository});

  @override
  Future<Either> call({CreateUserReq? params}) async {
    return authRepository.signUp(params!);
  }
}
