import 'package:html/parser.dart';

class LanguageCheck {

  static String checkLanguage({
    required String? langCode,
    required String? enText,
    required String? bnText,
    required String? hiText,
    required String? arText,
  }) {
    String parseHtmlString(String htmlString) {
      final document = parse(htmlString);
      final parsedText = document.body?.text ?? '';

      // Replace multiple newlines and carriage returns with a single space
      return parsedText
          .replaceAll(RegExp(r'(\r\n|\r)'), ' ')  // Replace newlines with space
          .trim();  // Trim leading and trailing whitespace
    }


    if (langCode == 'en') {
      return parseHtmlString('$enText');
    } else if (langCode == 'bn') {
      return parseHtmlString('$bnText');
    } else if (langCode == 'hi') {
      return parseHtmlString('$hiText');
    } else if (langCode == 'ar') {
      return parseHtmlString('$arText');
    } else {
      return '';
    }
  }
}
