import 'package:flutter/material.dart';
import 'package:hoa_lo_ar_discovery/utils/database_manager.dart';
import '../widgets/detail.dart';

class ItemCard extends StatefulWidget {
  final VoidCallback onTap;
  final DatabaseItem item;
  final String selectedLanguage;

  const ItemCard({
    Key? key,
    required this.onTap,
    required this.item,
    required this.selectedLanguage,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    // Chọn dữ liệu ngôn ngữ phù hợp dựa trên `_selectedLanguage`
    Map<String, dynamic> itemTextData = _selectedLanguage == 'Vietnamese'
        ? widget.item.vietnamese
        : widget.item.english;

    return Card(
      elevation: 10,
      color: Colors.brown,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 455,
        width: 280,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 190,
                width: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(widget.item.images.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              itemTextData['name'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              itemTextData['detail'],
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                        item: widget.item, selectedLanguage: _selectedLanguage),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(double.maxFinite, 44),
              ),
              child: Text(
                _selectedLanguage == 'Vietnamese'
                    ? 'Xem chi tiết'
                    : 'View Details',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
