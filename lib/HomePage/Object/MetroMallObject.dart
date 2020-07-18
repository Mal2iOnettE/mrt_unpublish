// To parse this JSON data, do
//
//     final metroMallObject = metroMallObjectFromJson(jsonString);

import 'dart:convert';

MetroMallObject metroMallObjectFromJson(String str) => MetroMallObject.fromJson(json.decode(str));

String metroMallObjectToJson(MetroMallObject data) => json.encode(data.toJson());

class MetroMallObject {
    List<dynamic> promotionlist;
    List<Linelist> linelist;
    bool isSuccess;
    int errCode;
    bool isShowErrCode;
    String errMessage;
    String technicalErrMessage;

    MetroMallObject({
        this.promotionlist,
        this.linelist,
        this.isSuccess,
        this.errCode,
        this.isShowErrCode,
        this.errMessage,
        this.technicalErrMessage,
    });

    factory MetroMallObject.fromJson(Map<String, dynamic> json) => MetroMallObject(
        promotionlist: List<dynamic>.from(json["promotionlist"].map((x) => x)),
        linelist: List<Linelist>.from(json["linelist"].map((x) => Linelist.fromJson(x))),
        isSuccess: json["isSuccess"],
        errCode: json["errCode"],
        isShowErrCode: json["isShow_ErrCode"],
        errMessage: json["errMessage"],
        technicalErrMessage: json["technicalErrMessage"],
    );

    Map<String, dynamic> toJson() => {
        "promotionlist": List<dynamic>.from(promotionlist.map((x) => x)),
        "linelist": List<dynamic>.from(linelist.map((x) => x.toJson())),
        "isSuccess": isSuccess,
        "errCode": errCode,
        "isShow_ErrCode": isShowErrCode,
        "errMessage": errMessage,
        "technicalErrMessage": technicalErrMessage,
    };
}

class Linelist {
    String line;
    List<Stationlist> stationlist;

    Linelist({
        this.line,
        this.stationlist,
    });

    factory Linelist.fromJson(Map<String, dynamic> json) => Linelist(
        line: json["line"],
        stationlist: List<Stationlist>.from(json["stationlist"].map((x) => Stationlist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "line": line,
        "stationlist": List<dynamic>.from(stationlist.map((x) => x.toJson())),
    };
}

class Stationlist {
    String stationCode;
    String stationName;
    String pinX;
    String pinY;
    String latitude;
    String longitude;
    String line;
    List<Malllist> malllist;

    Stationlist({
        this.stationCode,
        this.stationName,
        this.pinX,
        this.pinY,
        this.latitude,
        this.longitude,
        this.line,
        this.malllist,
    });

    factory Stationlist.fromJson(Map<String, dynamic> json) => Stationlist(
        stationCode: json["stationCode"],
        stationName: json["stationName"],
        pinX: json["pinX"],
        pinY: json["pinY"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        line: json["line"],
        malllist: List<Malllist>.from(json["malllist"].map((x) => Malllist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "stationCode": stationCode,
        "stationName": stationName,
        "pinX": pinX,
        "pinY": pinY,
        "latitude": latitude,
        "longitude": longitude,
        "line": line,
        "malllist": List<dynamic>.from(malllist.map((x) => x.toJson())),
    };
}

class Malllist {
    String mallIcon;
    String mallTitle;

    Malllist({
        this.mallIcon,
        this.mallTitle,
    });

    factory Malllist.fromJson(Map<String, dynamic> json) => Malllist(
        mallIcon: json["mall_Icon"],
        mallTitle: json["mall_Title"],
    );

    Map<String, dynamic> toJson() => {
        "mall_Icon": mallIcon,
        "mall_Title": mallTitle,
    };
}
