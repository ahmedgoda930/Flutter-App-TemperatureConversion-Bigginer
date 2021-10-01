import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double inTemp = 0.0, outTemp = 0.0;
  int val = 1; //1 Fh - 2 Cel
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Input you temperatue here",
                  labelText: val == 1
                      ? "you entered $inTemp in fahrenhiet"
                      : "you entered $inTemp in Celsius",
                ),
                validator: (String? value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.replaceAll(' ', '') == '') {
                    return 'Please Enter temperatue';
                  }
                  return null;
                },
                onChanged: (value) {
                  try {
                    inTemp = double.parse(value);
                    setState(() {
                      if (inTemp != 0) {
                        print(value);
                        outTemp = val == 1
                            ? (inTemp - 32) / (5 / 6)
                            : (inTemp - 9 / 5) + 32;
                      }
                    });
                  } catch (e) {}
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: Radio(
                        value: 1,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value as int;
                          });
                        },
                      ),
                      title: Text('FH'),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: Radio(
                        value: 2,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = value as int;
                          });
                        },
                      ),
                      title: Text('Cel'),
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('Congratulations')));
                    outTemp = val == 1
                        ? (inTemp - 32) / (5 / 6)
                        : (inTemp - 9 / 5) + 32;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('The Result'),
                        content: val == 1
                            ? Text('$inTemp Fah = $outTemp Celsius')
                            : Text('$inTemp Celsius = $outTemp Fah'),
                      ),
                    );
                  }
                },
                child: Text('Convert'),
              ),
              Text('Result = $outTemp ' + (val == 1 ? 'Celsius' : 'Fah')),
            ],
          ),
        ),
      ),
    );
  }
}
