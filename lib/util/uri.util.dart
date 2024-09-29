class UriUtil {
  static String getBaseUrl() {
    final uri = Uri.base;
    return "${uri.scheme}://${uri.host}:${uri.port == 80 || uri.port == 443 || uri.port == 0 ? '' : uri.port}";
  }
}
