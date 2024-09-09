abstract class AuthRepository {
  Future<bool> login(String user, String password);
  Future<String?> signUp(String email, String password);
  Future<bool> isAuthenticated();
  Future<void> signOut();
}
