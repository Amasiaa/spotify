import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/domain/repository/auth/auth_repo.dart';

class SigninUseCase implements UseCase<Either, SigninUserReq> {
  final AuthUserRepository authRepository;

  const SigninUseCase({required this.authRepository});

  @override
  Future<Either> call({SigninUserReq? params}) async {
    return authRepository.signIn(params!);
  }
}
