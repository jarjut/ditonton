import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

final locator = GetIt.instance;

@InjectableInit()
void init() {
  // injectable generator
  locator.init();
}

@module
abstract class RegisterModule {
  @lazySingleton
  http.Client get client => http.Client();

  @lazySingleton
  DatabaseHelper get databaseHelper => DatabaseHelper(isTest: false);
}
