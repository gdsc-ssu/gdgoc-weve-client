/// 토큰 저장 및 관리를 위한 인터페이스
///
/// 이 인터페이스는 토큰 관련 작업의 일관성을 보장하고
/// 다양한 구현체(보안 저장소, 메모리 저장소 등)를 지원합니다.
abstract class TokenStorage {
  /// 토큰 저장
  Future<void> saveToken(String token);

  /// 저장된 토큰 조회
  Future<String?> getToken();

  /// 토큰 삭제
  Future<void> deleteToken();

  /// 사용자 타입 저장 (주니어/시니어)
  Future<void> saveUserType(String userType);

  /// 사용자 타입 조회
  Future<String?> getUserType();

  /// 모든 저장된 데이터 삭제
  Future<void> clearAll();
}
