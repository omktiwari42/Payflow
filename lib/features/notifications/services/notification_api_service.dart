import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../models/notification_model.dart';

class NotificationApiService {
  NotificationApiService._();

  static final NotificationApiService instance = NotificationApiService._();

  // ============================================================
  // GET ALL NOTIFICATIONS
  // GET /api/notifications
  // ============================================================

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.notifications,
      );

      return _parseNotifications(response.data);
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e, "Unable to load notifications."));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // ============================================================
  // GET UNREAD NOTIFICATIONS
  // GET /api/notifications/unread
  // ============================================================

  Future<List<NotificationModel>> getUnreadNotifications() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.unreadNotifications,
      );

      return _parseNotifications(response.data);
    } on DioException catch (e) {
      throw Exception(
        _getErrorMessage(e, "Unable to load unread notifications."),
      );
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // ============================================================
  // GET UNREAD COUNT
  // GET /api/notifications/count
  // ============================================================

  Future<int> getUnreadCount() async {
    try {
      final Response response = await ApiClient.dio.get(
        ApiConstants.notificationCount,
      );

      final data = response.data;

      if (data is Map && data["unread"] != null) {
        return int.tryParse(data["unread"].toString()) ?? 0;
      }

      return 0;
    } on DioException catch (e) {
      throw Exception(
        _getErrorMessage(e, "Unable to load notification count."),
      );
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // ============================================================
  // MARK ONE NOTIFICATION AS READ
  // PUT /api/notifications/:id/read
  // ============================================================

  Future<NotificationModel?> markAsRead(int notificationId) async {
    try {
      final Response response = await ApiClient.dio.put(
        "${ApiConstants.markNotificationRead}/$notificationId/read",
      );

      final data = response.data;

      if (data is Map && data["notification"] is Map) {
        return NotificationModel.fromJson(
          Map<String, dynamic>.from(data["notification"]),
        );
      }

      return null;
    } on DioException catch (e) {
      throw Exception(
        _getErrorMessage(e, "Unable to mark notification as read."),
      );
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // ============================================================
  // MARK ALL NOTIFICATIONS AS READ
  //
  // Backend has no dedicated /read-all endpoint.
  // We fetch unread notifications and mark them individually.
  // ============================================================

  Future<void> markAllAsRead() async {
    try {
      final unread = await getUnreadNotifications();

      if (unread.isEmpty) {
        return;
      }

      for (final notification in unread) {
        await markAsRead(notification.id);
      }
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", ""));
    }
  }

  // ============================================================
  // DELETE NOTIFICATION
  // DELETE /api/notifications/:id
  // ============================================================

  Future<void> deleteNotification(int notificationId) async {
    try {
      await ApiClient.dio.delete(
        "${ApiConstants.deleteNotification}/$notificationId",
      );
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e, "Unable to delete notification."));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // ============================================================
  // PARSE NOTIFICATIONS
  // ============================================================

  List<NotificationModel> _parseNotifications(dynamic data) {
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
