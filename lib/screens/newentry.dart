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
  late double price;
  DateTime time = DateTime.now();
  late String buyer;
  late String seller;
  late String productName;
  late String productDescription;
  late int productQuality = 3;

  List buttonOutputs = [
    const Text('submit'),
    const CircularProgressIndicator(),
    const Text('done'),
    const Text('unable to add')
  ];
  int buttonState = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Price',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            setState(() => price = double.parse(value!)),
                      ),
                    ),
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
                      child: Icon(
                        Icons.date_range,
                        size: constraints.maxWidth * 0.1,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      hintText: 'Buyer',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a buyer';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => buyer = value!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      hintText: 'Seller',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a seller';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => seller = value!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'product Name',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => productName = value!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'product Description ',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) =>
                      setState(() => productDescription = value!),
                ),
              ),
              DropdownButton(
                  hint: const Text('Product Rating'),
                  alignment: Alignment.center,
                  items: <String>['1', '2', '3', '4', '5'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    productQuality = int.parse(value!);
                  }),
              ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(
                        Size(constraints.maxWidth, 40))),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onSubmit(Transaction(price, time, buyer, seller,
                        productName, productDescription, productQuality));
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
      ),
    );
  }
}
