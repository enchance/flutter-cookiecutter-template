import 'package:logger/logger.dart';

import 'enums.dart';

final logger = Logger(printer: PrettyPrinter());

const defaultRole = Role.starter;
const defaultDarkMode = false;
const defaultGridSize = GridSize.large;
const defaultTextSize = TextSize.medium;
const defaultFetchCount = 10;

const opacity1 = 0.5;
const opacity2 = 0.3;

// Development
const devemail = 'devteam123@proton.me';
const devpass = 'pass123';

// class DevLogModel with _$DevLogModel {
//   const factory DevLogModel({
//     @Default([]) List<String> logs,
//   }) = _DevLogModel;
//
//   factory DevLogModel.fromJson(Map<String, Object?> json) => _$DevLogModelFromJson(json);
// }

// @freezed

// @Riverpod(keepAlive: true)
// InternetConnectionChecker internetConnectionChecker(InternetConnectionCheckerRef ref) {
//   return InternetConnectionChecker();
//   // return InternetConnectionChecker.createInstance(
//   //   checkTimeout: const Duration(seconds: 5),
//   //   checkInterval: const Duration(minutes: 1),
//   // );
// }

// @Riverpod(keepAlive: true)
// class DevLog extends _$DevLog {
//   @override
//   DevLogModel build() => const DevLogModel();
//
//   void add(String message) => state = state.copyWith(logs: [...state.logs, message]);
//
//   void clear() => state = const DevLogModel();
// }
