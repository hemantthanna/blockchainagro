import 'package:blockchainagro/models/transactions.dart' as local;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/block.dart';

class Blockchain {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> addBlock(Block block) async {
    try {
      QuerySnapshot data = await firestore
          .collection('blocks')
          .orderBy('index', descending: true)
          .limit(1)
          .get();
      Block lastBlock = data.size > 0
          ? Block.fromJson(data.docs[0].data() as Map<String, dynamic>)
          : createGenesisBlock();
      block.previousHash = lastBlock.hash;
      block.hash = block.calculateHash();
      await firestore.collection('blocks').add(block.toJson());
    } catch (e) {
      print('unable to add transaction. due to : $e');
    }
  }

  /// TODO: apply mechanish for chain validity check
  Future<bool> isChainValid() async {
    List chain = [createGenesisBlock()];
    firestore
        .collection('blocks')
        .orderBy('index', descending: true)
        .get()
        .then((value) {
      value.docs.map((e) => Block.fromJson(e.data()));
    });

    for (var i = 1; i < chain.length; i++) {
      var currentBlock = chain[i];
      var previousBlock = chain[i - 1];
      if (currentBlock.hash != currentBlock.calculateHash()) {
        return false;
      }
      if (currentBlock.previousHash != previousBlock.hash) {
        return false;
      }
    }
    return true;
  }

  /// used to create empty first block.
  static Block createGenesisBlock() =>
      Block(0, DateTime.now(), local.Transaction( 0, DateTime.now(), '', '', '', '', 3),
          previousHash: '');
}
