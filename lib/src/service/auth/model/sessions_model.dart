class SessionsModel {
  int? id;
  String? year;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  SessionsModel(
      {this.id,
        this.year,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  SessionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['status'] = status;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
