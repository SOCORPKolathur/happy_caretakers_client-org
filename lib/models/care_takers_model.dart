class CareTakersModel {
  late String id;
  late String firstName;
  late String lastName;
  late String imgUrl;
  late String aadharUrl;
  late String city;
  late int age;
  late String phone;
  late List<Rating> rating;
  late String workExperience;
  late int totalWorks;
  late String email;
  late Location location;
  late String address;
  late String about;
  late int yearsOfExperience;
  late String position;
  late String workingAt;
  late String workPreparence;
  late num timestamp;

  CareTakersModel(
      {required this.firstName,
        required this.id,
        required this.lastName,
        required this.age,
        required this.phone,
        required this.rating,
        required this.workExperience,
        required this.totalWorks,
        required this.email,
        required this.location,
        required this.address,
        required this.about,
        required this.city,
        required this.yearsOfExperience,
        required this.position,
        required this.workingAt,
        required this.imgUrl,
        required this.aadharUrl,
        required this.timestamp,
        required this.workPreparence});

  CareTakersModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    id = json['id'];
    timestamp = json['timestamp'];
    city = json['city'];
    imgUrl = json['imgUrl'];
    aadharUrl = json['aadharUrl'];
    age = json['age'];
    phone = json['phone'];
    if (json['rating'] != null) {
      rating = <Rating>[];
      json['rating'].forEach((v) {
        rating!.add(Rating.fromJson(v));
      });
    }
    workExperience = json['workExperience'];
    totalWorks = json['totalWorks'];
    email = json['email'];
    location = (json['location'] != null
        ? Location.fromJson(json['location'])
        : null)!;
    address = json['address'];
    about = json['about'];
    yearsOfExperience = json['yearsOfExperience'];
    position = json['position'];
    workingAt = json['workingAt'];
    workPreparence = json['workPreparence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['timestamp'] = timestamp;
    data['city'] = city;
    data['imgUrl'] = imgUrl;
    data['aadharUrl'] = aadharUrl;
    data['id'] = id;
    data['age'] = age;
    data['phone'] = phone;
    data['rating'] = rating!.map((v) => v.toJson()).toList();
    data['workExperience'] = workExperience;
    data['totalWorks'] = totalWorks;
    data['email'] = email;
    data['location'] = location!.toJson();
    data['address'] = address;
    data['about'] = about;
    data['yearsOfExperience'] = yearsOfExperience;
    data['position'] = position;
    data['workingAt'] = workingAt;
    data['workPreparence'] = workPreparence;
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
