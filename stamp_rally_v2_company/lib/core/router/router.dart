import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_rally_event_detail/stamp_rally_event_detail.dart';
import 'package:stamp_rally_v2_fvm/feature/login/pages/login_signin_page.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/qr_code_scanner.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/stamp_detail.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/stamp_rally_event_home.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_list/stamp_rally_event_list.dart';
import 'package:stamp_rally_v2_fvm/feature/startup/pages/start_up_page.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    routes: [...$appRoutes],
  );
}

@TypedGoRoute<StartUpPageRoute>(
  path: '/',
  routes: [
    // スタンプイベント一覧ページ
    TypedGoRoute<StampRallyEventListPageRoute>(
        path: 'stamp_rally_event_list_page',
        name: 'stamp_rally_event_list_page',
        routes: [
          TypedGoRoute<StampRallyEventHomePageRoute>(
              path: 'stamp_rally_event_home/:eventCode',
              name: 'stamp_rally_event_home',
              routes: []),
          // イベント詳細
          TypedGoRoute<StampRallyEventDetailPageRoute>(
            path: 'stamp_rally_event_detail',
            name: 'stamp_rally_event_detail',
          ),

          // スタンプ一覧
          // TypedGoRoute<StampListPageRoute>(
          //     path: 'stamp_list_page/:eventCode',
          //     name: 'stamp_list_page',
          //     routes: [

          //         ]
          //       ),
          // スタンプ詳細
          TypedGoRoute<StampDetailRoute>(
              path: 'stamp_detail/:placeId',
              name: 'stamp_detail',
              routes: [
                // QRコード画面
                TypedGoRoute<QrCodeScannerScreenRoute>(
                  path: 'qr_code_scanner',
                  name: 'qr_code_scanner',
                )
              ]),
        ]),

    // ログイン & サインイン
    TypedGoRoute<LoginSignInPageRoute>(
      path: 'login_sign_in',
      name: 'login_sign_in',
    ),

    // ライセンス情報
    // TypedGoRoute<LicensePageRoute>(
    //   path: 'license',
    //   name: 'license',
    // ),
  ],
)
// https://techblog.glpgs.com/entry/2023/05/11/150306

// スタートアップページ
class StartUpPageRoute extends GoRouteData {
  const StartUpPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const StartUpPage();
}

class StampDetailRoute extends GoRouteData {
  const StampDetailRoute(this.placeId);

  final String placeId;

  @override
  Widget build(BuildContext context, GoRouterState state) => StampDetailScreen(
        placeId: placeId,
      );
}

class QrCodeScannerScreenRoute extends GoRouteData {
  const QrCodeScannerScreenRoute({required this.placeId});

  final String placeId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      QrCodeScannerScreen(placeId: placeId);
}

// ログイン & サインイン
class LoginSignInPageRoute extends GoRouteData {
  const LoginSignInPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginSignInPage();
}

// ホーム
class StampRallyEventDetailPageRoute extends GoRouteData {
  const StampRallyEventDetailPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const StampRallyEventDetailPage();
}

// スタンプラリーイベント
class StampRallyEventListPageRoute extends GoRouteData {
  const StampRallyEventListPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const StampRallyEventListPage();
}

// スタンプ一覧ページ
// class StampListPageRoute extends GoRouteData {
//   StampListPageRoute(this.eventCode);

//   final String eventCode;

//   @override
//   Widget build(BuildContext context, GoRouterState state) =>
//       StampListPage(eventCode: eventCode);
// }

// スタンプイベント詳細 & スタンプ一覧ページ
class StampRallyEventHomePageRoute extends GoRouteData {
  StampRallyEventHomePageRoute(this.eventCode);

  final String eventCode;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      StampRallyEventHomePage(eventCode: eventCode);
}

// ライセンス情報ページ
// class LicensePageRoute extends GoRouteData {
//   const LicensePageRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) =>
//       const Li();
// }
