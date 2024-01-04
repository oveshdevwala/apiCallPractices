// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserDataModel {
  int total;
  int skip;
  int limit;
  List<UserModel> users;
  UserDataModel({
    required this.total,
    required this.skip,
    required this.limit,
    required this.users,
  });
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    List<UserModel> listUserModel = [];
    for (Map<String, dynamic> eachMap in json['users']) {
      listUserModel.add(UserModel.fromJson(eachMap));
    }
    return UserDataModel(
        total: json['total'],
        skip: json['skip'],
        limit: json['limit'],
        users: listUserModel);
  }
}

class UserModel {
  int id;
  String? firstName;
  String? lastName;
  String? maidenName;
  int age;
  String? gender;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? birthDate;
  String? image;
  String? bloodGroup;
  num? height;
  num? weight;
  String? eyeColor;
  HairModel? hair;
  String? domain;
  String? ip;
  AddressModel? address;
  String? macAddress;
  String? university;
  BankModel? bank;
  CompanyModel? company;
  String? ein;
  String? ssn;
  String? userAgent;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hair,
    required this.domain,
    required this.ip,
    required this.address,
    required this.macAddress,
    required this.university,
    required this.bank,
    required this.company,
    required this.ein,
    required this.ssn,
    required this.userAgent,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        maidenName: json['maidenName'],
        age: json['age'],
        gender: json['gender'],
        email: json['email'],
        phone: json['phone'],
        username: json['username'],
        password: json['password'],
        birthDate: json['birthDate'],
        image: json['image'],
        bloodGroup: json['bloodGroup'],
        height: json['height'],
        weight: json['weight'],
        eyeColor: json['eyeColor'],
        hair: json['hair'] != null ? HairModel.fromJson(json['hair']) : null,
        domain: json['domain'],
        ip: json['ip'],
        address: json['address'] != null
            ? AddressModel.fromJson(json['address'])
            : null,
        macAddress: json['macAddress'],
        university: json['university'],
        bank: json['bank'] != null ? BankModel.fromJson(json['bank']) : null,
        company: json['company'] != null
            ? CompanyModel.fromJson(json['company'])
            : null,
        ein: json['ein'],
        ssn: json['ssn'],
        userAgent: json['userAgent']);
  }
}

class HairModel {
  String? color;
  String? type;
  HairModel({
    required this.color,
    required this.type,
  });
  factory HairModel.fromJson(Map<String, dynamic> json) {
    return HairModel(color: json['color'], type: json['type']);
  }
}

class AddressModel {
  String? address;
  String? city;
  CoordinatesModel? coordinates;
  String? postalCode;
  String? state;
  AddressModel({
    required this.address,
    required this.city,
    required this.coordinates,
    required this.postalCode,
    required this.state,
  });
  factory AddressModel.fromJson(Map<String?, dynamic> json) {
    return AddressModel(
        address: json['address'],
        city: json['city'],
        coordinates: json['coordinates'] != null
            ? CoordinatesModel.fromJson(json['coordinates'])
            : null,
        postalCode: json['postalCode'],
        state: json['state']);
  }
}

class CoordinatesModel {
  num? lat;
  num? lng;
  CoordinatesModel({
    required this.lat,
    required this.lng,
  });
  factory CoordinatesModel.fromJson(Map<String?, dynamic> json) {
    return CoordinatesModel(lat: json['lat'], lng: json['lng']);
  }
}

class BankModel {
  String? cardExpire;
  String? cardNumber;
  String? cardType;
  String? currency;
  String? iban;
  BankModel({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });

  factory BankModel.fromJson(Map<String?, dynamic> json) {
    return BankModel(
        cardExpire: json['cardExpire'],
        cardNumber: json['cardNumber'],
        cardType: json['cardType'],
        currency: json['currency'],
        iban: json['iban']);
  }
}

class CompanyModel {
  CompanyAddressModel? address;
  String? department;
  String? name;
  String? title;
  CompanyModel({
    required this.address,
    required this.department,
    required this.name,
    required this.title,
  });
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      address: json['address'] != null
          ? CompanyAddressModel.fromJson(json['address'])
          : null,
      department: json['department'],
      name: json['name'],
      title: json['title'],
    );
  }
}

class CompanyAddressModel {
  String? address;
  String? city;
  CompanyCoordinatesModel? coordinates;
  String? postalCode;
  String? state;
  CompanyAddressModel({
    required this.address,
    required this.city,
    required this.coordinates,
    required this.postalCode,
    required this.state,
  });

  factory CompanyAddressModel.fromJson(Map<String?, dynamic> json) {
    return CompanyAddressModel(
        address: json['address'],
        city: json['city'],
        coordinates: json['coordinates'] != null
            ? CompanyCoordinatesModel.fromJson(json['coordinates'])
            : null,
        postalCode: json['postalCode'],
        state: json['state']);
  }
}

class CompanyCoordinatesModel {
  num? lat;
  num? lng;
  CompanyCoordinatesModel({
    required this.lat,
    required this.lng,
  });

  factory CompanyCoordinatesModel.fromJson(Map<String?, dynamic> json) {
    return CompanyCoordinatesModel(lat: json['lat'], lng: json['lng']);
  }
}
