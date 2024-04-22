part of 'about_company_cubit.dart';

sealed class AboutCompanyState extends Equatable {
  const AboutCompanyState();

  @override
  List<Object> get props => [];
}

final class AboutCompanyLoading extends AboutCompanyState {}

final class AboutCompanyLoaded extends AboutCompanyState {
  final List<Partner> partners;

  const AboutCompanyLoaded({required this.partners});

  @override
  List<Object> get props => [partners];
}
