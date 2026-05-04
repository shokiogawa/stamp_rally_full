// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worship_card_file_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$worshipCardFilesNotifierHash() =>
    r'f2974311fde8114a377e9c75a76cf8045801ce75';

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

abstract class _$WorshipCardFilesNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<File>> {
  late final String historicSpotId;

  FutureOr<List<File>> build(
    String historicSpotId,
  );
}

/// See also [WorshipCardFilesNotifier].
@ProviderFor(WorshipCardFilesNotifier)
const worshipCardFilesNotifierProvider = WorshipCardFilesNotifierFamily();

/// See also [WorshipCardFilesNotifier].
class WorshipCardFilesNotifierFamily extends Family<AsyncValue<List<File>>> {
  /// See also [WorshipCardFilesNotifier].
  const WorshipCardFilesNotifierFamily();

  /// See also [WorshipCardFilesNotifier].
  WorshipCardFilesNotifierProvider call(
    String historicSpotId,
  ) {
    return WorshipCardFilesNotifierProvider(
      historicSpotId,
    );
  }

  @override
  WorshipCardFilesNotifierProvider getProviderOverride(
    covariant WorshipCardFilesNotifierProvider provider,
  ) {
    return call(
      provider.historicSpotId,
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
  String? get name => r'worshipCardFilesNotifierProvider';
}

/// See also [WorshipCardFilesNotifier].
class WorshipCardFilesNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<WorshipCardFilesNotifier,
        List<File>> {
  /// See also [WorshipCardFilesNotifier].
  WorshipCardFilesNotifierProvider(
    String historicSpotId,
  ) : this._internal(
          () => WorshipCardFilesNotifier()..historicSpotId = historicSpotId,
          from: worshipCardFilesNotifierProvider,
          name: r'worshipCardFilesNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$worshipCardFilesNotifierHash,
          dependencies: WorshipCardFilesNotifierFamily._dependencies,
          allTransitiveDependencies:
              WorshipCardFilesNotifierFamily._allTransitiveDependencies,
          historicSpotId: historicSpotId,
        );

  WorshipCardFilesNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.historicSpotId,
  }) : super.internal();

  final String historicSpotId;

  @override
  FutureOr<List<File>> runNotifierBuild(
    covariant WorshipCardFilesNotifier notifier,
  ) {
    return notifier.build(
      historicSpotId,
    );
  }

  @override
  Override overrideWith(WorshipCardFilesNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: WorshipCardFilesNotifierProvider._internal(
        () => create()..historicSpotId = historicSpotId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        historicSpotId: historicSpotId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<WorshipCardFilesNotifier, List<File>>
      createElement() {
    return _WorshipCardFilesNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorshipCardFilesNotifierProvider &&
        other.historicSpotId == historicSpotId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, historicSpotId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorshipCardFilesNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<File>> {
  /// The parameter `historicSpotId` of this provider.
  String get historicSpotId;
}

class _WorshipCardFilesNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<WorshipCardFilesNotifier,
        List<File>> with WorshipCardFilesNotifierRef {
  _WorshipCardFilesNotifierProviderElement(super.provider);

  @override
  String get historicSpotId =>
      (origin as WorshipCardFilesNotifierProvider).historicSpotId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
