// To parse this JSON data, do
//
//     final promotionObject = promotionObjectFromJson(jsonString);

import 'dart:convert';

PromotionObject promotionObjectFromJson(String str) => PromotionObject.fromJson(json.decode(str));

String promotionObjectToJson(PromotionObject data) => json.encode(data.toJson());

class PromotionObject {
    List<dynamic> promotionMetromall;
    List<PromotionMrtcaed> promotionMrtcaed;
    bool isSuccess;
    int errCode;
    bool isShowErrCode;
    String errMessage;
    String technicalErrMessage;

    PromotionObject({
        this.promotionMetromall,
        this.promotionMrtcaed,
        this.isSuccess,
        this.errCode,
        this.isShowErrCode,
        this.errMessage,
        this.technicalErrMessage,
    });

    factory PromotionObject.fromJson(Map<String, dynamic> json) => PromotionObject(
        promotionMetromall: List<dynamic>.from(json["promotion_metromall"].map((x) => x)),
        promotionMrtcaed: List<PromotionMrtcaed>.from(json["promotion_mrtcaed"].map((x) => PromotionMrtcaed.fromJson(x))),
        isSuccess: json["isSuccess"],
        errCode: json["errCode"],
        isShowErrCode: json["isShow_ErrCode"],
        errMessage: json["errMessage"],
        technicalErrMessage: json["technicalErrMessage"],
    );

    Map<String, dynamic> toJson() => {
        "promotion_metromall": List<dynamic>.from(promotionMetromall.map((x) => x)),
        "promotion_mrtcaed": List<dynamic>.from(promotionMrtcaed.map((x) => x.toJson())),
        "isSuccess": isSuccess,
        "errCode": errCode,
        "isShow_ErrCode": isShowErrCode,
        "errMessage": errMessage,
        "technicalErrMessage": technicalErrMessage,
    };
}

class PromotionMrtcaed {
    int promotionId;
    String stationCode;
    String promotionCover;
    String promotionTitle;
    String promotionDate;
    String promotionDetail;

    PromotionMrtcaed({
        this.promotionId,
        this.stationCode,
        this.promotionCover,
        this.promotionTitle,
        this.promotionDate,
        this.promotionDetail,
    });

    factory PromotionMrtcaed.fromJson(Map<String, dynamic> json) => PromotionMrtcaed(
        promotionId: json["promotionId"],
        stationCode: json["stationCode"],
        promotionCover: json["promotion_Cover"],
        promotionTitle: json["promotion_Title"],
        promotionDate: json["promotion_Date"],
        promotionDetail: json["promotion_Detail"],
    );

    Map<String, dynamic> toJson() => {
        "promotionId": promotionId,
        "stationCode": stationCode,
        "promotion_Cover": promotionCover,
        "promotion_Title": promotionTitle,
        "promotion_Date": promotionDate,
        "promotion_Detail": promotionDetail,
    };
}
