import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tomas_matres/api/api.dart';
import 'package:tomas_matres/data_models/partner_model.dart';

part 'about_company_state.dart';

class AboutCompanyCubit extends Cubit<AboutCompanyState> {
  AboutCompanyCubit() : super(AboutCompanyLoading()) {
    _init();
  }

  List<Partner> partners = [];

  Future<void> _init() async {
    partners = await _getAllPartners();

    emit(AboutCompanyLoaded(partners: partners));
  }

  Future<List<Partner>> _getAllPartners() async {
    List<Partner> partners = await TomasApi.getAllPartners();
    return partners;
  }
}
