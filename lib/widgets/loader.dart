import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shimmer/shimmer.dart';

const List<Color> _kDefaultRainbowColors = const [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

class Loader extends StatelessWidget {
  Loader(
      {this.opacity: 0.5, this.dismissibles: false, this.color: Colors.black});

  final double opacity;
  final bool dismissibles;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: const ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
            child: Container(
          height: MediaQuery.of(context).size.height * .2,
          child: const LoadingIndicator(
              indicatorType: Indicator.lineScale,
              colors: _kDefaultRainbowColors),
        )),
      ],
    );
  }
}

class ListViewLoader extends StatelessWidget {
  const ListViewLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer(
          period: Duration(seconds: 2), // duration of animation
          gradient: LinearGradient(
            colors: [
              Colors.grey[200]!,
              Colors.grey[400]!,
              Colors.grey[200]!,
            ],
            begin: Alignment(-1.0, -0.5),
            end: Alignment(1.0, 0.5),
            stops: [0.0, 0.5, 1.0],
          ),
          child: ListTile(
            leading: CircleAvatar(),
            title: Container(
              width: double.infinity,
              height: 16.0,
              color: Colors.grey,
            ),
            subtitle: Container(
              width: double.infinity,
              height: 10.0,
              margin: EdgeInsets.only(top: 8.0),
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
