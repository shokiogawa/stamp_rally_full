// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stapm_rally_event_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stampRallyEventDetailNotifierHash() =>
    r'c9baffd928d9ccd928feb85b2559df2e660c7189';

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

abstract class _$StampRallyEventDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<
        StampRallyEventDetailNotofierState?> {
  late final String code;

  FutureOr<StampRallyEventDetailNotofierState?> build(
    String code,
  );
}

/// See also [StampRallyEventDetailNotifier].
@ProviderFor(StampRallyEventDetailNotifier)
const stampRallyEventDetailNotifierProvider =
    StampRallyEventDetailNotifierFamily();

/// See also [StampRallyEventDetailNotifier].
class StampRallyEventDetailNotifierFamily
    extends Family<AsyncValue<StampRallyEventDetailNotofierState?>> {
  /// See also [StampRallyEventDetailNotifier].
  const StampRallyEventDetailNotifierFamily();

  /// See also [StampRallyEventDetailNotifier].
  StampRallyEventDetailNotifierProvider call(
    String code,
  ) {
    return StampRallyEventDetailNotifierProvider(
      code,
    );
  }

  @override
  StampRallyEventDetailNotifierProvider getProviderOverride(
    covariant StampRallyEventDetailNotifierProvider provider,
  ) {
    return call(
      provider.code,
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
  String? get name => r'stampRallyEventDetailNotifierProvider';
}

/// See also [StampRallyEventDetailNotifier].
class StampRallyEventDetailNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<StampRallyEventDetailNotifier,
        StampRallyEventDetailNotofierState?> {
  /// See also [StampRallyEventDetailNotifier].
  StampRallyEventDetailNotifierProvider(
    String code,
  ) : this._internal(
          () => StampRallyEventDetailNotifier()..code = code,
          from: stampRallyEventDetailNotifierProvider,
          name: r'stampRallyEventDetailNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stampRallyEventDetailNotifierHash,
          dependencies: StampRallyEventDetailNotifierFamily._dependencies,
          allTransitiveDependencies:
              StampRallyEventDetailNotifierFamily._allTransitiveDependencies,
          code: code,
        );

  StampRallyEventDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.code,
  }) : super.internal();

  final String code;

  @override
  FutureOr<StampRallyEventDetailNotofierState?> runNotifierBuild(
    covariant StampRallyEventDetailNotifier notifier,
  ) {
    return notifier.build(
      code,
    );
  }

  @override
  Override overrideWith(StampRallyEventDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: StampRallyEventDetailNotifierProvider._internal(
        () => create()..code = code,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        code: code,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<StampRallyEventDetailNotifier,
      StampRallyEventDetailNotofierState?> createElement() {
    return _StampRallyEventDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StampRallyEventDetailNotifierProvider && other.code == code;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, code.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StampRallyEventDetailNotifierRef on AutoDisposeAsyncNotifierProviderRef<
    StampRallyEventDetailNotofierState?> {
  /// The parameter `code` of this provider.
  String get code;
}

class _StampRallyEventDetailNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        StampRallyEventDetailNotifier, StampRallyEventDetailNotofierState?>
    with StampRallyEventDetailNotifierRef {
  _StampRallyEventDetailNotifierProviderElement(super.provider);

  @override
  String get code => (origin as StampRallyEventDetailNotifierProvider).code;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
