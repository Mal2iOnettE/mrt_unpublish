class AllVdoObject {
  List<Vdolist> vdolist;
  bool isSuccess;
  int errCode;
  bool isShowErrCode;
  String errMessage;
  String technicalErrMessage;

  AllVdoObject(
      {this.vdolist,
      this.isSuccess,
      this.errCode,
      this.isShowErrCode,
      this.errMessage,
      this.technicalErrMessage});

  AllVdoObject.fromJson(Map<String, dynamic> json) {
    if (json['vdolist'] != null) {
      vdolist = new List<Vdolist>();
      json['vdolist'].forEach((v) {
        vdolist.add(new Vdolist.fromJson(v));
      });
    }
    isSuccess = json['isSuccess'];
    errCode = json['errCode'];
    isShowErrCode = json['isShow_ErrCode'];
    errMessage = json['errMessage'];
    technicalErrMessage = json['technicalErrMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vdolist != null) {
      data['vdolist'] = this.vdolist.map((v) => v.toJson()).toList();
    }
    data['isSuccess'] = this.isSuccess;
    data['errCode'] = this.errCode;
    data['isShow_ErrCode'] = this.isShowErrCode;
    data['errMessage'] = this.errMessage;
    data['technicalErrMessage'] = this.technicalErrMessage;
    return data;
  }
}

class Vdolist {
  int vdoId;
  String vdoCover;
  String vdoTitle;
  String vdoUrl;
  String vdoUpdate;

  Vdolist(
      {this.vdoId, this.vdoCover, this.vdoTitle, this.vdoUrl, this.vdoUpdate});

  Vdolist.fromJson(Map<String, dynamic> json) {
    vdoId = json['vdoId'];
    vdoCover = json['vdo_Cover'];
    vdoTitle = json['vdo_Title'];
    vdoUrl = json['vdo_Url'];
    vdoUpdate = json['vdo_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vdoId'] = this.vdoId;
    data['vdo_Cover'] = this.vdoCover;
    data['vdo_Title'] = this.vdoTitle;
    data['vdo_Url'] = this.vdoUrl;
    data['vdo_update'] = this.vdoUpdate;
    return data;
  }
}