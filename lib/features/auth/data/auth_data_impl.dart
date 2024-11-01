import '../domain/auth_repository.dart';
import 'remote/auth_remote_impl.dart';

class AuthDataImpl implements AuthRepository {
  final AuthRemoteImpl _authRemoteImpl;

  AuthDataImpl(this._authRemoteImpl);

  @override
  Future<bool> isAuthenticated() {
    return _authRemoteImpl.isAuthenticated();
  }

  @override
  Future<void> login(String user, String password) {
    return _authRemoteImpl.login(user, password);
  }

  @override
  Future<void> signOut() {
    return _authRemoteImpl.signOut();
  }

  @override
  Future<void> signUp(String name, String email, String password) {
    return _authRemoteImpl.signUp(name, email, password);
  }
}
