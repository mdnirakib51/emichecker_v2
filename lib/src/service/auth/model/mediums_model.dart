class MediumsModel {
  int? id;
  String? mediumName;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  MediumsModel(
      {this.id,
        this.mediumName,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  MediumsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediumName = json['medium_name'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medium_name'] = mediumName;
    data['status'] = status;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
