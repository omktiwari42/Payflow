import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../models/notification_model.dart';

class NotificationApiService {
  NotificationApiService._();

  static final NotificationApiService instance = NotificationApiService._();

  // ============================================================
  // GET NOTIFICATIONS
  // ============================================================

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.notifications,
      );

      final data = response.data;

      if (data is Map && data["notifications"] is List) {
        return (data["notifications"] as List)
            .map(
              (item) =>
                  NotificationModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      }

      if (data is List) {
        return data
            .map(
              (item) =>
                  NotificationModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      }

      return [];
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e, "Unable to load notifications."));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // ============================================================
  // GET UNREAD NOTIFICATIONS
  // ============================================================

  Future<List<NotificationModel>> getUnreadNotifications() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.unreadNotifications,
      );

      final data = response.data;

      if (data is Map && data["notifications"] is List) {
        return (data["notifications"] as List)
            .map(
              (item) =>
                  NotificationModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      }

      if (data is List) {
        return data
            .map(
              (item) =>
                  NotificationModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      }

      return [];
    } on DioException catch (e) {
      throw Exception(
        _getErrorMessage(e, "Unable to load unread notifications."),
      );
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // ============================================================
  // MARK NOTIFICATION AS READ
  // ============================================================

  Future<void> markAsRead(int notificationId) async {
    try {
      await ApiClient.dio.patch(
        ApiConstants.markNotificationRead,
        data: {"notification_id": notificationId},
      );
    } on DioException catch (e) {
      throw Exception(
        _getErrorMessage(e, "Unable to mark notification as read."),
      );
    }
  }

  // ============================================================
  // MARK ALL AS READ
  // ============================================================

  Future<void> markAllAsRead() async {
    try {
      await ApiClient.dio.patch(ApiConstants.markAllNotificationsRead);
    } on DioException catch (e) {
      throw Exception(
        _getErrorMessage(e, "Unable to mark notifications as read."),
      );
    }
  }

  // ============================================================
  // DELETE NOTIFICATION
  // ============================================================

  Future<void> deleteNotification(int notificationId) async {
    try {
      await ApiClient.dio.delete(
        ApiConstants.deleteNotification,
        data: {"notification_id": notificationId},
      );
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e, "Unable to delete notification."));
    }
  }

  // ============================================================
  // ERROR MESSAGE
  // ============================================================

  String _getErrorMessage(DioException error, String fallback) {
    final data = error.response?.data;

    if (data is Map && data["message"] != null) {
      return data["message"].toString();
    }

    return fallback;
  }
}
