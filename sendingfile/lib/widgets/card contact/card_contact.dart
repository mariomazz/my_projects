import 'package:flutter/material.dart';

class CardContact extends StatelessWidget {
  CardContact({
    Key? key,
    this.date,
    this.primaryText,
    this.secondaryText,
    this.image,
  }) : super(key: key);

  NetworkImage? image;
  String? primaryText;
  String? secondaryText;
  String? date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: image ??
                        NetworkImage(
                            'https://media.istockphoto.com/vectors/error-page-dead-emoji-illustration-vector-id1095047472?k=20&m=1095047472&s=612x612&w=0&h=1lDW_CWDLYwOUO7tAsLHnXTSwuvcWqWq4rysM1y6-E8='),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      primaryText ?? "null contact",
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      secondaryText ?? "null message",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18, color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    date ?? "0:0",
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
