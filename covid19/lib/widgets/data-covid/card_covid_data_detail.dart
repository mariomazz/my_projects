import 'package:flutter/material.dart';
import 'package:fluttercovid19/widgets/shared/roundend_card.dart';

class CardDetailData extends StatelessWidget {
  CardDetailData(
      {Key? key,
      required this.data,
      required this.title,
      this.backgroundColor,
      this.margin})
      : super(key: key);
  String data;
  String title;
  Color? backgroundColor;
  EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    var dataLayout = MediaQuery.of(context);
    return Container(
      margin: margin ?? EdgeInsets.all(20),
      child: RoundedCard(
        elevation: 0,
        backgroundColor: backgroundColor ?? Color.fromRGBO(255, 255, 141, 1),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${title}',
                  style: TextStyle(
                    fontSize: ((20 * dataLayout.size.width) / 426 < 52)
                        ? (20 * dataLayout.size.width) / 426
                        : 52,
                  ),
                ),
                Text(
                  '${data.replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  style: TextStyle(
                    fontSize: ((40 * dataLayout.size.width) / 426 < 70)
                        ? (40 * dataLayout.size.width) / 426
                        : 70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.show_chart,
                      size: (((30 * dataLayout.size.width) / 426) < 100)
                          ? (30 * dataLayout.size.width) / 426
                          : 100,
                    ),
                    Text(
                      'data',
                      style: TextStyle(
                        fontSize: ((20 * dataLayout.size.width) / 426 < 70)
                            ? (20 * dataLayout.size.width) / 426
                            : 70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.people_alt,
              size: (((60 * dataLayout.size.width) / 426) < 100)
                  ? (60 * dataLayout.size.width) / 426
                  : 100,
            ),
          ],
        ),
      ),
    );
  }
}
