class Authmodel {
  final String profileimage;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String phonenumber;
  final String lacation;
  final String maxqualificaation;
  final String worktype;
  final String aadharfront;
  final String aadharback;
  final String about;

  Authmodel(
      {required this.profileimage,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.password,
      required this.phonenumber,
      required this.lacation,
      required this.maxqualificaation,
      required this.worktype,
      required this.aadharfront,
      required this.aadharback,
      required this.about});
}
