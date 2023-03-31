import 'package:blockchainagro/screens/newentry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        toolbarHeight: MediaQuery.of(context).size.height / 8,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 100,
              color: Colors.red,
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      height: constraints.maxHeight / 1.5,
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                            children: [],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      height: constraints.maxHeight / 10,
                      child: Center(
                          child: Text(
                        'All Prices',
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NewEntry()));
              },
              child: const Text('New Transaction'))
        ],
      ),
    );
  }
}
