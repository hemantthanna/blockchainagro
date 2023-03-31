import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/block.dart';
import '../services/blockchain.dart';
import '../services/singleton.dart';

class Transaction_Screen extends StatefulWidget {
  const Transaction_Screen({super.key});

  @override
  State<Transaction_Screen> createState() => _Transaction_ScreenState();
}

class _Transaction_ScreenState extends State<Transaction_Screen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        toolbarHeight: MediaQuery.of(context).size.height / 8,
        actions: const [Icon(Icons.notifications), Icon(Icons.person)],
      ),
      body: LayoutBuilder(
        builder: (context, constrints) => Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('blocks').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var blocks = snapshot.data!.docs
                      .map((doc) =>
                          Block.fromJson(doc.data()! as Map<String, dynamic>))
                      .toList();

                  return ListView.builder(
                    itemCount: blocks.length,
                    itemBuilder: (context, index) {
                      var block = blocks[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: Text(block.transactions.productName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('price Rs. ${block.transactions.price}'),
                              Text(
                                  '${DateTime.parse(block.transactions.time.toString())}'),
                            ],
                          ),
                          trailing: FutureBuilder(
                            future: singleton.get<Blockchain>().isChainValid(),
                            builder: (context, snapshot) => Icon(
                                snapshot.data == true
                                    ? Icons.check
                                    : Icons.close),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}