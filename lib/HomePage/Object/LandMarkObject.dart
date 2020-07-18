// To parse this JSON data, do
//
//     final landMarkObject = landMarkObjectFromJson(jsonString);

import 'dart:convert';

LandMarkObject landMarkObjectFromJson(String str) => LandMarkObject.fromJson(json.decode(str));

String landMarkObjectToJson(LandMarkObject data) => json.encode(data.toJson());

class LandMarkObject {
    List<Landmarklist> landmarklist;
    bool isSuccess;
    int errCode;
    bool isShowErrCode;
    String errMessage;
    String technicalErrMessage;

    LandMarkObject({
        this.landmarklist,
        this.isSuccess,
        this.errCode,
        this.isShowErrCode,
        this.errMessage,
        this.technicalErrMessage,
    });

    factory LandMarkObject.fromJson(Map<String, dynamic> json) => LandMarkObject(
        landmarklist: List<Landmarklist>.from(json["landmarklist"].map((x) => Landmarklist.fromJson(x))),
        isSuccess: json["isSuccess"],
        errCode: json["errCode"],
        isShowErrCode: json["isShow_ErrCode"],
        errMessage: json["errMessage"],
        technicalErrMessage: json["technicalErrMessage"],
    );

    Map<String, dynamic> toJson() => {
        "landmarklist": List<dynamic>.from(landmarklist.map((x) => x.toJson())),
        "isSuccess": isSuccess,
        "errCode": errCode,
        "isShow_ErrCode": isShowErrCode,
        "errMessage": errMessage,
        "technicalErrMessage": technicalErrMessage,
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
        imagelist: List<Imagelist>.from(json["imagelist"].map((x) => Imagelist.fromJson(x))),
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
