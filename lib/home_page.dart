import 'package:cruv/seat_model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<int> currentSeat = ValueNotifier<int>(0);
  late final TextEditingController seatfield;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    seatfield = TextEditingController();
  }

  @override
  void dispose() {
    seatfield.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Seat Finder',
                  style: TextStyle(fontSize: 30, color: Colors.cyan),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: seatfield,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter Seat Number...',
                          hintStyle: TextStyle(color: Colors.cyan),
                          //border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.cyan, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.cyan, width: 2),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: seatfield.text.trim().isEmpty
                          ? null
                          : () {
                              scrollController.animateTo(45 / 4 * 80,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                              currentSeat.value =
                                  int.parse(seatfield.text.trim());
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        fixedSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Find'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                for (int i = 1; i < 50; i = i + 4)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        for (int j = i; j < i + 4; j++)
                          ValueListenableBuilder(
                            valueListenable: currentSeat,
                            builder: (context, value, child) {
                              return Container(
                                  margin: j % 4 == 0
                                      ? const EdgeInsets.only(left: 70)
                                      : null,
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        top: const BorderSide(
                                          color: Colors.cyan,
                                          width: 4,
                                        ),
                                        left: j == i || j % 4 == 0
                                            ? const BorderSide(
                                                color: Colors.cyan,
                                                width: 4,
                                              )
                                            : BorderSide.none,
                                        right: j % 4 == 0 || j == i + 2
                                            ? const BorderSide(
                                                color: Colors.cyan,
                                                width: 4,
                                              )
                                            : BorderSide.none,
                                        bottom: const BorderSide(
                                          color: Colors.cyan,
                                          width: 4,
                                        ),
                                      ),
                                      color: j == currentSeat.value
                                          ? Colors.cyan
                                          : Colors.cyan[100]),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(j.toString()),
                                        Text(j == i
                                            ? 'Lower'
                                            : j == i + 1
                                                ? 'Middle'
                                                : j == i + 2
                                                    ? 'Upper'
                                                    : (j / 4) % 2 != 0
                                                        ? 'Side Lower'
                                                        : 'Side Upper')
                                      ],
                                    ),
                                  ));
                            },
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
