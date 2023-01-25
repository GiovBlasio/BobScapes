import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.title,
    required this.time,
    Key? key,
  }) : super(key: key);

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 8,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            //height: 350,
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(15),
                horizontal: getProportionateScreenWidth(15)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //color: Colors.blue,
                  padding:
                      EdgeInsets.only(left: getProportionateScreenWidth(65)),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 8,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          color: Colors.grey,
                          height: getProportionateScreenHeight(150),
                          width: double.infinity,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Container(
                    // color: Colors.green,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          shape: const CircleBorder(),
                          elevation: 8,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(8),
                                vertical: getProportionateScreenHeight(8)),
                            child: Icon(
                              Icons.volume_up_outlined,
                              size: getProportionateScreenWidth(22),
                            ),
                          ),
                        ),
                        Container(
                          //width: 245,
                          margin: EdgeInsets.only(
                              left: getProportionateScreenWidth(25)),
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14)),
                              ),
                              Text(
                                time,
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(10)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
