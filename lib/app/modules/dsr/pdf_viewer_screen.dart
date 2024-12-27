import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/core/utils/widgets/custom_appbar.dart';
import 'package:gashopper/app/core/utils/widgets/custom_loader.dart';
import 'package:get/get.dart';

import '../list/list_screen.dart';
import 'pdf_viewer_controller.dart';

class PdfViewerScreen extends StatefulWidget {
  final String? filePath;

  const PdfViewerScreen({super.key, this.filePath});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late PDFViewController _controller;
  int? _totalPages;
  int _currentPage = 0;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    if (widget.filePath == null || widget.filePath!.isEmpty) {
      return _buildErrorScreen('No PDF file specified');
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Pdf View',
        actionWidget: Row(
          children: [],
        ),
      ),
      body: Stack(
        children: [
          if (!_hasError)
            PDFView(
              filePath: widget.filePath,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onError: _handleError,
              onPageError: _handlePageError,
              onViewCreated: _handleViewCreated,
              onPageChanged: _handlePageChanged,
            ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          if (_hasError) _buildErrorScreen(_errorMessage),
        ],
      ),
      floatingActionButton: _buildNavigationButtons(),
    );
  }

  void _handleError(dynamic error) {
    setState(() {
      _hasError = true;
      _errorMessage = error.toString();
      _isLoading = false;
    });
  }

  void _handlePageError(int? page, dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error on page ${page ?? 'unknown'}: $error'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _handleViewCreated(PDFViewController controller) {
    setState(() {
      _controller = controller;
      _isLoading = false;
    });
    _loadTotalPages();
  }

  void _handlePageChanged(int? page, int? total) {
    if (mounted) {
      setState(() {
        _currentPage = page ?? 0;
        _totalPages = total;
      });
    }
  }

  Widget? _buildNavigationButtons() {
    if (_totalPages == null) return null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Page ${_currentPage + 1} of $_totalPages',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 12),
        FloatingActionButton(
          tooltip: 'Previous',
          backgroundColor: GashopperTheme.appYellow,
          elevation: 0,
          heroTag: 'prev',
          onPressed: _currentPage > 0 ? () => _controller.setPage(_currentPage - 1) : null,
          child: const Icon(Icons.navigate_before),
        ),
        const SizedBox(width: 12),
        FloatingActionButton(
          tooltip: 'Next',
          backgroundColor: GashopperTheme.appYellow,
          elevation: 0,
          heroTag: 'next',
          onPressed: _currentPage < (_totalPages! - 1)
              ? () => _controller.setPage(_currentPage + 1)
              : null,
          child: const Icon(Icons.navigate_next),
        ),
      ],
    );
  }

  Widget _buildErrorScreen(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadTotalPages() async {
    final total = await _controller.getPageCount();
    if (mounted) {
      setState(() {
        _totalPages = total;
      });
    }
  }
}

class PdfGeneratorView extends StatelessWidget {
  const PdfGeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PDFViewerController>(
      builder: (controller) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'DSR List',
            actionWidget: Row(
              children: [],
            ),
          ),
          body: controller.isLoading
              ? const Center(child: CustomLoader())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return ListCard(
                              customValueTextColor: Colors.green,
                              isPending: false,
                              title: 'Gasshopper PDF',
                              value: 'open',
                              onTap: controller.generateAndPreviewPdf,
                            ).ltrbPadding(0, 0, 0, 16);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
