import 'package:super_enum/super_enum.dart';

part 'location_event.g.dart';

@superEnum
enum _LocationEvent {
  @generic
  @Data(fields: [
    DataField<Generic>('location'),
  ])
  _UpdateData,
  @generic
  @Data(fields: [
    DataField<Generic>('unitSystem'),
  ])
  SetUnitSystem,
  @object
  Start,
  @object
  Stop,
}
