import 'package:flutter/material.dart';

class AvailableCarTile extends StatelessWidget {
  const AvailableCarTile(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.brandUrl,
      required this.price})
      : super(key: key);
  final String title;
  final String imageUrl;
  final String brandUrl;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 4.0, offset: Offset(4, 8)),
        ], color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0)),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Flexible(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w700),
                      ),
                      Container(height: 20, child: Image.asset(brandUrl)),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0)),
                                color: Theme.of(context).primaryColor),
                            child: Center(
                              child: Text(
                                price,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
