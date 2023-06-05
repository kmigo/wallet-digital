// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
enum HomeStatus {loading,success,idle,error}
class HomeState extends Equatable {
  final int page;
  final bool visible;
  final HomeStatus status;
  const HomeState({this.page = 0, this.visible =false , this.status = HomeStatus.idle});
  
  @override
  List<Object?> get props => [page,visible,status];

  HomeState copyWith({
    int? page,
    bool? visible,
    HomeStatus? status,
  }) {
    return HomeState(
      page: page ?? this.page,
      visible: visible ?? this.visible,
      status: status ?? this.status,
    );
  }
}
