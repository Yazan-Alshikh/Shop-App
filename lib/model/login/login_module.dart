class LoginModel {
  bool status;
  String message;
  LoginData data ;


  LoginModel.fromjson (Map<String,dynamic> json)
  {
    status = json["status"];
    message = json["message"];
    data = json["data"]!= null ? LoginData.fromjson(json["data"]) : null;
  }

}



class LoginData {

  int id ;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;


  LoginData.fromjson (Map<String,dynamic> json){
  id = json['id'];
  name = json['name'];
  email = json['email'];
  phone = json['phone'];
  image = json['image'];
  points = json['points'];
  credit = json['credit'];
  token = json['token'];
  }


}