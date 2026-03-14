class HolyDayModel {
  OrgInfo? orgInfo;
  List<Holiday>? holiday;

  HolyDayModel({this.orgInfo, this.holiday});

  HolyDayModel.fromJson(Map<String, dynamic> json) {
    orgInfo = json['org_info'] != null
        ? OrgInfo.fromJson(json['org_info'])
        : null;
    if (json['holiday'] != null) {
      holiday = <Holiday>[];
      json['holiday'].forEach((v) {
        holiday!.add(Holiday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orgInfo != null) {
      data['org_info'] = orgInfo!.toJson();
    }
    if (holiday != null) {
      data['holiday'] = holiday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrgInfo {
  int? id;
  String? systemName;
  String? systemTitle;
  String? logo;
  String? bannerImage;
  String? signature;
  String? address;
  String? phone;
  String? email;
  String? currency;
  String? language;
  String? poweredBy;
  String? website;
  int? theme;
  int? softwareStatus;
  String? mapLink;
  String? fbPageLink;
  int? userId;
  int? status;
  String? createdAt;
  String? updatedAt;

  OrgInfo(
      {this.id,
        this.systemName,
        this.systemTitle,
        this.logo,
        this.bannerImage,
        this.signature,
        this.address,
        this.phone,
        this.email,
        this.currency,
        this.language,
        this.poweredBy,
        this.website,
        this.theme,
        this.softwareStatus,
        this.mapLink,
        this.fbPageLink,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt});

  OrgInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systemName = json['system_name'];
    systemTitle = json['system_title'];
    logo = json['logo'];
    bannerImage = json['banner_image'];
    signature = json['signature'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    currency = json['currency'];
    language = json['language'];
    poweredBy = json['powered_by'];
    website = json['website'];
    theme = json['theme'];
    softwareStatus = json['software_status'];
    mapLink = json['map_link'];
    fbPageLink = json['fb_page_link'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['system_name'] = systemName;
    data['system_title'] = systemTitle;
    data['logo'] = logo;
    data['banner_image'] = bannerImage;
    data['signature'] = signature;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['currency'] = currency;
    data['language'] = language;
    data['powered_by'] = poweredBy;
    data['website'] = website;
    data['theme'] = theme;
    data['software_status'] = softwareStatus;
    data['map_link'] = mapLink;
    data['fb_page_link'] = fbPageLink;
    data['user_id'] = userId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Holiday {
  int? id;
  String? holiday;
  String? day;
  String? date;
  int? noOfDays;
  int? status;
  String? createdAt;
  String? updatedAt;

  Holiday(
      {this.id,
        this.holiday,
        this.day,
        this.date,
        this.noOfDays,
        this.status,
        this.createdAt,
        this.updatedAt});

  Holiday.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    holiday = json['holiday'];
    day = json['day'];
    date = json['date'];
    noOfDays = json['no_of_days'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['holiday'] = holiday;
    data['day'] = day;
    data['date'] = date;
    data['no_of_days'] = noOfDays;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
