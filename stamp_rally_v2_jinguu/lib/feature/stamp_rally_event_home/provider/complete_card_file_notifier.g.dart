// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_card_file_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$completeCardFileNotifierHash() =>
    r'8bde0368b8d5799c01b185933ab20fad1d7477e3';

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

abstract class _$CompleteCardFileNotifier
    extends BuildlessAutoDisposeAsyncNotifier<File?> {
  late final String eventCode;

  FutureOr<File?> build(
    String eventCode,
  );
}

/// See also [CompleteCardFileNotifier].
@ProviderFor(CompleteCardFileNotifier)
const completeCardFileNotifierProvider = CompleteCardFileNotifierFamily();

/// See also [CompleteCardFileNotifier].
class CompleteCardFileNotifierFamily extends Family<AsyncValue<File?>> {
  /// See also [CompleteCardFileNotifier].
  const CompleteCardFileNotifierFamily();

  /// See also [CompleteCardFileNotifier].
  CompleteCardFileNotifierProvider call(
    String eventCode,
  ) {
    return CompleteCardFileNotifierProvider(
      eventCode,
    );
  }

  @override
  CompleteCardFileNotifierProvider getProviderOverride(
    covariant CompleteCardFileNotifierProvider provider,
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
  String? get name => r'completeCardFileNotifierProvider';
}

/// See also [CompleteCardFileNotifier].
class CompleteCardFileNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CompleteCardFileNotifier,
        File?> {
  /// See also [CompleteCardFileNotifier].
  CompleteCardFileNotifierProvider(
    String eventCode,
  ) : this._internal(
          () => CompleteCardFileNotifier()..eventCode = eventCode,
          from: completeCardFileNotifierProvider,
          name: r'completeCardFileNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$completeCardFileNotifierHash,
          dependencies: CompleteCardFileNotifierFamily._dependencies,
          allTransitiveDependencies:
              CompleteCardFileNotifierFamily._allTransitiveDependencies,
          eventCode: eventCode,
        );

  CompleteCardFileNotifierProvider._internal(
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
  FutureOr<File?> runNotifierBuild(
    covariant CompleteCardFileNotifier notifier,
  ) {
    return notifier.build(
      eventCode,
    );
  }

  @override
  Override overrideWith(CompleteCardFileNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompleteCardFileNotifierProvider._internal(
        () => create()..eventCode = eventCode,
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
  AutoDisposeAsyncNotifierProviderElement<CompleteCardFileNotifier, File?>
      createElement() {
    return _CompleteCardFileNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompleteCardFileNotifierProvider &&
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
mixin CompleteCardFileNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<File?> {
  /// The parameter `eventCode` of this provider.
  String get eventCode;
}

class _CompleteCardFileNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CompleteCardFileNotifier,
        File?> with CompleteCardFileNotifierRef {
  _CompleteCardFileNotifierProviderElement(super.provider);

  @override
  String get eventCode =>
      (origin as CompleteCardFileNotifierProvider).eventCode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
