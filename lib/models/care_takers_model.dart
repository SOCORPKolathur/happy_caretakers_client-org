class CareTakersModel {
  late String id;
  late String name;
  late String category;
  late String imgUrl;
  late String aadharNumber;
  late String fcmToken;
  late bool isCurrentlyWorking;
  late String city;
  late int age;
  late String phone;
  late String gender;
  late String workExperience;
  late int totalWorks;
  late String email;
  late Location location;
  late String address;
  late String subCategory;
  late int yearsOfExperience;
  late String position;
  late String workingAt;
  late String orgName;
  late String lanCode;
  late String workType;
  late num timestamp;
  late bool subscription;
  late int plansCount;
  late List<String> languagesKnow;
  late bool outstation ;

  CareTakersModel(
      {required this.name,
        required this.id,
        required this.fcmToken,
        required this.age,
        required this.phone,
        required this.workExperience,
        required this.totalWorks,
        required this.orgName,
        required this.isCurrentlyWorking,
        required this.category,
        required this.email,
        required this.location,
        required this.address,
        required this.subCategory,
        required this.city,
        required this.gender,
        required this.yearsOfExperience,
        required this.position,
        required this.workingAt,
        required this.imgUrl,
        required this.aadharNumber,
        required this.lanCode,
        required this.workType,
        required this.timestamp,
        required this.languagesKnow,
        required this.outstation,
        required this.plansCount,
        required this.subscription,
        });

  CareTakersModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fcmToken = json['fcmToken'];
    gender = json['gender'];
    orgName = json['orgName'];
    lanCode = json['lanCode'];
    category = json['category'];
    id = json['id'];
    isCurrentlyWorking = json['isCurrentlyWorking'];
    timestamp = json['timestamp'];
    city = json['city'];
    imgUrl = json['imgUrl'];
    aadharNumber = json['aadharNumber'];
    age = json['age'];
    phone = json['phone'];
    workExperience = json['workExperience'];
    totalWorks = json['totalWorks'];
    email = json['email'];
    location = (json['location'] != null
        ? Location.fromJson(json['location'])
        : null)!;
    address = json['address'];
    subCategory = json['subCategory'];
    yearsOfExperience = json['yearsOfExperience'];
    position = json['position'];
    workingAt = json['workingAt'];
    workType = json['workPreparence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['fcmToken'] = fcmToken;
    data['orgName'] = orgName;
    data['gender'] = gender;
    data['isCurrentlyWorking'] = isCurrentlyWorking;
    data['timestamp'] = timestamp;
    data['city'] = city;
    data['imgUrl'] = imgUrl;
    data['category'] = category;
    data['lanCode'] = lanCode;
    data['aadharNumber'] = aadharNumber;
    data['id'] = id;
    data['age'] = age;
    data['phone'] = phone;
    data['workExperience'] = workExperience;
    data['totalWorks'] = totalWorks;
    data['email'] = email;
    data['location'] = location!.toJson();
    data['address'] = address;
    data['subCategory'] = subCategory;
    data['yearsOfExperience'] = yearsOfExperience;
    data['position'] = position;
    data['workingAt'] = workingAt;
    data['workType'] = workType;
    return data;
  }
}

class Rating {
  String? userPhone;
  double? rating;

  Rating({this.userPhone, this.rating});

  Rating.fromJson(Map<String, dynamic> json) {
    userPhone = json['userPhone'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userPhone'] = userPhone;
    data['rating'] = rating;
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
