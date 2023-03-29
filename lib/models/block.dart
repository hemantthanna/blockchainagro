import 'dart:convert';

import 'package:blockchainagro/models/transactions.dart';
import 'package:crypto/crypto.dart';

class Block {
  final int index;
  final DateTime timestamp;
  final Transaction transactions;
  String previousHash;
  late String hash;

  Block(this.index, this.timestamp, this.transactions,
      {this.previousHash = ''}) {
    hash = calculateHash();
  }

  String calculateHash() {
    var bytes = utf8.encode(
        index.toString() + timestamp.toIso8601String() + previousHash);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  factory Block.fromJson(Map<String, dynamic> json) {
    Transaction transaction =  Transaction(
            json['transactions']['id'].toString(),
            json['transactions']['price'].toDouble(),
            DateTime.parse(json['transactions']['time']),
            json['transactions']['buyer'],
            json['transactions']['seller']);

    return Block(
      json['index'],
      DateTime.parse(json['timestamp']),
      transaction,
      previousHash: json['previousHash'],
    )..hash = json['hash'];
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'timestamp': timestamp.toIso8601String(),
        'transactions': transactions.toJson(),
        'previousHash': previousHash,
        'hash': hash
      };
}
