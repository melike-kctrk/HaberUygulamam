import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class haberler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.amber,
      child: Center(
        child: Yazihareket(),
      ),
    );
  }
}

class Yazihareket extends StatefulWidget {
  @override
_YazihareketState createState() => _YazihareketState();
}

class _YazihareketState extends State<Yazihareket>
with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // ignore: unnecessary_statements
    super.initState();
     
      _controller = AnimationController(duration: Duration(seconds: 1), vsync: this);
      _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut)
        ..addListener(()=> this.setState(() {}))
        ..addStatusListener((durum) {
          debugPrint(durum.toString());
        });
      _controller.repeat();
    }

    @override
    void dispose() {
      super.dispose();
      _controller.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        child: Text(
          "Haberler",
          style: TextStyle(fontSize: 14.0 + _animation.value * 5),
      ),
      );
    }
}