// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_card_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$completeCardNotifierHash() =>
    r'e50fe2a55c22bcad343c6a7e722463d8ebff9e7c';

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

abstract class _$CompleteCardNotifier
    extends BuildlessAutoDisposeAsyncNotifier<CompleteCardLocalModel?> {
  late final String url;

  FutureOr<CompleteCardLocalModel?> build(
    String url,
  );
}

/// See also [CompleteCardNotifier].
@ProviderFor(CompleteCardNotifier)
const completeCardNotifierProvider = CompleteCardNotifierFamily();

/// See also [CompleteCardNotifier].
class CompleteCardNotifierFamily
    extends Family<AsyncValue<CompleteCardLocalModel?>> {
  /// See also [CompleteCardNotifier].
  const CompleteCardNotifierFamily();

  /// See also [CompleteCardNotifier].
  CompleteCardNotifierProvider call(
    String url,
  ) {
    return CompleteCardNotifierProvider(
      url,
    );
  }

  @override
  CompleteCardNotifierProvider getProviderOverride(
    covariant CompleteCardNotifierProvider provider,
  ) {
    return call(
      provider.url,
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
  String? get name => r'completeCardNotifierProvider';
}

/// See also [CompleteCardNotifier].
class CompleteCardNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CompleteCardNotifier, CompleteCardLocalModel?> {
  /// See also [CompleteCardNotifier].
  CompleteCardNotifierProvider(
    String url,
  ) : this._internal(
          () => CompleteCardNotifier()..url = url,
          from: completeCardNotifierProvider,
          name: r'completeCardNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$completeCardNotifierHash,
          dependencies: CompleteCardNotifierFamily._dependencies,
          allTransitiveDependencies:
              CompleteCardNotifierFamily._allTransitiveDependencies,
          url: url,
        );

  CompleteCardNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  FutureOr<CompleteCardLocalModel?> runNotifierBuild(
    covariant CompleteCardNotifier notifier,
  ) {
    return notifier.build(
      url,
    );
  }

  @override
  Override overrideWith(CompleteCardNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompleteCardNotifierProvider._internal(
        () => create()..url = url,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CompleteCardNotifier,
      CompleteCardLocalModel?> createElement() {
    return _CompleteCardNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompleteCardNotifierProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CompleteCardNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<CompleteCardLocalModel?> {
  /// The parameter `url` of this provider.
  String get url;
}

class _CompleteCardNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CompleteCardNotifier,
        CompleteCardLocalModel?> with CompleteCardNotifierRef {
  _CompleteCardNotifierProviderElement(super.provider);

  @override
  String get url => (origin as CompleteCardNotifierProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
