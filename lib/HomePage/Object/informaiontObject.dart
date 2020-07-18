// To parse this JSON data, do
//
//     final infomationObject = infomationObjectFromJson(jsonString);

import 'dart:convert';

InfomationObject infomationObjectFromJson(String str) => InfomationObject.fromJson(json.decode(str));

String infomationObjectToJson(InfomationObject data) => json.encode(data.toJson());

class InfomationObject {
    List<Menulist> menulist;
    bool isSuccess;
    int errCode;
    bool isShowErrCode;
    String errMessage;
    String technicalErrMessage;

    InfomationObject({
        this.menulist,
        this.isSuccess,
        this.errCode,
        this.isShowErrCode,
        this.errMessage,
        this.technicalErrMessage,
    });

    factory InfomationObject.fromJson(Map<String, dynamic> json) => InfomationObject(
        menulist: List<Menulist>.from(json["menulist"].map((x) => Menulist.fromJson(x))),
        isSuccess: json["isSuccess"],
        errCode: json["errCode"],
        isShowErrCode: json["isShow_ErrCode"],
        errMessage: json["errMessage"],
        technicalErrMessage: json["technicalErrMessage"],
    );

    Map<String, dynamic> toJson() => {
        "menulist": List<dynamic>.from(menulist.map((x) => x.toJson())),
        "isSuccess": isSuccess,
        "errCode": errCode,
        "isShow_ErrCode": isShowErrCode,
        "errMessage": errMessage,
        "technicalErrMessage": technicalErrMessage,
    };
}

class Menulist {
    String bgCover;
    String icon;
    String title;
    String urlWebview;

    Menulist({
        this.bgCover,
        this.icon,
        this.title,
        this.urlWebview,
    });

    factory Menulist.fromJson(Map<String, dynamic> json) => Menulist(
        bgCover: json["bgCover"],
        icon: json["icon"],
        title: json["title"],
        urlWebview: json["url_Webview"],
    );

    Map<String, dynamic> toJson() => {
        "bgCover": bgCover,
        "icon": icon,
        "title": title,
        "url_Webview": urlWebview,
    };
}
