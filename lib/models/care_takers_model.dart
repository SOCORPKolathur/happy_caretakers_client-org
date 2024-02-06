class CareTakersModel {
  late String id;
  late String name;
  late String category;
  late String imgUrl;
  late String aadharNumber;
  late String fcmToken;
  late bool isCurrentlyWorking;
  late String phone;
  late String workExperience;
  late Location location;
  late String address;
  late String subCategory;
  late int yearsOfExperience;
  late String lanCode;
  late String workType;
  late String createdDate;
  late num timestamp;
  late bool subscription;
  late int plansCount;
  late List<String> languagesKnow;
  late bool ifOutstation;

  CareTakersModel({
    required this.name,
    required this.id,
    required this.fcmToken,
    required this.phone,
    required this.workExperience,
    required this.isCurrentlyWorking,
    required this.category,
    required this.location,
    required this.subCategory,
    required this.yearsOfExperience,
    required this.imgUrl,
    required this.aadharNumber,
    required this.lanCode,
    required this.workType,
    required this.timestamp,
    required this.languagesKnow,
    required this.ifOutstation,
    required this.plansCount,
    required this.subscription,
    required this.createdDate,
  });

  CareTakersModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fcmToken = json['fcmToken'];
    lanCode = json['lanCode'];
    category = json['category'];
    id = json['id'];
    phone = json['phone'];
    isCurrentlyWorking = json['isCurrentlyWorking'];
    timestamp = json['timestamp'];
    imgUrl = json['imgUrl'];
    aadharNumber = json['aadharNumber'];
    workExperience = json['workExperience'];
    location = (json['location'] != null ? Location.fromJson(json['location']) : null)!;
    subCategory = json['subCategory'];
    yearsOfExperience = json['yearsOfExperience'];
    createdDate = json['createdDate'];
    workType = json['workType'];
    subscription = json['subscription'];
    plansCount = json['plansCount'];
    languagesKnow = List<String>.from(json['languagesKnow']);
    ifOutstation = json['ifOutstation'];
    createdDate = json['createdDate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['fcmToken'] = fcmToken;
    data['isCurrentlyWorking'] = isCurrentlyWorking;
    data['timestamp'] = timestamp;
    data['imgUrl'] = imgUrl;
    data['category'] = category;
    data['lanCode'] = lanCode;
    data['aadharNumber'] = aadharNumber;
    data['id'] = id;
    data['phone'] = phone;
    data['workExperience'] = workExperience;
    data['location'] = location.toJson();
    data['subCategory'] = subCategory;
    data['yearsOfExperience'] = yearsOfExperience;
    data['workType'] = workType;
    data['subscription'] = subscription;
    data['plansCount'] = plansCount;
    data['languagesKnow'] = languagesKnow;
    data['ifOutstation'] = ifOutstation;
    data['createdDate'] = createdDate;
    return data;
  }
}


class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
