import 'package:json_annotation/json_annotation.dart';

part "app_inputs.g.dart";

@JsonSerializable()
class AppInputs {
  @JsonKey(name: "fuel_types")
  final List<IdNameRecord>? fuelTypes;

  @JsonKey(name: "request_types")
  final List<IdNameRecord>? requestTypes;

  @JsonKey(name: "request_statuses")
  final List<IdNameRecord>? requestStatuses;

  @JsonKey(name: "payment_types")
  final List<IdNameRecord>? paymenTypes;

  @JsonKey(name: "station_users")
  final List<IdNameRecord>? stationUsers;

  @JsonKey(name: "user_details")
  final User? userDetails;

  @JsonKey(name: "station_pumps")
  final List<StationPump>? stationPumps;

  @JsonKey(name: "station_inventories")
  final List<StationInventory>? stationInventories;

  @JsonKey(name: "daily_total_working_hours")
  final List<DailyTotalWorkingHours>? dailyTotalWorkingHours;

  @JsonKey(name: "priority_types")
  final List<IdNameRecord>? priorityTypes;

  @JsonKey(name: "history_reasons")
  final List<IdNameRecord>? historyReasons;

  AppInputs({
    this.fuelTypes,
    this.requestTypes,
    this.requestStatuses,
    this.paymenTypes,
    this.stationUsers,
    this.userDetails,
    this.stationPumps,
    this.stationInventories,
    this.dailyTotalWorkingHours,
    this.priorityTypes,
    this.historyReasons,
  });

  factory AppInputs.fromJson(Map<String, dynamic> json) {
    return _$AppInputsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppInputsToJson(this);
}

@JsonSerializable()
class IdNameRecord {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  IdNameRecord({
    this.id,
    this.name,
  });

  factory IdNameRecord.fromJson(Map<String, dynamic> json) {
    return _$IdNameRecordFromJson(json);
  }

  Map<String, dynamic> toJson() => _$IdNameRecordToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "first_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "password_hash")
  final String? passwordHash;

  @JsonKey(name: "gender_id")
  final int? genderId;

  @JsonKey(name: "primary_phone")
  final int? primaryPhone;

  @JsonKey(name: "secondary_phone")
  final int? secondaryPhone;

  @JsonKey(name: "role_id")
  final int? roleId;

  @JsonKey(name: "status_id")
  final int? statusId;

  @JsonKey(name: "profile_pic_id")
  final int? profilePicId;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "created_by_user_id")
  final int? createdByUserId;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  @JsonKey(name: "station_id")
  final int? stationId;

  @JsonKey(name: "gas_station")
  final GasStationUser? gasStation;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.passwordHash,
    this.genderId,
    this.primaryPhone,
    this.secondaryPhone,
    this.roleId,
    this.statusId,
    this.profilePicId,
    this.address,
    this.createdByUserId,
    this.createdAt,
    this.updatedAt,
    this.stationId,
    this.gasStation,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class GasStationUser {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "station_id")
  final int? stationId;

  @JsonKey(name: "user_id")
  final int? userId;

  GasStationUser({
    this.id,
    this.stationId,
    this.userId,
  });

  factory GasStationUser.fromJson(Map<String, dynamic> json) {
    return _$GasStationUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GasStationUserToJson(this);
}

@JsonSerializable()
class StationPump {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "station_id")
  final int? stationId;

  @JsonKey(name: "is_active")
  final bool? isActive;

  @JsonKey(name: "pump_type")
  final int? pumpType;

  StationPump({
    this.id,
    this.stationId,
    this.isActive,
    this.pumpType,
  });

  factory StationPump.fromJson(Map<String, dynamic> json) {
    return _$StationPumpFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StationPumpToJson(this);
  }
}

@JsonSerializable()
class StationInventory {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "current_count")
  final int? currentCount;

  @JsonKey(name: "station_id")
  final int? stationId;

  @JsonKey(name: "station_name")
  final String? stationName;

  @JsonKey(name: "history")
  final List<StationInventoryHistory>? history;

  StationInventory({
    this.id,
    this.name,
    this.currentCount,
    this.stationId,
    this.stationName,
    this.history,
  });

  factory StationInventory.fromJson(Map<String, dynamic> json) {
    return _$StationInventoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StationInventoryToJson(this);
  }
}

@JsonSerializable()
class StationInventoryHistory {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "inventory_id")
  final int? inventoryId;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "action_type")
  final String? actionType;

  @JsonKey(name: "reason")
  final String? reason;

  @JsonKey(name: "count")
  final int? count;

  @JsonKey(name: "user_id")
  final int? userId;

  @JsonKey(name: "employee_name")
  final String? employeeName;

  StationInventoryHistory({
    this.id,
    this.inventoryId,
    this.createdAt,
    this.actionType,
    this.reason,
    this.count,
    this.userId,
    this.employeeName,
  });

  factory StationInventoryHistory.fromJson(Map<String, dynamic> json) {
    return _$StationInventoryHistoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StationInventoryHistoryToJson(this);
  }
}

@JsonSerializable()
class DailyTotalWorkingHours {
  @JsonKey(name: "day")
  final int? day;

  @JsonKey(name: "month")
  final int? month;

  @JsonKey(name: "year")
  final int? year;

  @JsonKey(name: "total_working_hours")
  final int? totalWorkingHours;

  DailyTotalWorkingHours({
    this.day,
    this.month,
    this.year,
    this.totalWorkingHours,
  });

  factory DailyTotalWorkingHours.fromJson(Map<String, dynamic> json) {
    return _$DailyTotalWorkingHoursFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DailyTotalWorkingHoursToJson(this);
  }
}
