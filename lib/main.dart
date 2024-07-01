import 'package:flutter/material.dart';
import 'package:screen_shot_example/custom_ss.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<MyHomePage> {
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Create and Download PDF from Widgets'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                List<Widget> widgets = [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    child: Center(child: Text('Widget 1')),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.green,
                    child: Center(child: Text('Widget 2')),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                    child: Center(child: Text('Widget 3')),
                  ),
                ];

                setState(() {
                  loader = true;
                });

                await CustomSS().createAndDownloadPdf(widgets);
                setState(() {
                  loader = false;
                });
              },
              child: Text('Create PDF'),
            ),
          ),
          if (loader)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}
