import 'en_US/en_us_translations.dart';
import 'id_ID/id_id_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en': enUs,
    'id': idId,
  };
}