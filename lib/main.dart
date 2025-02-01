import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Reefscape Scouting App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const List<String> list = <String>[
  'Red 1',
  'Red 2',
  'Red 3',
  'Blue 1',
  'Blue 2',
  'Blue 3'
];

enum BargeLevel { none, park, shallow, deep }

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  bool preloadValue = false;
  String dropdownValue = list.first;
  int selectedValue = 1;
  bool leaveValue = false;
  int autoL4Count = 0;
  int autoL3Count = 0;
  int autoL2Count = 0;
  int autoTroughCount = 0;
  int autoProcessorCount = 0;
  int autoNetCount = 0;
  int teleL4Count = 0;
  int teleL3Count = 0;
  int teleL2Count = 0;
  int teleTroughCount = 0;
  int teleProcessorCount = 0;
  int teleNetCount = 0;
  BargeLevel? level = BargeLevel.none;
  String data = "";
  final TextEditingController scoutName = TextEditingController();
  final TextEditingController matchNumber = TextEditingController();
  final TextEditingController teamNumber = TextEditingController();
  final TextEditingController comments = TextEditingController();
  bool diedValue = false;
  bool brokeValue = false;
  bool defenseValue = false;
  int autoTakeOffCount = 0;
  int teleTakeOffCount = 0;
  bool reefOneValue = false;
  bool reefTwoValue = false;
  bool reefThreeValue = false;
  bool reefFourValue = false;
  bool reefFiveValue = false;
  bool reefSixValue = false;

  String printBoolean(bool value) {
    return value ? 'Yes' : 'No';
  }

  String getFieldPosition(int fieldPosition) {
    switch (fieldPosition) {
      case 0:
        return "Alliance Wall";
      case 1:
        return "Alliance Side";
      case 2:
        return "Center";
      case 3:
        return "Processor Side";
      case 4:
        return "Processor Wall";
      default:
        return "ROBOT NOT FOUND";
    }
  }

  void formatData() {
    setState(() {
      data =
          "${teamNumber.text}*${matchNumber.text}*${printBoolean(preloadValue)}*$dropdownValue*${getFieldPosition(selectedValue)}*${printBoolean(leaveValue)}*"
          "$autoTroughCount*$autoL2Count*$autoL3Count*$autoL4Count*$autoProcessorCount*$autoNetCount*$autoTakeOffCount*${printBoolean(diedValue)}*${printBoolean(brokeValue)}*"
          "${printBoolean(defenseValue)}*$teleTroughCount*$teleL2Count*$teleL3Count*$teleL4Count*$teleProcessorCount*$teleNetCount*$teleTakeOffCount*$level*${comments.text}*${scoutName.text}";
    });
  }

  void resetData() {
    setState(() {
      preloadValue = false;
      selectedValue = 1;
      leaveValue = false;
      autoL4Count = 0;
      autoL3Count = 0;
      autoL2Count = 0;
      autoTroughCount = 0;
      autoProcessorCount = 0;
      autoNetCount = 0;
      teleL4Count = 0;
      teleL3Count = 0;
      teleL2Count = 0;
      teleTroughCount = 0;
      teleProcessorCount = 0;
      teleNetCount = 0;
      level = BargeLevel.none;
      data = "";
      comments.text = "";
      int currentValue = int.tryParse(matchNumber.text) ?? 0;
      currentValue++;
      matchNumber.text = currentValue.toString();
      teamNumber.text = "";
      currentPageIndex = 0;
      diedValue = false;
      brokeValue = false;
      defenseValue = false;
      autoTakeOffCount = 0;
      teleTakeOffCount = 0;
    });
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Action"),
          content: Text(
              "Are you sure you want to clear all data? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                resetData(); // Call your function to clear data
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Confirm", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            if (currentPageIndex == 5) {
              formatData();
            }
          });
        },
        indicatorColor: Colors.amber,
        surfaceTintColor: Colors.white,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.add_location),
            icon: Icon(Icons.add_location_outlined),
            label: 'Pre-Match',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.adb),
            icon: Icon(Icons.adb_outlined),
            label: 'Auto',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map),
            icon: Icon(Icons.map_outlined),
            label: 'Reef',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.videogame_asset),
            icon: Icon(Icons.videogame_asset_outlined),
            label: 'Teleop',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.anchor),
            icon: Icon(Icons.anchor_outlined),
            label: 'Barge',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.qr_code),
            icon: Icon(Icons.qr_code_outlined),
            label: 'QR',
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: <Widget>[
        Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: scoutName,
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Scout Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: matchNumber,
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Match Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: teamNumber,
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Team Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: preloadValue,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                preloadValue = newValue!;
                              });
                            },
                          ),
                          Text("Preload?"),
                        ],
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/field image.png',
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Radio<int>(
                            value: 1,
                            activeColor: Colors.amber,
                            groupValue: selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Radio<int>(
                            value: 2,
                            activeColor: Colors.amber,
                            groupValue: selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Radio<int>(
                            value: 3,
                            activeColor: Colors.amber,
                            groupValue: selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          Text(
                            '3',
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Radio<int>(
                            value: 4,
                            activeColor: Colors.amber,
                            groupValue: selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          Text(
                            '4',
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Radio<int>(
                            value: 5,
                            activeColor: Colors.amber,
                            groupValue: selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          Text(
                            '5',
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Auto",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: leaveValue,
                      activeColor: Colors.amber,
                      onChanged: (newValue) {
                        setState(() {
                          leaveValue = newValue!;
                        });
                      },
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Leave?',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Coral L4",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Algae Processor",
                      style: TextStyle(
                        color: Colors.tealAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoL4Count > 0) {
                            autoL4Count--;
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoL4Count",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoL4Count < 12) {
                            autoL4Count++;
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoProcessorCount > 0) {
                            autoProcessorCount--;
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoProcessorCount",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          autoProcessorCount++;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Coral L3",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Algae Net",
                      style: TextStyle(
                        color: Colors.tealAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoL3Count > 0) {
                            autoL3Count--;
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoL3Count",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoL3Count < 12) {
                            autoL3Count++;
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoNetCount > 0) {
                            autoNetCount--;
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoNetCount",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          autoNetCount++;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Coral L2",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Algae Taken Off",
                      style: TextStyle(
                        color: Colors.tealAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoL2Count > 0) {
                            autoL2Count--;
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoL2Count",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoL2Count < 12) {
                            autoL2Count++;
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoTakeOffCount > 0) {
                            autoTakeOffCount--;
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoTakeOffCount",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          autoTakeOffCount++;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Coral Trough",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoTroughCount > 0) {
                            autoTroughCount--;
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoTroughCount",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 36.0,
                      onPressed: () {
                        setState(() {
                          if (autoTroughCount < 12) {
                            autoTroughCount++;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reef Placement",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/reef placement.png',
                        fit: BoxFit.cover, // Adjust as needed
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Checkbox(
                          value: reefOneValue,
                          activeColor: Colors.amber,
                          onChanged: (newValue) {
                            setState(() {
                              reefOneValue = newValue!;
                            });
                          },
                        ),
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Checkbox(
                          value: reefTwoValue,
                          activeColor: Colors.amber,
                          onChanged: (newValue) {
                            setState(() {
                              reefTwoValue = newValue!;
                            });
                          },
                        ),
                        Text(
                          "2",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Checkbox(
                          value: reefThreeValue,
                          activeColor: Colors.amber,
                          onChanged: (newValue) {
                            setState(() {
                              reefThreeValue = newValue!;
                            });
                          },
                        ),
                        Text(
                          "3",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Checkbox(
                          value: reefFourValue,
                          activeColor: Colors.amber,
                          onChanged: (newValue) {
                            setState(() {
                              reefFourValue = newValue!;
                            });
                          },
                        ),
                        Text(
                          "4",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Checkbox(
                          value: reefFiveValue,
                          activeColor: Colors.amber,
                          onChanged: (newValue) {
                            setState(() {
                              reefFiveValue = newValue!;
                            });
                          },
                        ),
                        Text(
                          "5",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Checkbox(
                          value: reefSixValue,
                          activeColor: Colors.amber,
                          onChanged: (newValue) {
                            setState(() {
                              reefSixValue = newValue!;
                            });
                          },
                        ),
                        Text(
                          "6",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Teleop",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Checkbox(
                        value: diedValue,
                        activeColor: Colors.amber,
                        onChanged: (newValue) {
                          setState(() {
                            diedValue = newValue!;
                          });
                        },
                      ),
                      Text("Died",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      Checkbox(
                        value: brokeValue,
                        activeColor: Colors.amber,
                        onChanged: (newValue) {
                          setState(() {
                            brokeValue = newValue!;
                          });
                        },
                      ),
                      Text("Broke",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      Checkbox(
                        value: defenseValue,
                        activeColor: Colors.amber,
                        onChanged: (newValue) {
                          setState(() {
                            defenseValue = newValue!;
                          });
                        },
                      ),
                      Text("Defense",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Coral L4",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Algae Processor",
                        style: TextStyle(
                          color: Colors.tealAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleL4Count > 0) {
                              teleL4Count--;
                            }
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleL4Count",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleL4Count < 12) {
                              teleL4Count++;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleProcessorCount > 0) {
                              teleProcessorCount--;
                            }
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleProcessorCount",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            teleProcessorCount++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Coral L3",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Algae Net",
                        style: TextStyle(
                          color: Colors.tealAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleL3Count > 0) {
                              teleL3Count--;
                            }
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleL3Count",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleL3Count < 12) {
                              teleL3Count++;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleNetCount > 0) {
                              teleNetCount--;
                            }
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleNetCount",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            teleNetCount++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Coral L2",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Algae Taken Off",
                        style: TextStyle(
                          color: Colors.tealAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleL2Count > 0) {
                              teleL2Count--;
                            }
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleL2Count",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleL2Count < 12) {
                              teleL2Count++;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleTakeOffCount > 0) {
                              teleTakeOffCount--;
                            }
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleTakeOffCount",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            teleTakeOffCount++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Coral Trough",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleTroughCount > 0) {
                              teleTroughCount--;
                            }
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleTroughCount",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 36.0,
                        onPressed: () {
                          setState(() {
                            if (teleTroughCount < 12) {
                              teleTroughCount++;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Barge",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Climb Level',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ListTile(
                          title: const Text('None'),
                          leading: Radio<BargeLevel>(
                            activeColor: Colors.amber,
                            value: BargeLevel.none,
                            groupValue: level,
                            onChanged: (BargeLevel? value) {
                              setState(() {
                                level = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Park'),
                          leading: Radio<BargeLevel>(
                            activeColor: Colors.amber,
                            value: BargeLevel.park,
                            groupValue: level,
                            onChanged: (BargeLevel? value) {
                              setState(() {
                                level = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Shallow (high)'),
                          leading: Radio<BargeLevel>(
                            activeColor: Colors.amber,
                            value: BargeLevel.shallow,
                            groupValue: level,
                            onChanged: (BargeLevel? value) {
                              setState(() {
                                level = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Deep (low)'),
                          leading: Radio<BargeLevel>(
                            activeColor: Colors.amber,
                            value: BargeLevel.deep,
                            groupValue: level,
                            onChanged: (BargeLevel? value) {
                              setState(() {
                                level = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: comments,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Comments',
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "QR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QrImageView(
                data: data,
                size: 200.0,
                version: QrVersions.auto,
                backgroundColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      showConfirmationDialog(context);
                    },
                    child: const Text(
                      'Clear Data',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ][currentPageIndex],
    );
  }
}
