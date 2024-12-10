import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repo.dart';

class AuthRepositoryImpl extends AuthUserRepository {
  final AuthFirebaseService authFirebaseService;

  AuthRepositoryImpl({required this.authFirebaseService});
  @override
  Future<Either> signIn(SigninUserReq signinUserReq) async {
    return await authFirebaseService.signIn(signinUserReq);
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    return await authFirebaseService.signUp(createUserReq);
  }
}
