// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_place_by_event_code_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchPlaceByEventCodeHash() =>
    r'7065b2a63fc617fed0a1bd19dfd52e1b4e987f26';

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

/// See also [fetchPlaceByEventCode].
@ProviderFor(fetchPlaceByEventCode)
const fetchPlaceByEventCodeProvider = FetchPlaceByEventCodeFamily();

/// See also [fetchPlaceByEventCode].
class FetchPlaceByEventCodeFamily extends Family<AsyncValue<List<PlaceModel>>> {
  /// See also [fetchPlaceByEventCode].
  const FetchPlaceByEventCodeFamily();

  /// See also [fetchPlaceByEventCode].
  FetchPlaceByEventCodeProvider call(
    String eventCode,
  ) {
    return FetchPlaceByEventCodeProvider(
      eventCode,
    );
  }

  @override
  FetchPlaceByEventCodeProvider getProviderOverride(
    covariant FetchPlaceByEventCodeProvider provider,
  ) {
    return call(
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
  String? get name => r'fetchPlaceByEventCodeProvider';
}

/// See also [fetchPlaceByEventCode].
class FetchPlaceByEventCodeProvider extends FutureProvider<List<PlaceModel>> {
  /// See also [fetchPlaceByEventCode].
  FetchPlaceByEventCodeProvider(
    String eventCode,
  ) : this._internal(
          (ref) => fetchPlaceByEventCode(
            ref as FetchPlaceByEventCodeRef,
            eventCode,
          ),
          from: fetchPlaceByEventCodeProvider,
          name: r'fetchPlaceByEventCodeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchPlaceByEventCodeHash,
          dependencies: FetchPlaceByEventCodeFamily._dependencies,
          allTransitiveDependencies:
              FetchPlaceByEventCodeFamily._allTransitiveDependencies,
          eventCode: eventCode,
        );

  FetchPlaceByEventCodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventCode,
  }) : super.internal();

  final String eventCode;

  @override
  Override overrideWith(
    FutureOr<List<PlaceModel>> Function(FetchPlaceByEventCodeRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchPlaceByEventCodeProvider._internal(
        (ref) => create(ref as FetchPlaceByEventCodeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventCode: eventCode,
      ),
    );
  }

  @override
  FutureProviderElement<List<PlaceModel>> createElement() {
    return _FetchPlaceByEventCodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchPlaceByEventCodeProvider &&
        other.eventCode == eventCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchPlaceByEventCodeRef on FutureProviderRef<List<PlaceModel>> {
  /// The parameter `eventCode` of this provider.
  String get eventCode;
}

class _FetchPlaceByEventCodeProviderElement
    extends FutureProviderElement<List<PlaceModel>>
    with FetchPlaceByEventCodeRef {
  _FetchPlaceByEventCodeProviderElement(super.provider);

  @override
  String get eventCode => (origin as FetchPlaceByEventCodeProvider).eventCode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
