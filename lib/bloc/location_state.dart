import 'package:super_enum/super_enum.dart';

part 'location_state.g.dart';

@superEnum
enum _LocationState {
  @object
  Stoped,
  @generic
  @Data(fields: [
    DataField<Generic>('location'),
  ])
  SendData,
  @generic
  @Data(fields: [
    DataField<String>('info'),
    DataField<Generic>('results'),
  ])
  Error,
}
