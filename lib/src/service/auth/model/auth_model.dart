class AuthModel {
  String? role;
  User? user;
  String? token;

  AuthModel({this.role, this.user, this.token});

  AuthModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  int? id;
  String? teacherCode;
  String? type;
  int? dormitoryId;
  int? shiftId;
  String? subject;
  String? joiningDate;
  String? designation;
  String? name;
  String? phone;
  String? email;
  String? nid;
  String? nationality;
  String? gender;
  String? religion;
  String? birthdate;
  String? bloodGroup;
  String? address;
  String? maritalStatus;
  String? anniversaryDate;
  String? passportNo;
  String? passportExpiryDate;
  String? phoneSecondary;
  String? landPhone;
  String? presentAddress;
  String? permanentAddress;
  String? houseNo;
  String? roadNo;
  String? houseOwnerName;
  String? village;
  String? wardNo;
  String? union;
  String? postalCode;
  String? thana;
  String? district;
  String? permanentHouseNo;
  String? permanentRoadNo;
  String? permanentHouseOwnerName;
  String? permanentVillage;
  String? permanentWardNo;
  String? permanentUnion;
  String? permanentPostalCode;
  String? permanentThana;
  String? permanentDistrict;
  String? fathersName;
  String? fathersOccupation;
  String? fOfficeAddress;
  String? fContactNo;
  String? mothersName;
  String? mothersOccupation;
  String? mOfficeAddress;
  String? mContactNo;
  String? guardiansName;
  String? guardiansRelation;
  String? guardiansHouseAddress;
  String? guardiansContactNo;
  String? spouseName;
  String? spouseOccupation;
  String? spouseOfficeAddress;
  String? spouseContactNo;
  String? emergencyContactName;
  String? emergencyContactNo;
  String? emergencyRelationship;
  String? emergencyAddress;
  String? emergencyPhone;
  String? photo;
  String? indexNo;
  String? eduQualification;
  String? mpoDate;
  String? password;
  int? status;
  int? userId;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.teacherCode,
        this.type,
        this.dormitoryId,
        this.shiftId,
        this.subject,
        this.joiningDate,
        this.designation,
        this.name,
        this.phone,
        this.email,
        this.nid,
        this.nationality,
        this.gender,
        this.religion,
        this.birthdate,
        this.bloodGroup,
        this.address,
        this.maritalStatus,
        this.anniversaryDate,
        this.passportNo,
        this.passportExpiryDate,
        this.phoneSecondary,
        this.landPhone,
        this.presentAddress,
        this.permanentAddress,
        this.houseNo,
        this.roadNo,
        this.houseOwnerName,
        this.village,
        this.wardNo,
        this.union,
        this.postalCode,
        this.thana,
        this.district,
        this.permanentHouseNo,
        this.permanentRoadNo,
        this.permanentHouseOwnerName,
        this.permanentVillage,
        this.permanentWardNo,
        this.permanentUnion,
        this.permanentPostalCode,
        this.permanentThana,
        this.permanentDistrict,
        this.fathersName,
        this.fathersOccupation,
        this.fOfficeAddress,
        this.fContactNo,
        this.mothersName,
        this.mothersOccupation,
        this.mOfficeAddress,
        this.mContactNo,
        this.guardiansName,
        this.guardiansRelation,
        this.guardiansHouseAddress,
        this.guardiansContactNo,
        this.spouseName,
        this.spouseOccupation,
        this.spouseOfficeAddress,
        this.spouseContactNo,
        this.emergencyContactName,
        this.emergencyContactNo,
        this.emergencyRelationship,
        this.emergencyAddress,
        this.emergencyPhone,
        this.photo,
        this.indexNo,
        this.eduQualification,
        this.mpoDate,
        this.password,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherCode = json['teacher_code'];
    type = _parseToString(json['type']);
    dormitoryId = json['dormitory_id'];
    shiftId = json['shift_id'];
    subject = json['subject'];
    joiningDate = json['joining_date'];
    designation = json['designation'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    nid = json['nid'];
    nationality = json['nationality'];
    gender = json['gender'];
    religion = json['religion'];
    birthdate = json['birthdate'];
    bloodGroup = json['blood_group'];
    address = json['address'];
    maritalStatus = json['marital_status'];
    anniversaryDate = json['anniversary_date'];
    passportNo = json['passport_no'];
    passportExpiryDate = json['passport_expiry_date'];
    phoneSecondary = json['phone_secondary'];
    landPhone = json['land_phone'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    houseNo = json['house_no'];
    roadNo = json['road_no'];
    houseOwnerName = json['house_owner_name'];
    village = json['village'];
    wardNo = json['ward_no'];
    union = json['union'];
    postalCode = json['postal_code'];
    thana = json['thana'];
    district = json['district'];
    permanentHouseNo = json['permanent_house_no'];
    permanentRoadNo = json['permanent_road_no'];
    permanentHouseOwnerName = json['permanent_house_owner_name'];
    permanentVillage = json['permanent_village'];
    permanentWardNo = json['permanent_ward_no'];
    permanentUnion = json['permanent_union'];
    permanentPostalCode = json['permanent_postal_code'];
    permanentThana = json['permanent_thana'];
    permanentDistrict = json['permanent_district'];
    fathersName = json['fathers_name'];
    fathersOccupation = json['fathers_occupation'];
    fOfficeAddress = json['f_office_address'];
    fContactNo = json['f_contact_no'];
    mothersName = json['mothers_name'];
    mothersOccupation = json['mothers_occupation'];
    mOfficeAddress = json['m_office_address'];
    mContactNo = json['m_contact_no'];
    guardiansName = json['guardians_name'];
    guardiansRelation = json['guardians_relation'];
    guardiansHouseAddress = json['guardians_house_address'];
    guardiansContactNo = json['guardians_contact_no'];
    spouseName = json['spouse_name'];
    spouseOccupation = json['spouse_occupation'];
    spouseOfficeAddress = json['spouse_office_address'];
    spouseContactNo = json['spouse_contact_no'];
    emergencyContactName = json['emergency_contact_name'];
    emergencyContactNo = json['emergency_contact_no'];
    emergencyRelationship = json['emergency_relationship'];
    emergencyAddress = json['emergency_address'];
    emergencyPhone = json['emergency_phone'];
    photo = json['photo'];
    indexNo = json['index_no'];
    eduQualification = json['edu_qualification'];
    mpoDate = json['mpo_date'];
    password = json['password'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  static String? _parseToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_code'] = teacherCode;
    data['type'] = type;
    data['dormitory_id'] = dormitoryId;
    data['shift_id'] = shiftId;
    data['subject'] = subject;
    data['joining_date'] = joiningDate;
    data['designation'] = designation;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['nid'] = nid;
    data['nationality'] = nationality;
    data['gender'] = gender;
    data['religion'] = religion;
    data['birthdate'] = birthdate;
    data['blood_group'] = bloodGroup;
    data['address'] = address;
    data['marital_status'] = maritalStatus;
    data['anniversary_date'] = anniversaryDate;
    data['passport_no'] = passportNo;
    data['passport_expiry_date'] = passportExpiryDate;
    data['phone_secondary'] = phoneSecondary;
    data['land_phone'] = landPhone;
    data['present_address'] = presentAddress;
    data['permanent_address'] = permanentAddress;
    data['house_no'] = houseNo;
    data['road_no'] = roadNo;
    data['house_owner_name'] = houseOwnerName;
    data['village'] = village;
    data['ward_no'] = wardNo;
    data['union'] = union;
    data['postal_code'] = postalCode;
    data['thana'] = thana;
    data['district'] = district;
    data['permanent_house_no'] = permanentHouseNo;
    data['permanent_road_no'] = permanentRoadNo;
    data['permanent_house_owner_name'] = permanentHouseOwnerName;
    data['permanent_village'] = permanentVillage;
    data['permanent_ward_no'] = permanentWardNo;
    data['permanent_union'] = permanentUnion;
    data['permanent_postal_code'] = permanentPostalCode;
    data['permanent_thana'] = permanentThana;
    data['permanent_district'] = permanentDistrict;
    data['fathers_name'] = fathersName;
    data['fathers_occupation'] = fathersOccupation;
    data['f_office_address'] = fOfficeAddress;
    data['f_contact_no'] = fContactNo;
    data['mothers_name'] = mothersName;
    data['mothers_occupation'] = mothersOccupation;
    data['m_office_address'] = mOfficeAddress;
    data['m_contact_no'] = mContactNo;
    data['guardians_name'] = guardiansName;
    data['guardians_relation'] = guardiansRelation;
    data['guardians_house_address'] = guardiansHouseAddress;
    data['guardians_contact_no'] = guardiansContactNo;
    data['spouse_name'] = spouseName;
    data['spouse_occupation'] = spouseOccupation;
    data['spouse_office_address'] = spouseOfficeAddress;
    data['spouse_contact_no'] = spouseContactNo;
    data['emergency_contact_name'] = emergencyContactName;
    data['emergency_contact_no'] = emergencyContactNo;
    data['emergency_relationship'] = emergencyRelationship;
    data['emergency_address'] = emergencyAddress;
    data['emergency_phone'] = emergencyPhone;
    data['photo'] = photo;
    data['index_no'] = indexNo;
    data['edu_qualification'] = eduQualification;
    data['mpo_date'] = mpoDate;
    data['password'] = password;
    data['status'] = status;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
