class UserData {
  String address;
  String contactNum;
  String email;
  String fullName;
  String id;
  String licenseNum;
  String password;
  String username;

  UserData({
    required this.address,
    required this.contactNum,
    required this.email,
    required this.fullName,
    required this.id,
    required this.licenseNum,
    required this.password,
    required this.username,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      address: json['address'],
      contactNum: json['contactnum'],
      email: json['email'],
      fullName: json['fullname'],
      id: json['id'],
      licenseNum: json['licensenum'],
      password: json['password'],
      username: json['username'],
    );
  }

  String getFullName() => fullName;

  String getAddress() => address;

  String getContactNum() => contactNum;

  String getEmail() => email;

  String getId() => id;

  String getLicenseNum() => licenseNum;

  String getPassword() => password;

  String getUsername() => username;
}
