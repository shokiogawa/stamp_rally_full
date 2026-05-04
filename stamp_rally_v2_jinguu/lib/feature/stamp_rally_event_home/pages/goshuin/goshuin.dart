import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stamp_rally_v2_fvm/core/provider/place/fetch_place_and_stamped_provider.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';

/// 御朱印帳テーマ
class GoshuinTheme {
  // メインカラー
  static const Color primaryColor = Color(0xFFC39143);
  
  // 背景色
  static const Color backgroundColor = Color(0xFFF4F1E8);
  static const Color cardBackgroundColor = Color(0xFFFFFDF7);
  
  // テキスト色
  static const Color textPrimaryColor = Color(0xFF8B4513);
  static const Color textSecondaryColor = Color(0xFF8B4513);
  
  // ボーダー色
  static const Color borderColor = Color(0xFF8B4513);
  
  // スタンプ色
  static const Color stampColor = Color(0xFFC73A2A);
  
  // 影の色
  static const Color shadowColor = Color(0x15000000);
  
  // 透明度付きの色
  static Color get primaryColorWithOpacity10 => primaryColor.withOpacity(0.1);
  static Color get primaryColorWithOpacity20 => primaryColor.withOpacity(0.2);
  static Color get primaryColorWithOpacity40 => primaryColor.withOpacity(0.4);
  static Color get primaryColorWithOpacity70 => primaryColor.withOpacity(0.7);
  static Color get textPrimaryColorWithOpacity70 => textPrimaryColor.withOpacity(0.7);
}

class GoshuinBookScreen extends HookConsumerWidget {
  const GoshuinBookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = PageController(viewportFraction: 1.0);
    final currentPage = useState(0);
    
    // 選択されたイベントを取得
    final selectedEvent = ref.watch(selectedEventProvider);
    final eventCode = selectedEvent?.eventCode ?? '';
    
