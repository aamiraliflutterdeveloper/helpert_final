class SpecialistsModel {
  SpecialistsModel({
    required this.doctorId,
    required this.image,
    required this.username,
    required this.specialization,
    required this.rating,
  });

  int doctorId;
  String image;
  String username;
  String specialization;
  double rating;

  factory SpecialistsModel.fromJson(Map<String, dynamic> json) =>
      SpecialistsModel(
        doctorId: json["doctoe_id"] == null ? null : json['doctoe_id'],
        image: json["image"] ?? '',
        username: json["username"] == null ? '' : json['username'],
        specialization: json["specializaton"] ?? '',
        rating: json["rating"] == 0 || json["rating"] == null
            ? 0.0
            : double.parse(json["rating"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "doctoe_id": doctorId,
        "image": image,
        "username": username,
        "specializaton": specialization,
      };
}
//
// /// the first that i used ...
//
// class SpecialistsModel {
//   String name;
//   String speciality;
//   double rating;
//   int reviews;
//   String image;
//   SpecialistsModel(
//       {required this.name,
//       required this.image,
//       required this.rating,
//       required this.reviews,
//       required this.speciality});
// }
//
// List<SpecialistsModel> allSpecialistsList = [
//   SpecialistsModel(
//       name: 'Dr. Bellany',
//       speciality: 'Viralogist',
//       rating: 4.5,
//       reviews: 135,
//       image: 'https://picsum.photos/200/300'),
//   SpecialistsModel(
//       name: 'Ricky Ponting',
//       speciality: 'Crickter',
//       rating: 4.5,
//       reviews: 135,
//       image: 'https://picsum.photos/200/300/?blur'),
//   SpecialistsModel(
//       name: 'Chris Gayle',
//       speciality: 'Hairdresser',
//       rating: 4.5,
//       reviews: 135,
//       image: 'https://picsum.photos/seed/picsum/200/300'),
//   SpecialistsModel(
//       name: 'Dr. Khan',
//       speciality: 'Viralogist',
//       rating: 4.5,
//       reviews: 135,
//       image: 'https://picsum.photos/200'),
//   SpecialistsModel(
//       name: 'Nelson Mandela',
//       speciality: 'Politician',
//       rating: 4.5,
//       reviews: 135,
//       image: 'https://picsum.photos/200/300'),
//   SpecialistsModel(
//       name: 'E. Muhammad Ali',
//       speciality: 'Engineer',
//       rating: 4.5,
//       reviews: 135,
//       image: 'https://picsum.photos/id/0/5616/3744'),
//   SpecialistsModel(
//       name: 'Aamir Ali',
//       speciality: 'Surgeon',
//       rating: 4.5,
//       reviews: 135,
//       image:
//           'https://images.unsplash.com/photo-1466228432269-af42b400b934?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1528&q=80'),
// ];
