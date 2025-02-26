// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_inputs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInputs _$AppInputsFromJson(Map<String, dynamic> json) => AppInputs(
      fuelTypes: (json['fuel_types'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestTypes: (json['request_types'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestStatuses: (json['request_statuses'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymenTypes: (json['payment_types'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      stationUsers: (json['station_users'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      userDetails: json['user_details'] == null
          ? null
          : User.fromJson(json['user_details'] as Map<String, dynamic>),
      stationPumps: (json['station_pumps'] as List<dynamic>?)
          ?.map((e) => StationPump.fromJson(e as Map<String, dynamic>))
          .toList(),
      stationInventories: (json['station_inventory'] as List<dynamic>?)
          ?.map((e) => StationInventory.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyTotalWorkingHours: (json['daily_total_working_hours']
              as List<dynamic>?)
          ?.map(
              (e) => DailyTotalWorkingHours.fromJson(e as Map<String, dynamic>))
          .toList(),
      priorityTypes: (json['priority_types'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      historyReasons: (json['history_reasons'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppInputsToJson(AppInputs instance) => <String, dynamic>{
      'fuel_types': instance.fuelTypes,
      'request_types': instance.requestTypes,
      'request_statuses': instance.requestStatuses,
      'payment_types': instance.paymenTypes,
      'station_users': instance.stationUsers,
      'user_details': instance.userDetails,
      'station_pumps': instance.stationPumps,
      'station_inventory': instance.stationInventories,
      'daily_total_working_hours': instance.dailyTotalWorkingHours,
      'priority_types': instance.priorityTypes,
      'history_reasons': instance.historyReasons,
    };

IdNameRecord _$IdNameRecordFromJson(Map<String, dynamic> json) => IdNameRecord(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$IdNameRecordToJson(IdNameRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      passwordHash: json['password_hash'] as String?,
      genderId: (json['gender_id'] as num?)?.toInt(),
      primaryPhone: (json['primary_phone'] as num?)?.toInt(),
      secondaryPhone: (json['secondary_phone'] as num?)?.toInt(),
      roleId: (json['role_id'] as num?)?.toInt(),
      statusId: (json['status_id'] as num?)?.toInt(),
      profilePicId: (json['profile_pic_id'] as num?)?.toInt(),
      address: json['address'] as String?,
      createdByUserId: (json['created_by_user_id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      stationId: (json['station_id'] as num?)?.toInt(),
      gasStation: json['gas_station'] == null
          ? null
          : GasStationUser.fromJson(
              json['gas_station'] as Map<String, dynamic>),
      permission: (json['user_permissions'] as List<dynamic>?)
          ?.map((e) => UserPermission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'password_hash': instance.passwordHash,
      'gender_id': instance.genderId,
      'primary_phone': instance.primaryPhone,
      'secondary_phone': instance.secondaryPhone,
      'role_id': instance.roleId,
      'status_id': instance.statusId,
      'profile_pic_id': instance.profilePicId,
      'address': instance.address,
      'created_by_user_id': instance.createdByUserId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'station_id': instance.stationId,
      'gas_station': instance.gasStation,
      'user_permissions': instance.permission,
    };

GasStationUser _$GasStationUserFromJson(Map<String, dynamic> json) =>
    GasStationUser(
      id: (json['id'] as num?)?.toInt(),
      stationId: (json['station_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GasStationUserToJson(GasStationUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'station_id': instance.stationId,
      'user_id': instance.userId,
    };

StationPump _$StationPumpFromJson(Map<String, dynamic> json) => StationPump(
      id: (json['id'] as num?)?.toInt(),
      stationId: (json['station_id'] as num?)?.toInt(),
      isActive: json['is_active'] as bool?,
      pumpType: (json['pump_type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StationPumpToJson(StationPump instance) =>
    <String, dynamic>{
      'id': instance.id,
      'station_id': instance.stationId,
      'is_active': instance.isActive,
      'pump_type': instance.pumpType,
    };

StationInventory _$StationInventoryFromJson(Map<String, dynamic> json) =>
    StationInventory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      currentCount: (json['current_count'] as num?)?.toInt(),
      stationId: (json['station_id'] as num?)?.toInt(),
      stationName: json['station_name'] as String?,
      history: (json['history'] as List<dynamic>?)
          ?.map((e) =>
              StationInventoryHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StationInventoryToJson(StationInventory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'current_count': instance.currentCount,
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'history': instance.history,
    };

StationInventoryHistory _$StationInventoryHistoryFromJson(
        Map<String, dynamic> json) =>
    StationInventoryHistory(
      id: (json['id'] as num?)?.toInt(),
      inventoryId: (json['inventory_id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      actionType: (json['action_type'] as num?)?.toInt(),
      reason: json['reason'] as String?,
      count: (json['count'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      employeeName: json['employee_name'] as String?,
    );

Map<String, dynamic> _$StationInventoryHistoryToJson(
        StationInventoryHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inventory_id': instance.inventoryId,
      'created_at': instance.createdAt?.toIso8601String(),
      'action_type': instance.actionType,
      'reason': instance.reason,
      'count': instance.count,
      'user_id': instance.userId,
      'employee_name': instance.employeeName,
    };

DailyTotalWorkingHours _$DailyTotalWorkingHoursFromJson(
        Map<String, dynamic> json) =>
    DailyTotalWorkingHours(
      day: (json['day'] as num?)?.toInt(),
      month: (json['month'] as num?)?.toInt(),
      year: (json['year'] as num?)?.toInt(),
      totalWorkingHours: (json['total_working_hours'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DailyTotalWorkingHoursToJson(
        DailyTotalWorkingHours instance) =>
    <String, dynamic>{
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'total_working_hours': instance.totalWorkingHours,
    };

UserPermission _$UserPermissionFromJson(Map<String, dynamic> json) =>
    UserPermission(
      userId: (json['user_id'] as num?)?.toInt(),
      stationId: (json['station_id'] as num?)?.toInt(),
      permissionId: (json['permission_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserPermissionToJson(UserPermission instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'station_id': instance.stationId,
      'permission_id': instance.permissionId,
    };
