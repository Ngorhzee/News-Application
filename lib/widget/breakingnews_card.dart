import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class BreakingNews extends StatelessWidget {
  const BreakingNews(
      {Key? key,
      required this.image,
      required this.title,
      required this.date,
      required this.author,
      required this.onpress,
      required this.icon,
      })
      : super(key: key);
  final String? image;
  final String? title;
  final String? author;
  final String date;
  final VoidCallback onpress;
  final Icon icon;
  //final String image;
  //final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image ??
                    'https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              title ?? 'No Title',
              style: kTitleStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  author ?? 'None',
                  style: kDateStyle,
                ),
                const Spacer(),
                Text(
                    DateTime.parse(date).day.toString() +
                        '/' +
                        DateTime.parse(date).month.toString() +
                        '/' +
                        DateTime.parse(date).year.toString() +
                        '   ' +
                        DateTime.parse(date).hour.toString() +
                        ':' +
                        DateTime.parse(date).minute.toString(),
                    style: kDateStyle),
              IconButton(
                    onPressed: onpress,
                    icon: icon
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
