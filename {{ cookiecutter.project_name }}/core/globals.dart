import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'globals.g.dart';

Logger logger = Logger(printer: PrettyPrinter());

enum Collection { organizations, branches, scans, inventory, accounts }


@Riverpod(keepAlive: true)
Dio dio(DioRef ref) => Dio();