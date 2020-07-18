// To parse this JSON data, do
//
//     final mainPageObject = mainPageObjectFromJson(jsonString);

import 'dart:convert';

MainPageObject mainPageObjectFromJson(String str) =>
    MainPageObject.fromJson(json.decode(str));

String mainPageObjectToJson(MainPageObject data) => json.encode(data.toJson());

class MainPageObject {
  String colorMenu;
  Popup popup;
  List<Popup> adslist;
  List<Newslist> newslist;
  List<dynamic> promotionlist;
  List<Vdolist> vdolist;
  List<Landmarklist> landmarklist;
  bool isSuccess;
  int errCode;
  bool isShowErrCode;
  String errMessage;
  String technicalErrMessage;

  MainPageObject({
    this.colorMenu,
    this.popup,
    this.adslist,
    this.newslist,
    this.promotionlist,
    this.vdolist,
    this.landmarklist,
    this.isSuccess,
    this.errCode,
    this.isShowErrCode,
    this.errMessage,
    this.technicalErrMessage,
  });

  factory MainPageObject.fromJson(Map<String, dynamic> json) => MainPageObject(
        colorMenu: json["colorMenu"],
        popup: Popup.fromJson(json["popup"]),
        adslist:
            List<Popup>.from(json["adslist"].map((x) => Popup.fromJson(x))),
        newslist: List<Newslist>.from(
            json["newslist"].map((x) => Newslist.fromJson(x))),
        promotionlist: List<dynamic>.from(json["promotionlist"].map((x) => x)),
        vdolist:
            List<Vdolist>.from(json["vdolist"].map((x) => Vdolist.fromJson(x))),
        landmarklist: List<Landmarklist>.from(
            json["landmarklist"].map((x) => Landmarklist.fromJson(x))),
        isSuccess: json["isSuccess"],
        errCode: json["errCode"],
        isShowErrCode: json["isShow_ErrCode"],
        errMessage: json["errMessage"],
        technicalErrMessage: json["technicalErrMessage"],
      );

  Map<String, dynamic> toJson() => {
        "colorMenu": colorMenu,
        "popup": popup.toJson(),
        "adslist": List<dynamic>.from(adslist.map((x) => x.toJson())),
        "newslist": List<dynamic>.from(newslist.map((x) => x.toJson())),
        "promotionlist": List<dynamic>.from(promotionlist.map((x) => x)),
        "vdolist": List<dynamic>.from(vdolist.map((x) => x.toJson())),
        "landmarklist": List<dynamic>.from(landmarklist.map((x) => x.toJson())),
        "isSuccess": isSuccess,
        "errCode": errCode,
        "isShow_ErrCode": isShowErrCode,
        "errMessage": errMessage,
        "technicalErrMessage": technicalErrMessage,
      };
}

class Popup {
  int adsId;
  String adsCover;
  String adsTitle;
  String adsDate;
  String adsDetail;

  Popup({
    this.adsId,
    this.adsCover,
    this.adsTitle,
    this.adsDate,
    this.adsDetail,
  });

  factory Popup.fromJson(Map<String, dynamic> json) => Popup(
        adsId: json["adsId"],
        adsCover: json["ads_Cover"],
        adsTitle: json["ads_Title"],
        adsDate: json["ads_Date"],
        adsDetail: json["ads_Detail"],
      );

  Map<String, dynamic> toJson() => {
        "adsId": adsId,
        "ads_Cover": adsCover,
        "ads_Title": adsTitle,
        "ads_Date": adsDate,
        "ads_Detail": adsDetail,
      };
}

class Landmarklist {
  int landId;
  int landmarkType;
  String categoryIcon;
  String line;
  String stationCode;
  String stationName;
  bool isRevenue;
  String landmarkCover;
  String landmarkName;
  String landmarkNear;
  String landmarkJourney;
  String landmarkDetail;
  String landmarkLatitude;
  String landmarkLongitude;
  String exit;
  List<Imagelist> imagelist;

