import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class sendMsg extends StatelessWidget {
  const sendMsg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: message(
          tile: '',
          extra: '',
          total: '',
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class message extends StatefulWidget {
  String tile;
  String extra;
  String total;
  message(
      {required this.tile,
      required this.extra,
      required this.total,
      super.key});

  @override
  State<message> createState() => _messageState();
}

class _messageState extends State<message> {
  TextEditingController _num = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Message'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: TextField(
                  controller: _num,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Mobile Number",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  int phone = int.parse(_num.text);
                  String message = "Tiles: ${widget.tile}\n"
                      "Extra Tiles Needed: ${widget.extra}\n"
                      "Total Tiles Required: ${widget.total}";
                  Uri sms = Uri.parse("sms:$phone?body=$message");
                  if (await launchUrl(sms)) {
                  } else {}
                },
                child: Text(
                  'Send via SMS',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  int phone = int.parse(_num.text);
                  String country = '+91';
                  String message = "Tiles: ${widget.tile}\n"
                      "Extra Tiles Needed: ${widget.extra}\n"
                      "Total Tiles Required: ${widget.total}";
                  Uri whts = Uri.parse(
                      "whatsapp://send?phone=$country$phone&text=${Uri.encodeComponent(message)}");
                  if (await launchUrl(whts)) { 
                  } else {}
                },
                child: Text(
                  'Send via Whatsaap',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
