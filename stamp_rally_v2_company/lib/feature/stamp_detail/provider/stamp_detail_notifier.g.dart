// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stampDetailNotifierHash() =>
    r'a1e3e89ad1bc764156157524d4bdc47ce9518866';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$StampDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<StampDetailNotifierState?> {
  late final String historicSpotId;
  late final String eventCode;

  FutureOr<StampDetailNotifierState?> build(
    String historicSpotId,
    String eventCode,
  );
}

/// See also [StampDetailNotifier].
@ProviderFor(StampDetailNotifier)
const stampDetailNotifierProvider = StampDetailNotifierFamily();

/// See also [StampDetailNotifier].
class StampDetailNotifierFamily
    extends Family<AsyncValue<StampDetailNotifierState?>> {
  /// See also [StampDetailNotifier].
  const StampDetailNotifierFamily();

  /// See also [StampDetailNotifier].
  StampDetailNotifierProvider call(
    String historicSpotId,
    String eventCode,
  ) {
    return StampDetailNotifierProvider(
      historicSpotId,
      eventCode,
    );
  }

  @override
  StampDetailNotifierProvider getProviderOverride(
    covariant StampDetailNotifierProvider provider,
  ) {
    return call(
      provider.historicSpotId,
      provider.eventCode,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'stampDetailNotifierProvider';
}

/// See also [StampDetailNotifier].
class StampDetailNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    StampDetailNotifier, StampDetailNotifierState?> {
  /// See also [StampDetailNotifier].
  StampDetailNotifierProvider(
    String historicSpotId,
    String eventCode,
  ) : this._internal(
          () => StampDetailNotifier()
            ..historicSpotId = historicSpotId
            ..eventCode = eventCode,
          from: stampDetailNotifierProvider,
          name: r'stampDetailNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stampDetailNotifierHash,
          dependencies: StampDetailNotifierFamily._dependencies,
          allTransitiveDependencies:
              StampDetailNotifierFamily._allTransitiveDependencies,
          historicSpotId: historicSpotId,
          eventCode: eventCode,
        );

  StampDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.historicSpotId,
    required this.eventCode,
  }) : super.internal();

  final String historicSpotId;
  final String eventCode;

  @override
  FutureOr<StampDetailNotifierState?> runNotifierBuild(
    covariant StampDetailNotifier notifier,
  ) {
    return notifier.build(
      historicSpotId,
      eventCode,
    );
  }

  @override
  Override overrideWith(StampDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: StampDetailNotifierProvider._internal(
        () => create()
          ..historicSpotId = historicSpotId
          ..eventCode = eventCode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        historicSpotId: historicSpotId,
        eventCode: eventCode,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StampDetailNotifier,
      StampDetailNotifierState?> createElement() {
    return _StampDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StampDetailNotifierProvider &&
        other.historicSpotId == historicSpotId &&
        other.eventCode == eventCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, historicSpotId.hashCode);
    hash = _SystemHash.combine(hash, eventCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StampDetailNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<StampDetailNotifierState?> {
  /// The parameter `historicSpotId` of this provider.
  String get historicSpotId;

  /// The parameter `eventCode` of this provider.
  String get eventCode;
}

class _StampDetailNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StampDetailNotifier,
        StampDetailNotifierState?> with StampDetailNotifierRef {
  _StampDetailNotifierProviderElement(super.provider);

  @override
  String get historicSpotId =>
      (origin as StampDetailNotifierProvider).historicSpotId;
  @override
  String get eventCode => (origin as StampDetailNotifierProvider).eventCode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
