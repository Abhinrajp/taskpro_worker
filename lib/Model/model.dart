class Modelclass {
  final String name;
  final String email;
  final String phonenumber;
  final String worktype;
  final String profileimage;
  final String qualification;
  final String about;
  final String totalwork;
  final String location;
  final String register;
  final String rating;
  final String aadharfront;
  final String aadharback;

  Modelclass(this.register, this.aadharfront, this.aadharback,
      {required this.name,
      required this.email,
      required this.phonenumber,
      required this.worktype,
      required this.profileimage,
      required this.qualification,
      required this.about,
      required this.totalwork,
      required this.rating,
      required this.location});
}