    // 場所データを取得
    final placesAsync = ref.watch(fetchPlaceAndStampedProvider(eventCode));

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('スタンプ帳'),
      //   centerTitle: true,
      //   backgroundColor: const Color(0xFF8B4513),
      //   foregroundColor: Colors.white,
      //   elevation: 0,
      // ),
      backgroundColor: GoshuinTheme.backgroundColor,
      body: SafeArea(
        child: placesAsync.when(
          data: (places) {
            if (places.isEmpty) {
              return const Center(
                child: Text('スポットが見つかりません'),
              );
            }

            return Column(
              children: [
                // 御朱印帳本体
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: PageView.builder(
                      controller: controller,
                      padEnds: false,
                      itemCount: places.length,
                      onPageChanged: (page) {
                        currentPage.value = page;
                      },
                      itemBuilder: (context, page) {
                        final place = places[page];
                        
                        return Center(
                          child: AspectRatio(
                            aspectRatio: 0.8,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: GoshuinTheme.shadowColor,
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: GoshuinPage(
                                  place: place,
                                  pageNumber: page + 1,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // ページインジケーター
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: currentPage.value == 0
                            ? null
                            : () {
                                controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                        icon: Icon(Icons.chevron_left, size: 20, color: GoshuinTheme.primaryColor),
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: GoshuinTheme.primaryColorWithOpacity10,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${currentPage.value + 1} / ${places.length}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: GoshuinTheme.primaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: currentPage.value >= places.length - 1
                            ? null
                            : () {
                                controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                        icon: Icon(Icons.chevron_right, size: 20, color: GoshuinTheme.primaryColor),
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          loading: () => Center(
            child: CircularProgressIndicator(
              color: GoshuinTheme.primaryColor,
            ),
          ),
          error: (error, stack) => Center(
            child: Text(
              'エラーが発生しました: $error',
              style: TextStyle(color: GoshuinTheme.textPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }
}

/// 御朱印ページ（片面）
class GoshuinPage extends StatelessWidget {
  const GoshuinPage({
    super.key,
    required this.place,
    required this.pageNumber,
  });

  final PlaceModel place;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WashiBackgroundPainter(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        child: Column(
          children: [
            // ページ番号
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: GoshuinTheme.primaryColorWithOpacity10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '第$pageNumber頁',
                  style: TextStyle(
                    fontSize: 12,
                    color: GoshuinTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 上段のスタンプエリア
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GoshuinTheme.primaryColorWithOpacity20,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomPaint(
                  painter: GoshuinHankoPainter(
                    stamped: place.isStamped,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 下段の場所情報エリア
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: GoshuinTheme.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: GoshuinTheme.primaryColorWithOpacity40,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: GoshuinTheme.shadowColor,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // 場所の画像
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: GoshuinTheme.primaryColorWithOpacity20,
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: place.shrineImage.isNotEmpty
                            ? Image.network(
                                place.shrineImage,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFFF0F0F0),
                                    child: Icon(
                                      Icons.image,
                                      color: GoshuinTheme.primaryColor,
                                      size: 40,
                                    ),
                                  );
                                },
                              )
                            : Container(
                                color: const Color(0xFFF0F0F0),
                                child: Icon(
                                  Icons.image,
                                  color: GoshuinTheme.primaryColor,
                                  size: 40,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // 場所の名前
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            place.name,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: GoshuinTheme.textPrimaryColor,
                              letterSpacing: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            place.areaName,
                            style: TextStyle(
                              fontSize: 10,
                              color: GoshuinTheme.textPrimaryColorWithOpacity70,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Row(
                          //   children: [
                          //     Icon(
                          //       Icons.calendar_today,
                          //       size: 10,
                          //       color: const Color(0xFF8B4513).withOpacity(0.7),
                          //     ),
                          //     const SizedBox(width: 6),
                          //     Text(
                          //       place.isStamped ? '押印済み' : '未押印',
                          //       style: TextStyle(
                          //         fontSize: 10,
                          //         color:
                          //             const Color(0xFF8B4513).withOpacity(0.7),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 和紙風背景ペインタ
class WashiBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // ベース色
    final bg = Paint()..color = GoshuinTheme.cardBackgroundColor;
    final rect = Offset.zero & size;
    canvas.drawRect(rect, bg);

    // グラデーション陰影
    final shader = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0x00FFFFFF), Color(0x11000000)],
    ).createShader(rect);
    canvas.drawRect(rect, Paint()..shader = shader);

    // 和紙テクスチャ（薄い点）
    final texturePaint = Paint()
      ..color = const Color(0x08000000)
      ..style = PaintingStyle.fill;

    const spacing = 8.0;
    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        if (math.Random().nextDouble() < 0.3) {
          canvas.drawCircle(Offset(x, y), 0.5, texturePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 御朱印ペインタ
class GoshuinHankoPainter extends CustomPainter {
  GoshuinHankoPainter({required this.stamped});
  final bool stamped;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radius = math.min(size.width, size.height) * 0.35;

    if (!stamped) {
      // 未押印時のガイド
      final guidePaint = Paint()
        ..color = const Color(0x33000000)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawCircle(center, radius, guidePaint);

      // ガイドテキスト
      final textPainter = TextPainter(
        text: TextSpan(
          text: 'スタンプ',
          style: TextStyle(
            color: GoshuinTheme.textPrimaryColorWithOpacity70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          center.dx - textPainter.width / 2,
          center.dy - textPainter.height / 2,
        ),
      );
      return;
    }

    // 押印済みの朱印
    // 朱色の円
    final redPaint = Paint()..color = GoshuinTheme.stampColor;
    canvas.drawCircle(center, radius, redPaint);

    // 擦れ表現
    final erodePaint = Paint()
      ..color = const Color(0x22FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.08;
    canvas.drawCircle(center, radius * 0.85, erodePaint);

    // 御朱印の文字（簡易版）
    final textPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.15
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // 円形の文字パターン
    final path = Path();
    final innerRadius = radius * 0.6;

    // 外円
    path.addOval(Rect.fromCircle(center: center, radius: innerRadius));

    // 内側の装飾
    for (int i = 0; i < 8; i++) {
      final angle = (math.pi / 4) * i;
      final startPoint = Offset(
        center.dx + innerRadius * 0.3 * math.cos(angle),
        center.dy + innerRadius * 0.3 * math.sin(angle),
      );
      final endPoint = Offset(
        center.dx + innerRadius * 0.8 * math.cos(angle),
        center.dy + innerRadius * 0.8 * math.sin(angle),
      );
      path.moveTo(startPoint.dx, startPoint.dy);
      path.lineTo(endPoint.dx, endPoint.dy);
    }

    canvas.drawPath(path, textPaint);
  }

  @override
  bool shouldRepaint(covariant GoshuinHankoPainter oldDelegate) =>
      stamped != oldDelegate.stamped;
}

/// Dash用の簡易PathEffect（SDKに依存しない簡易実装）
extension PathEffect on Paint {
  set pathEffect(List<double> intervals) {
    // ここでは簡易実装: 実際の破線描画は上で使っていないためダミー。
    // （flutter 3.22+ の Canvas.drawPath では DashPathEffect が無い）
    // ダッシュ描画が必要なら、"dashed_path" パッケージ等の利用を検討してください。
  }
}
