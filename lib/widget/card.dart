import 'package:flutter/material.dart';

import 'package:news_app/utilities/constants.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {Key? key,
      required this.image,
      required this.title,
      required this.date,
      required this.time,
       this.onpress,
       this.icon,
      })
      : super(key: key);
  final String? image;
  final String? title;
  final String date;
  final String time;
  final VoidCallback? onpress;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kBackgroundColor,
      ),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image ??
                      'https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg'),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 140,
                  child: Text(
                    title ?? 'No Title',
                    style: kTitleStyle,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width-140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            DateTime.parse(time).hour.toString() +
                                ':' +
                                DateTime.parse(time).minute.toString() +
                                'am',
                            style: kDateStyle,
                          ),
                          
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.black54,
                          ),
                          Text(
                            DateTime.parse(date).day.toString() +
                                '/' +
                                DateTime.parse(date).month.toString() +
                                '/' +
                                DateTime.parse(date).year.toString(),
                            style: kDateStyle,
                          ),
                          IconButton(onPressed:onpress , icon: icon??Icon(null))
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