  Landmarklist({
    this.landId,
    this.landmarkType,
    this.categoryIcon,
    this.line,
    this.stationCode,
    this.stationName,
    this.isRevenue,
    this.landmarkCover,
    this.landmarkName,
    this.landmarkNear,
    this.landmarkJourney,
    this.landmarkDetail,
    this.landmarkLatitude,
    this.landmarkLongitude,
    this.exit,
    this.imagelist,
  });

  factory Landmarklist.fromJson(Map<String, dynamic> json) => Landmarklist(
        landId: json["landId"],
        landmarkType: json["landmark_Type"],
        categoryIcon: json["category_Icon"],
        line: json["line"],
        stationCode: json["stationCode"],
        stationName: json["stationName"],
        isRevenue: json["isRevenue"],
        landmarkCover: json["landmark_Cover"],
        landmarkName: json["landmark_Name"],
        landmarkNear: json["landmark_Near"],
        landmarkJourney: json["landmark_Journey"],
        landmarkDetail: json["landmark_Detail"],
        landmarkLatitude: json["landmark_Latitude"],
        landmarkLongitude: json["landmark_Longitude"],
        exit: json["exit"],
        imagelist: List<Imagelist>.from(
            json["imagelist"].map((x) => Imagelist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "landId": landId,
        "landmark_Type": landmarkType,
        "category_Icon": categoryIcon,
        "line": line,
        "stationCode": stationCode,
        "stationName": stationName,
        "isRevenue": isRevenue,
        "landmark_Cover": landmarkCover,
        "landmark_Name": landmarkName,
        "landmark_Near": landmarkNear,
        "landmark_Journey": landmarkJourney,
        "landmark_Detail": landmarkDetail,
        "landmark_Latitude": landmarkLatitude,
        "landmark_Longitude": landmarkLongitude,
        "exit": exit,
        "imagelist": List<dynamic>.from(imagelist.map((x) => x.toJson())),
      };
}

class Imagelist {
  String landmarkImage;

  Imagelist({
    this.landmarkImage,
  });

  factory Imagelist.fromJson(Map<String, dynamic> json) => Imagelist(
        landmarkImage: json["landmark_Image"],
      );

  Map<String, dynamic> toJson() => {
        "landmark_Image": landmarkImage,
      };
}

class Newslist {
  int newsId;
  String newsCover;
  String newsTitle;
  String newsDate;
  String newsDetail;

  Newslist({
    this.newsId,
    this.newsCover,
    this.newsTitle,
    this.newsDate,
    this.newsDetail,
  });

  factory Newslist.fromJson(Map<String, dynamic> json) => Newslist(
        newsId: json["newsId"],
        newsCover: json["news_Cover"],
        newsTitle: json["news_Title"],
        newsDate: json["news_Date"],
        newsDetail: json["news_Detail"],
      );

  Map<String, dynamic> toJson() => {
        "newsId": newsId,
        "news_Cover": newsCover,
        "news_Title": newsTitle,
        "news_Date": newsDate,
        "news_Detail": newsDetail,
      };
}

class Vdolist {
  int vdoId;
  String vdoCover;
  String vdoTitle;
  String vdoUrl;
  String vdoUpdate;

  Vdolist({
    this.vdoId,
    this.vdoCover,
    this.vdoTitle,
    this.vdoUrl,
    this.vdoUpdate,
  });

  factory Vdolist.fromJson(Map<String, dynamic> json) => Vdolist(
        vdoId: json["vdoId"],
        vdoCover: json["vdo_Cover"],
        vdoTitle: json["vdo_Title"],
        vdoUrl: json["vdo_Url"],
        vdoUpdate: json["vdo_update"],
      );

  Map<String, dynamic> toJson() => {
        "vdoId": vdoId,
        "vdo_Cover": vdoCover,
        "vdo_Title": vdoTitle,
        "vdo_Url": vdoUrl,
        "vdo_update": vdoUpdate,
      };
}
