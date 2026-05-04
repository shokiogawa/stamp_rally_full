# stamp_rally_v2_fvm

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```
fvm flutter build appbundle --release --dart-define-from-file=lib/configuration/production/dart_defines_production.json

fvm flutter build apk --release --dart-define-from-file=lib/configuration/production/dart_defines_production.json

fvm flutter build ios --release --dart-define-from-file=lib/configuration/production/dart_defines_production.json
```

- 型定義生成

```
npx supabase gen types typescript --project-id "ldbrlwmfgtibqtvovzmk" --schema public > types/supabase.ts
supabase gen types typescript --linked > schema.ts
```

- DB リセット

```
supabase db reset --linked
```
