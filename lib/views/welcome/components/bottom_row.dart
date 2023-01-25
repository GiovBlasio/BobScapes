import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';

class BottomRow extends StatelessWidget {
  const BottomRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: getProportionateScreenHeight(50),
        left: getProportionateScreenHeight(25),
        right: getProportionateScreenHeight(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SizedBox(
              width: 75,
              child: Text(
                "Quail Forever",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text("Landscape Partnership",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontStyle: FontStyle.italic)),
            ),
            SizedBox(
              width: 110,
              child: Text("Working Lands Wildlife",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontStyle: FontStyle.italic)),
            ),
          ],
        ));
  }
}
