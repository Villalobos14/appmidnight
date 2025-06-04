class Data{
  final String token;

  Data({required this.token});
}
class Auth{
 final String message;
  final Data data;

  Auth({required this.message, required this.data});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      message: json['message'] ?? '',
      data: Data(
        token: json['data']['token'] ?? '',
      ),
    );
  }
 

}