abstract class AuthRepository {
  Future<void> login(String user, String password);
  Future<void> signUp(String name, String email, String password);
  Future<bool> isAuthenticated();
  Future<void> signOut();
}
