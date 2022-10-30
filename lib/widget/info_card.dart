import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  

  const InfoCardWidget({
    Key? key,
    required this.serverUrlText,required this.readerText,
  }) : super(key: key);
  final String serverUrlText;
  final String readerText;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Server Url: $serverUrlText', textAlign: TextAlign.center),
            Text('Access Point: $readerText', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
