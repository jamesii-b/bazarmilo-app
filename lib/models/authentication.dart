class LoginDataModel {
  String username;

  String password;
  getLoginModel() {
    return {
      "username": username,
      "password": password,
    };
  }

  LoginDataModel({required this.username, required this.password});
}
