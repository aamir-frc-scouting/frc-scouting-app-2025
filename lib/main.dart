import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Reefscape Scouting App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
  int _counter = 0;
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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  String printBoolean(bool value) {
    return value ? 'Yes' : 'No';
  }

// Helper function for field position (you can adjust this as per your requirements)
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
          "${teamNumber.text}*${matchNumber.text}*${printBoolean(preloadValue)}*$dropdownValue*${getFieldPosition(selectedValue)}"
          "*${printBoolean(leaveValue)}*$autoTroughCount*$autoL2Count*$autoL3Count*$autoL4Count*$autoProcessorCount*$autoNetCount*${""}"
          "*$teleTroughCount*$teleL2Count*$teleL3Count*$teleL4Count*$teleProcessorCount*$teleNetCount*${""}"
          "*$level*${comments.text}*${scoutName.text}";
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
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
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
          style: TextStyle(color: Colors.black), // Change text color to white
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Center the row on the screen
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
                      SizedBox(
                          width: 8), // Add spacing between the radio buttons
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
                      SizedBox(
                          width: 8), // Add spacing between the radio buttons
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
                      SizedBox(
                        width: 8,
                      ),
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
                      SizedBox(
                        width: 8,
                      ),
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
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/field image.png',
                      fit: BoxFit.cover, // or BoxFit.contain, BoxFit.fill, etc.
                    ))
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
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the content horizontally
                  children: [
                    Checkbox(
                      value: leaveValue,
                      activeColor:
                          Colors.amber, // Color of the checkbox when checked
                      onChanged: (newValue) {
                        setState(() {
                          leaveValue = newValue!;
                        });
                      },
                    ),
                    SizedBox(
                        width:
                            8.0), // Add spacing between the checkbox and the text
                    Text(
                      'Leave?',
                      style: TextStyle(
                        fontSize: 16.0, // Adjust font size as needed
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centers the text horizontally
                  children: [
                    Text(
                      "Coral L4",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16.0, // Adjust font size as needed
                        fontWeight:
                            FontWeight.bold, // Optional: Make the text bold
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Centers the text horizontally
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (autoL4Count > 0)
                            autoL4Count--; // Decrease counter but not below 0
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoL4Count",
                        style: TextStyle(
                          fontSize: 12.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          autoL4Count++; // Increase counter
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centers the text horizontally
                  children: [
                    Text(
                      "Coral L3",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16.0, // Adjust font size as needed
                        fontWeight:
                            FontWeight.bold, // Optional: Make the text bold
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Centers the text horizontally
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (autoL3Count > 0)
                            autoL3Count--; // Decrease counter but not below 0
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoL3Count",
                        style: TextStyle(
                          fontSize: 12.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          autoL3Count++; // Increase counter
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centers the text horizontally
                  children: [
                    Text(
                      "Coral L2",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16.0, // Adjust font size as needed
                        fontWeight:
                            FontWeight.bold, // Optional: Make the text bold
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Centers the text horizontally
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (autoL2Count > 0)
                            autoL2Count--; // Decrease counter but not below 0
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoL2Count",
                        style: TextStyle(
                          fontSize: 12.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          autoL2Count++; // Increase counter
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centers the text horizontally
                  children: [
                    Text(
                      "Coral Trough",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16.0, // Adjust font size as needed
                        fontWeight:
                            FontWeight.bold, // Optional: Make the text bold
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Centers the text horizontally
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (autoTroughCount > 0)
                            autoTroughCount--; // Decrease counter but not below 0
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoTroughCount",
                        style: TextStyle(
                          fontSize: 12.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          autoTroughCount++; // Increase counter
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centers the text horizontally
                  children: [
                    Text(
                      "Algae Processor",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16.0, // Adjust font size as needed
                        fontWeight:
                            FontWeight.bold, // Optional: Make the text bold
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Centers the text horizontally
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (autoProcessorCount > 0)
                            autoProcessorCount--; // Decrease counter but not below 0
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoProcessorCount",
                        style: TextStyle(
                          fontSize: 12.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          autoProcessorCount++; // Increase counter
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centers the text horizontally
                  children: [
                    Text(
                      "Algae Net",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16.0, // Adjust font size as needed
                        fontWeight:
                            FontWeight.bold, // Optional: Make the text bold
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Centers the text horizontally
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (autoNetCount > 0)
                            autoNetCount--; // Decrease counter but not below 0
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "$autoNetCount",
                        style: TextStyle(
                          fontSize: 12.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          autoNetCount++; // Increase counter
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
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centers the text horizontally
                    children: [
                      Text(
                        "Teleop",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centers the text horizontally
                    children: [
                      Text(
                        "Coral L4",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Centers the text horizontally
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (teleL4Count > 0)
                              teleL4Count--; // Decrease counter but not below 0
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleL4Count",
                          style: TextStyle(
                            fontSize: 12.0, // Adjust font size as needed
                            fontWeight:
                                FontWeight.bold, // Optional: Make the text bold
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            teleL4Count++; // Increase counter
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centers the text horizontally
                    children: [
                      Text(
                        "Coral L3",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Centers the text horizontally
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (teleL3Count > 0)
                              teleL3Count--; // Decrease counter but not below 0
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleL3Count",
                          style: TextStyle(
                            fontSize: 12.0, // Adjust font size as needed
                            fontWeight:
                                FontWeight.bold, // Optional: Make the text bold
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            teleL3Count++; // Increase counter
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centers the text horizontally
                    children: [
                      Text(
                        "Coral L2",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Centers the text horizontally
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (teleL2Count > 0)
                              teleL2Count--; // Decrease counter but not below 0
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleL2Count",
                          style: TextStyle(
                            fontSize: 12.0, // Adjust font size as needed
                            fontWeight:
                                FontWeight.bold, // Optional: Make the text bold
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            teleL2Count++; // Increase counter
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centers the text horizontally
                    children: [
                      Text(
                        "Coral Trough",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Centers the text horizontally
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (teleTroughCount > 0)
                              teleTroughCount--; // Decrease counter but not below 0
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleTroughCount",
                          style: TextStyle(
                            fontSize: 12.0, // Adjust font size as needed
                            fontWeight:
                                FontWeight.bold, // Optional: Make the text bold
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            teleTroughCount++; // Increase counter
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centers the text horizontally
                    children: [
                      Text(
                        "Algae Processor",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Centers the text horizontally
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (teleProcessorCount > 0)
                              teleProcessorCount--; // Decrease counter but not below 0
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleProcessorCount",
                          style: TextStyle(
                            fontSize: 12.0, // Adjust font size as needed
                            fontWeight:
                                FontWeight.bold, // Optional: Make the text bold
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            teleProcessorCount++; // Increase counter
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centers the text horizontally
                    children: [
                      Text(
                        "Algae Net",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16.0, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Centers the text horizontally
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (teleNetCount > 0)
                              teleNetCount--; // Decrease counter but not below 0
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "$teleNetCount",
                          style: TextStyle(
                            fontSize: 12.0, // Adjust font size as needed
                            fontWeight:
                                FontWeight.bold, // Optional: Make the text bold
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            teleNetCount++; // Increase counter
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
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8.0, // Add a shadow to the card
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16.0), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Climb Level', // Title header
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            height: 16.0), // Space between title and options
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
                          title: const Text('Shallow'),
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
                          title: const Text('Deep'),
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
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width:
                      double.infinity, // Makes the button span the full width
                  height: 50.0, // Button height
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.amber, // Amber color for the button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        formatData();
                      });
                    },
                    child: const Text(
                      'Update QR Code',
                      style: TextStyle(
                        color: Colors.black, // Black text for contrast
                        fontSize: 18.0, // Font size for the text
                        fontWeight: FontWeight.bold, // Bold text
                      ),
                    ),
                  ),
                ),
              ),
              QrImageView(
                data: data, // The data you want to encode
                size: 200.0, // Size of the QR code
                version: QrVersions
                    .auto, // Automatically selects the QR code version
                backgroundColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width:
                      double.infinity, // Makes the button span the full width
                  height: 50.0, // Button height
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.amber, // Amber color for the button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                      ),
                    ),
                    onPressed: () {
                      // Define the button action here
                      resetData();
                    },
                    child: const Text(
                      'Clear Data',
                      style: TextStyle(
                        color: Colors.black, // Black text for contrast
                        fontSize: 18.0, // Font size for the text
                        fontWeight: FontWeight.bold, // Bold text
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ][currentPageIndex],
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     //
      //     // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
      //     // action in the IDE, or press "p" in the console), to see the
      //     // wireframe for each widget.
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
