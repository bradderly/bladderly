rm lib/presentation/generated/assets/*.dart
rm lib/data/api/model/*.dart
fvm dart run build_runner build --delete-conflicting-outputs