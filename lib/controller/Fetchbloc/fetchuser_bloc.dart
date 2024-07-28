import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:taskpro/Model/model.dart';

part 'fetchuser_event.dart';
part 'fetchuser_state.dart';

class FetchuserBloc extends Bloc<FetchuserEvent, FetchuserState> {
  FetchuserBloc() : super(FetchuserInitial()) {
    on<Fetchuser>(
      (event, emit) async {
        emit(FetchuserLoading());
        try {
          final user = FirebaseAuth.instance.currentUser;

          final currentuserdata =
              FirebaseFirestore.instance.collection('workers').doc(user!.uid);
          final doc = await currentuserdata.get();
          final data = doc.data()!;
          final userdata = Modelclass(
            data['registerd'],
            data['aadharFrontUrl'],
            data['aadharBackUrl'],
            name: '${data['firstName']} ${data['lastName']}',
            email: data['email'],
            phonenumber: data['phoneNumber'],
            worktype: data['workType'],
            profileimage: data['profileImageUrl'],
            qualification: data['maxQualification'],
            about: data['about'],
            totalwork: '0',
            location: data['location'],
          );
          emit(FetchuserLoaded(userdata: userdata));
        } catch (e) {
          emit(FetchuserError(e.toString()));
        }
      },
    );
  }
}
