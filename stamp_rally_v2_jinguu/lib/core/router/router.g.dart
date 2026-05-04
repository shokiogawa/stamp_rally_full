// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $startUpPageRoute,
    ];

RouteBase get $startUpPageRoute => GoRouteData.$route(
      path: '/',
      factory: $StartUpPageRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'stamp_rally_event_list_page',
          name: 'stamp_rally_event_list_page',
          factory: $StampRallyEventListPageRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'stamp_rally_event_home/:eventCode',
              name: 'stamp_rally_event_home',
              factory: $StampRallyEventHomePageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'stamp_rally_event_detail',
              name: 'stamp_rally_event_detail',
              factory: $StampRallyEventDetailPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'stamp_detail/:placeId',
              name: 'stamp_detail',
              factory: $StampDetailRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'qr_code_scanner',
                  name: 'qr_code_scanner',
                  factory: $QrCodeScannerScreenRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'login_sign_in',
          name: 'login_sign_in',
          factory: $LoginSignInPageRouteExtension._fromState,
        ),
      ],
    );

extension $StartUpPageRouteExtension on StartUpPageRoute {
  static StartUpPageRoute _fromState(GoRouterState state) =>
      const StartUpPageRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StampRallyEventListPageRouteExtension
    on StampRallyEventListPageRoute {
  static StampRallyEventListPageRoute _fromState(GoRouterState state) =>
      const StampRallyEventListPageRoute();

  String get location => GoRouteData.$location(
        '/stamp_rally_event_list_page',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StampRallyEventHomePageRouteExtension
    on StampRallyEventHomePageRoute {
  static StampRallyEventHomePageRoute _fromState(GoRouterState state) =>
      StampRallyEventHomePageRoute(
        state.pathParameters['eventCode']!,
      );

  String get location => GoRouteData.$location(
        '/stamp_rally_event_list_page/stamp_rally_event_home/${Uri.encodeComponent(eventCode)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StampRallyEventDetailPageRouteExtension
    on StampRallyEventDetailPageRoute {
  static StampRallyEventDetailPageRoute _fromState(GoRouterState state) =>
      const StampRallyEventDetailPageRoute();

  String get location => GoRouteData.$location(
        '/stamp_rally_event_list_page/stamp_rally_event_detail',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StampDetailRouteExtension on StampDetailRoute {
  static StampDetailRoute _fromState(GoRouterState state) => StampDetailRoute(
        state.pathParameters['placeId']!,
      );

  String get location => GoRouteData.$location(
        '/stamp_rally_event_list_page/stamp_detail/${Uri.encodeComponent(placeId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $QrCodeScannerScreenRouteExtension on QrCodeScannerScreenRoute {
  static QrCodeScannerScreenRoute _fromState(GoRouterState state) =>
      QrCodeScannerScreenRoute(
        placeId: state.pathParameters['placeId']!,
      );

  String get location => GoRouteData.$location(
        '/stamp_rally_event_list_page/stamp_detail/${Uri.encodeComponent(placeId)}/qr_code_scanner',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LoginSignInPageRouteExtension on LoginSignInPageRoute {
  static LoginSignInPageRoute _fromState(GoRouterState state) =>
      const LoginSignInPageRoute();

  String get location => GoRouteData.$location(
        '/login_sign_in',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goRouterHash() => r'1f592e5459f484ca4dcbfbed8d584c3d2a565b60';

/// See also [goRouter].
@ProviderFor(goRouter)
final goRouterProvider = AutoDisposeProvider<GoRouter>.internal(
  goRouter,
  name: r'goRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GoRouterRef = AutoDisposeProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
