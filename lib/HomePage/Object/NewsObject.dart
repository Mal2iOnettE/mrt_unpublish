// To parse this JSON data, do
//
//     final newsPageObject = newsPageObjectFromJson(jsonString);

import 'dart:convert';

NewsPageObject newsPageObjectFromJson(String str) => NewsPageObject.fromJson(json.decode(str));

String newsPageObjectToJson(NewsPageObject data) => json.encode(data.toJson());

class NewsPageObject {
    List<Newslist> newslist;
    bool isSuccess;
    int errCode;
    bool isShowErrCode;
    String errMessage;
    String technicalErrMessage;

    NewsPageObject({
        this.newslist,
        this.isSuccess,
        this.errCode,
        this.isShowErrCode,
        this.errMessage,
        this.technicalErrMessage,
    });

    factory NewsPageObject.fromJson(Map<String, dynamic> json) => NewsPageObject(
        newslist: List<Newslist>.from(json["newslist"].map((x) => Newslist.fromJson(x))),
        isSuccess: json["isSuccess"],
        errCode: json["errCode"],
        isShowErrCode: json["isShow_ErrCode"],
        errMessage: json["errMessage"],
        technicalErrMessage: json["technicalErrMessage"],
    );

    Map<String, dynamic> toJson() => {
        "newslist": List<dynamic>.from(newslist.map((x) => x.toJson())),
        "isSuccess": isSuccess,
        "errCode": errCode,
        "isShow_ErrCode": isShowErrCode,
        "errMessage": errMessage,
        "technicalErrMessage": technicalErrMessage,
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
