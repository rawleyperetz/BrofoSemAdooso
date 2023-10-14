import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

void main() {
  runApp(const RunApp());
}

class RunApp extends StatelessWidget {
  const RunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrofoSemAdooso',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner:
          false, //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class FirstPageApp extends StatelessWidget {
  const FirstPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            title: Text('BrofoSemAdooso', style: TextStyle(fontSize: 18))),
        body: Center(
            child: Container(
          width: screenWidth * 0.7,
          height: screenHeight * 0.5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WriterSide()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    child:
                        const Text('Writer', style: TextStyle(fontSize: 18))),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReaderSide()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    child: const Text(
                      'Reader',
                      style: TextStyle(fontSize: 18),
                    )),
              ]),
        )));
  }
}

enum MenuItem {
  item1,
  item2,
  item3,
}

class WriterSide extends StatelessWidget {
  const WriterSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BrofoSemAdooso'),
        actions: [
          PopupMenuButton<MenuItem>(
              onSelected: (value) {
                if (value == MenuItem.item1) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                } else {
                  print(value);
                }
              },
              itemBuilder: (context) => const [
                    PopupMenuItem(
                        child: Text("Reader's Mode"), value: MenuItem.item1),
                    PopupMenuItem(
                        child: Text('Settings'), value: MenuItem.item2),
                    PopupMenuItem(child: Text('About'), value: MenuItem.item3),
                  ]),
        ],
      ),
      body: Center(
          child: TextButton(
              onPressed: () {
                uploadPdf();
              },
              child: const Text("Upload PDF"))),
    );
  }

  Future uploadPdf() async {
    var dio = Dio();
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path ?? " ");
      String fileName = file.path.split('/').last;
      String filepath = file.path;

      FormData data = FormData.fromMap({
        'x-api-key': 'apikey',
        'file': await MultipartFile.fromFile(filepath, filename: fileName)
      });

      var response = dio.post("https://api.pdf.co/v1/file/upload", data: data,
          onSendProgress: (int sent, int total) {
        print('$sent $total');
      });
      print(response.toString());
    } else {
      print("Result is null");
    }
  }
}

class ReaderSide extends StatelessWidget {
  const ReaderSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BrofoSemAdooso'),
        actions: [
          PopupMenuButton<MenuItem>(
              onSelected: (value) {
                if (value == MenuItem.item1) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                } else {
                  print(value);
                }
              },
              itemBuilder: (context) => const [
                    PopupMenuItem(
                        child: Text("Writer's Mode"), value: MenuItem.item1),
                    PopupMenuItem(
                        child: Text('Settings'), value: MenuItem.item2),
                    PopupMenuItem(child: Text('About'), value: MenuItem.item3),
                  ]),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrofoSemAdooso',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner:
          false, //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:
          AppBar(title: Text('BrofoSemAdooso', style: TextStyle(fontSize: 18))),
      body: Center(
        child: Container(
          width: screenWidth * 0.7,
          height: screenHeight * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              UWidget(),
              const SizedBox(height: 20),
              PWidget(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FirstPageApp()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Text(
                  'Log In',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUP()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Username Field
class UWidget extends StatefulWidget {
  const UWidget({super.key});

  @override
  State<UWidget> createState() => _UWidgetState();
}

class _UWidgetState extends State<UWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person), labelText: "Enter email"),
    );
  }
}

//Password Field
class PWidget extends StatefulWidget {
  const PWidget({super.key});

  @override
  State<PWidget> createState() => _PWidgetState();
}

class _PWidgetState extends State<PWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock), labelText: "Enter password"),
    );
    ;
  }
}

// SignUP part
class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

// class _SignUPState extends State<SignUP> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

//SignUP part
class _SignUPState extends State<SignUP> {
  //StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String countryValue = "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
          AppBar(title: Text('BrofoSemAdooso', style: TextStyle(fontSize: 18))),
      body: Center(
        child: Container(
          width: screenWidth * 0.7,
          height: screenHeight * 0.5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                UserWidget(),
                const SizedBox(height: 20),
                UWidget(),
                const SizedBox(height: 20),
                PWidget(),
                const SizedBox(height: 20),
                CSCPicker(

                    ///Enable disable state dropdown [OPTIONAL PARAMETER]
                    showStates: false,

                    // /// Enable disable city drop down [OPTIONAL PARAMETER]
                    showCities: false,

                    ///Enable (get flat with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                    flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

                    ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.grey.shade300,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    ///selected item style [OPTIONAL PARAMETER]
                    selectedItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),

                    ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                    dropdownHeadingStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),

                    ///DropdownDialog Item style [OPTIONAL PARAMETER]
                    dropdownItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),

                    // ///Dialog box radius [OPTIONAL PARAMETER]
                    // dropdownDialogRadius: 10.0,

                    // ///Search bar radius [OPTIONAL PARAMETER]
                    // searchBarRadius: 10.0,

                    ///triggers once country selected in dropdown
                    onCountryChanged: (value) {
                      setState(() {
                        ///store value in country variable
                        countryValue = value;
                      });
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserWidget extends StatefulWidget {
  const UserWidget({super.key});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock), labelText: "Enter username"),
    );
    ;
  }
}

























// class TextInputWidget extends StatefulWidget {
//   const TextInputWidget({super.key});

//   @override
//   State<TextInputWidget> createState() => _TextInputWidgetState();
// }

// class _TextInputWidgetState extends State<TextInputWidget> {
//   final controller = TextEditingController();
//   String text = "";
//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }

//   void changeText(text) {
//     setState(() {
//       this.text = text;
//     });
//     //this.text = text;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       TextField(
//         controller: this.controller,
//         decoration: InputDecoration(
//             prefixIcon: Icon(Icons.message), labelText: "Type a message:"),
//         onChanged: (text) => changeText(text),
//       ),
//       Text(this.text)
//     ]);
//   }
// }
// // class TestWidget extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Text('Hello Word');
// //   }
// // }
