class ShiftsModel {
  int? id;
  String? shiftName;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  ShiftsModel(
      {this.id,
        this.shiftName,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  ShiftsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shiftName = json['shift_name'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shift_name'] = shiftName;
    data['status'] = status;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
