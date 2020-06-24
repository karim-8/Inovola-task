import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:involatask/ViemModels/data_view_model.dart';
import 'package:involatask/models/data_response.dart';
import 'package:involatask/utilities/utilis_func.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  List<NetworkImage> data = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    //getData();
    ScreenScaler scaler = new ScreenScaler()..init(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: Consumer<DataViewModel>(
          builder: (context, model, child) {
            return model.data == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator()),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                        imageSlider(scaler, model.data),
                        courseDetails(model.data),
                        trainerInformation(model.data),
                        courseInformation(model.data),
                        courseCost(model.data),
                        reserveButton()
                      ]);
          },
        )),
      ),
    );
  }

  ///Image Slider part
  Widget imageSlider(ScreenScaler scaler, DataModel dataModel) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Carousel(
            autoplayDuration: Duration(seconds: 5),
            dotPosition: DotPosition.bottomLeft,
            dotBgColor: Colors.transparent,
            dotSize: 5,
            images: parseImageList(dataModel),
          ),

          ///Icons over image slider
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star_border,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.share, color: Colors.white)
                  ],
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white)
              ],
            ),
          )
        ],
      ),
    );
  }

  ///Course details
  Widget courseDetails(DataModel dataModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "${dataModel.interest}\#",
            style: UtilsFunctions().textStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "الاسم الكامل للدوره بشكل افترضي من اجل اظهار \n شكل التصميم   ",
            textDirection: TextDirection.rtl,
            style: UtilsFunctions().boldTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                UtilsFunctions().returnDate(dataModel.date),
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.calendar_today,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                dataModel.address,
                style: UtilsFunctions().textStyle,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.colorize,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            height: 1,
          )
        ],
      ),
    );
  }

  ///Trainer Information
  Widget trainerInformation(DataModel dataModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                dataModel.trainerName,
                style: UtilsFunctions().boldTextStyle,
              ),
              SizedBox(
                width: 10,
              ),

              ///Circle image view

              Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,

                          ///i've changed the link cause its not working
                          ///datamodel.trainerImg
                          image: NetworkImage(dataModel.img[0])))),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            dataModel.trainerInfo,
            style: UtilsFunctions().textStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            height: 1,
          ),
        ],
      ),
    );
  }

  ///About course
  Widget courseInformation(DataModel dataModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "عن الدوره",
            style: UtilsFunctions().boldTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            dataModel.occasionDetail,
            textDirection: TextDirection.rtl,
            style: UtilsFunctions().normalStyle,
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            height: 1,
          ),
        ],
      ),
    );
  }

  ///Course Cost
  Widget courseCost(DataModel dataModel) {
    dataModel.reservTypes.forEach((element) {
      count = element.count;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "تكلفة الدوره",
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 15),
          ),
          SizedBox(
            height: 15,
          ),

          /// To avoid redundancy we should get data for each item in api
          /// so we will make them static for now

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "$count SAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              Text(
                "الحجز العادي",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "$count SAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              Text(
                "الحجز المميز ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "$count SAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              Text(
                "الحجز السريع".trim(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  ///Reservation Button
  Widget reserveButton() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: () {},
        color: Colors.purple,
        child: Text(
          "قم بالحجز الان",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  //todo: put it in the View Model
  ///returning List of network images based on data model
  List<NetworkImage> parseImageList(DataModel dataModel) {
    for (int i = 0; i < dataModel.img.length; i++) {
      data.add(NetworkImage(dataModel.img[i]));
    }
    return data;
  }
}
