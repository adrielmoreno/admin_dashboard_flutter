import '../../domain/auth_repository.dart';
import 'remote/auth_remote_impl.dart';

class AuthDataImpl implements AuthRepository {
  final AuthRemoteImpl _authRemoteImpl;

  AuthDataImpl(this._authRemoteImpl);

  @override
  Future<bool> isAuthenticated() {
    return _authRemoteImpl.isAuthenticated();
  }

  @override
  Future<bool> login(String user, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    return _authRemoteImpl.signOut();
  }

  @override
  Future<String?> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
