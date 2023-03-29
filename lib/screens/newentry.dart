import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../models/block.dart';
import '../models/transactions.dart';
import '../services/blockchain.dart';
import '../services/singleton.dart';

class NewEntry extends StatefulWidget {
  const NewEntry({super.key});

  @override
  State<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  void addTransaction(Transaction transaction) async {
    Blockchain blockchain = singleton.get<Blockchain>();
    var block = Block(
        DateTime.now().microsecondsSinceEpoch, DateTime.now(), transaction,
        previousHash: '');
    blockchain.addBlock(block);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('new Entry'),
        toolbarHeight: MediaQuery.of(context).size.height / 8,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 5),
            borderRadius: BorderRadius.circular(20)),
        child: TransactionForm(onSubmit: addTransaction),
      ),
    );
  }
}

class TransactionForm extends StatefulWidget {
  final Function(Transaction) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  late String id;
  late double price;
  DateTime time = DateTime.now();
  late String buyer;
  late String seller;
  List buttonOutputs = [
    Text('submit'),
    CircularProgressIndicator(),
    Text('done'),
    Text('unable to add')

  ];
  int buttonState = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'ID',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an ID';
                }
                return null;
              },
              onSaved: (value) => setState(() => id = value!),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Price',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onSaved: (value) => setState(() => price = double.parse(value!)),
            ),
            TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                    setState(() {
                      time = date;
                    });
                  }, onConfirm: (date) {
                    time = date;
                  }, currentTime: DateTime.now());
                },
                child: const Text(
                  'show date time picker',
                  style: TextStyle(color: Colors.blue),
                )),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Buyer',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a buyer';
                }
                return null;
              },
              onSaved: (value) => setState(() => buyer = value!),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Seller',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a seller';
                }
                return null;
              },
              onSaved: (value) => setState(() => seller = value!),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSubmit(Transaction(id, price, time, buyer, seller));
                  setState(() {
                    buttonState = 1;
                  });

                  /// valdating the integrity of chain.
                  bool isvalid =
                      await singleton.get<Blockchain>().isChainValid();
                  if (isvalid) {
                    setState(() {
                      buttonState = 2;
                    });
                  } else {
                    setState(() {
                      buttonState = 3;
                    });
                  }
                }
              },
              child: buttonOutputs[buttonState],
            ),
          ],
        ),
      ),
    );
  }
}
