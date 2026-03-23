import 'package:invitaty/api/invitaty_api.dart';
import 'package:invitaty/core/global_functions.dart';
import 'package:invitaty/generated/l10n.dart';
import 'package:invitaty/widget/components_widgets.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> _notificationList = [];
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = true;
  bool _isProcessing = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _shouldLoadMore = true;

  int _totalNotifications = 0;
  int _currentPage = 1;
  int _totalPages = 1;
  static const int _perPage = 20;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_hasMore && !_isLoadingMore) _loadMoreNotifications();
    }
  }

  Future<void> _fetchNotifications() async {
    setState(() {
      _isLoading = true;
      _hasMore = true;
      _shouldLoadMore = true;
    });

    final response = await InvitatyApi.getNotifications(page: 1, perPage: _perPage);
    if (!mounted) return;

    final list = response['notifications'] as List<Map<String, dynamic>>;
    setState(() {
      _totalNotifications = response['total'] as int? ?? 0;
      _notificationList
        ..clear()
        ..addAll(list);
      _currentPage = response['page'] as int? ?? 1;
      _totalPages = response['total_pages'] as int? ?? 1;
      _hasMore = _currentPage < _totalPages;
      _isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_shouldLoadMore && _hasMore) _checkIfNeedMoreNotifications();
    });
  }

  void _checkIfNeedMoreNotifications() {
    if (!_scrollController.hasClients) return;
    final viewportHeight = _scrollController.position.viewportDimension;
    final contentHeight =
        _scrollController.position.maxScrollExtent + viewportHeight;
    if (contentHeight < viewportHeight && _hasMore && !_isLoadingMore) {
      _loadMoreNotifications();
    } else {
      _shouldLoadMore = false;
    }
  }

  Future<void> _loadMoreNotifications() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);

    final nextPage = _currentPage + 1;
    final response =
        await InvitatyApi.getNotifications(page: nextPage, perPage: _perPage);
    if (!mounted) return;

    final list = response['notifications'] as List<Map<String, dynamic>>;
    setState(() {
      _notificationList.addAll(list);
      _currentPage = response['page'] as int? ?? nextPage;
      _totalPages = response['total_pages'] as int? ?? _totalPages;
      _hasMore = _currentPage < _totalPages;
      _isLoadingMore = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_shouldLoadMore && _hasMore) _checkIfNeedMoreNotifications();
    });
  }

  Future<void> _markNotificationAsRead(int notificationId) async {
    setState(() => _isProcessing = true);
    final ok = await InvitatyApi.markNotificationAsRead(notificationId);
    if (!mounted) return;

    if (ok) {
      setState(() {
        if (notificationId == 0) {
          for (final n in _notificationList) {
            n['read_status'] = true;
          }
        } else {
          final idx = _notificationList.indexWhere((n) => n['id'] == notificationId);
          if (idx != -1) _notificationList[idx]['read_status'] = true;
        }
      });
      showCustomSnackBar(
        notificationId == 0
            ? S.current.notificationsAllMarkedRead
            : S.current.notificationMarkedRead,
        type: 1,
      );
    } else {
      showCustomSnackBar(S.current.notificationMarkReadError, type: -1);
    }
    setState(() => _isProcessing = false);
  }

  Future<void> _deleteAllNotifications() async {
    setState(() => _isProcessing = true);
    final ok = await InvitatyApi.deleteNotifications(notificationId: 0);
    if (!mounted) return;
    setState(() => _isProcessing = false);

    if (ok) {
      showCustomSnackBar(S.current.notificationsDeletedOk, type: 1);
      await _fetchNotifications();
    } else {
      showCustomSnackBar(S.current.notificationsDeletedError, type: -1);
    }
  }

  bool _areAllNotificationsRead() {
    return _notificationList.every((n) => n['read_status'] == true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              '${S.current.notificationsLabel}${_totalNotifications > 0 ? ' ($_totalNotifications)' : ''}',
            ),
            actions: [
              if (MediaQuery.of(context).size.width > 800)
                Tooltip(
                  message: S.current.buttonReloadNotifications,
                  child: IconButton(
                    icon: const Icon(Icons.refresh_rounded),
                    onPressed: _fetchNotifications,
                  ),
                ),
              if (_notificationList.isNotEmpty && !_areAllNotificationsRead())
                Tooltip(
                  message: S.current.markAllAsRead,
                  child: IconButton(
                    icon: const Icon(Icons.mark_email_read_rounded),
                    onPressed: () async {
                      final confirmed = await showConfirmDialogGlobal(
                        context,
                        title: S.current.markAllAsRead,
                        message: S.current.notificationMarkAllAsk,
                      );
                      if (confirmed) await _markNotificationAsRead(0);
                    },
                  ),
                ),
              if (_notificationList.isNotEmpty)
                Tooltip(
                  message: S.current.deleteAllNotifications,
                  child: IconButton(
                    icon: const Icon(Icons.delete_forever_rounded),
                    onPressed: () async {
                      final confirmed = await showConfirmDialogGlobal(
                        context,
                        title: S.current.deleteAllNotifications,
                        message: S.current.notificationDeleteAllAsk,
                        destructive: true,
                      );
                      if (confirmed) await _deleteAllNotifications();
                    },
                  ),
                ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _notificationList.isEmpty
                    ? emptyDataWidget(
                        context,
                        Icons.notifications_none_rounded,
                        S.current.notificationsEmptyText,
                        '',
                      )
                    : RefreshIndicator(
                        onRefresh: _fetchNotifications,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(8),
                          itemCount: _notificationList.length + 1,
                          itemBuilder: (context, index) {
                          if (index == _notificationList.length) {
                            if (_isLoadingMore) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            if (!_hasMore) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: Text(
                                    S.current.noMoreRecords,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }

                          final notification = _notificationList[index];
                          final isRead = notification['read_status'] == true;
                          final notificationId =
                              (notification['id'] as num?)?.toInt() ?? 0;

                            return Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 800),
                              child: Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                elevation: isRead ? 1 : 3,
                                color: isRead
                                    ? null
                                    : Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withValues(alpha: 0.3),
                                child: InkWell(
                                  onTap: () async {
                                    if (!isRead && notificationId != 0) {
                                      await _markNotificationAsRead(notificationId);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 2),
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: isRead
                                                ? Colors.transparent
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (notification['title'] as String?) ??
                                                    '',
                                                style: TextStyle(
                                                  fontWeight: isRead
                                                      ? FontWeight.w500
                                                      : FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                (notification['message'] as String?) ??
                                                    '',
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                formatDate(
                                                  (notification['created_at']
                                                              as String?) ??
                                                          '',
                                                  showTime: true,
                                                ),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withValues(alpha: 0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            );
                          },
                        ),
                      ),
          ),
        ),
        if (_isProcessing)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.25),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
