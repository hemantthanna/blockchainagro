import 'package:blockchainagro/services/blockchain.dart';
import 'package:get_it/get_it.dart';

final singleton = GetIt.instance;
void setupSingleton() {
  /// Register the classes you want to persist globally
  /// TODO: make this a lazysingleton to improve performance
  singleton.registerSingleton<Blockchain>(Blockchain());
}