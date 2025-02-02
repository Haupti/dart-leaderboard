import 'package:dart_score/components/html.dart';
import 'package:dart_score/domain/auth/authentication.dart';

Html emptyComponent() {
  return Html("");
}

extension AdminOnly on Html {
  String adminOnly(Authentication? auth) {
    if (auth?.level == Level.admin) {
      return render();
    }
    return "";
  }
}
