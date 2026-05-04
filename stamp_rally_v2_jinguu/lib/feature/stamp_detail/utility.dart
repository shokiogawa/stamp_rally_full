import 'package:intl/intl.dart';

class StampDetailUtility {
  // 日本語の日時フォーマット
  static String formatJapaneseDate(DateTime date) {
    final japaneseEra = date.year - 2018; // 令和は2019年から
    const weekDayNames = ['日', '月', '火', '水', '木', '金', '土'];
    final formattedDate = DateFormat('MM月dd日').format(date);
    final weekDay = weekDayNames[date.weekday % 7];
    final time = DateFormat('HH:mm:ss').format(date);

    return '令和$japaneseEra年$formattedDate($weekDay) $time';
  }

  // 文字数に応じたフォントサイズを取得
  static double getFontSizeByLength(String text) {
    // 150文字が上限
    final double textSize = text.length > 100
        ? 10
        : text.length > 60
            ? 12
            : 15;
    return textSize;
  }
}
