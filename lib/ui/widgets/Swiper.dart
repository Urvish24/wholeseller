import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';



class Swipera extends StatelessWidget {
  List<String> imgList;


  Swipera({this.imgList});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height / 3 - 50,
      width: MediaQuery.of(context).size.width,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            imgList[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: imgList.length,
        autoplay: true,
        viewportFraction: 1,
        scale: 0.9,
        loop: false,
        autoplayDelay: 15000,
      ),
    );
  }
}
