import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoadingScreen([this.title = 'please wait ']);
  static const id = '/loadingScreen';
  final String title;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  
  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        // Route route = MaterialPageRoute(builder: (context) => HomeScreen());
        // print(route.isCurrent);

        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    print('disposed');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as LoadingScreen;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color:const Color.fromARGB(255, 126, 218, 129),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                args.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                CircularProgressIndicator(
                  color: const Color.fromARGB(255, 16, 194, 120),
                  strokeWidth: 200,
                  value: controller.value,
                  semanticsLabel: 'Circular progress indicator',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
