import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// ───────────────────────── MODELS ─────────────────────────

class Contact {
  final String name;
  final String phone;
  final String email;
  final String category;
  final String avatarText;
  final int colorIndex;

  const Contact({
    required this.name,
    required this.phone,
    required this.email,
    required this.category,
    required this.avatarText,
    required this.colorIndex,
  });
}

class Category {
  final String name;
  final IconData icon;
  final Color color;
  final int count;

  const Category({
    required this.name,
    required this.icon,
    required this.color,
    required this.count,
  });
}

// ───────────────────────── DATA ─────────────────────────

const List<Color> avatarColors = [
  Color(0xFFFF6B6B),
  Color(0xFF6C63FF),
  Color(0xFF43B89C),
  Color(0xFFFFB347),
  Color(0xFFE91E8C),
  Color(0xFF00BCD4),
];

const List<Category> categories = [
  Category(name: 'Family',    icon: Icons.home_rounded,          color: Color(0xFFFF6B6B), count: 8),
  Category(name: 'Friends',   icon: Icons.people_rounded,        color: Color(0xFF6C63FF), count: 24),
  Category(name: 'Work',      icon: Icons.work_rounded,          color: Color(0xFF43B89C), count: 16),
  Category(name: 'School',    icon: Icons.school_rounded,        color: Color(0xFFFFB347), count: 12),
  Category(name: 'Gym',       icon: Icons.fitness_center_rounded,color: Color(0xFFE91E8C), count: 5),
  Category(name: 'Favorites', icon: Icons.star_rounded,          color: Color(0xFF00BCD4), count: 10),
];

const List<Contact> contacts = [
  Contact(name: 'Arjun',   phone: '+91 98765 43210', email: 'arjun@email.com',   category: 'Family',    avatarText: 'AS', colorIndex: 0),
  Contact(name: 'Deepak',   phone: '+91 87654 32109', email: 'Deepakl@email.com',   category: 'Friends',   avatarText: 'BP', colorIndex: 1),
  Contact(name: 'Adithya',   phone: '+91 76543 21098', email: 'adithya@email.com',   category: 'Work',      avatarText: 'CM', colorIndex: 2),
  Contact(name: 'Deon',     phone: '+91 65432 10987', email: 'deon@email.com',     category: 'School',    avatarText: 'DN', colorIndex: 3),
  Contact(name: 'Farida Khan',    phone: '+91 43210 98765', email: 'farida.khan@email.com',    category: 'Family',    avatarText: 'FK', colorIndex: 5),
  Contact(name: 'Gaurav Singh',   phone: '+91 32109 87654', email: 'gaurav.singh@email.com',   category: 'Friends',   avatarText: 'GS', colorIndex: 0),
  Contact(name: 'Harini Krishnan',phone: '+91 21098 76543', email: 'harini.krishnan@email.com',category: 'Work',      avatarText: 'HK', colorIndex: 1),
  Contact(name: 'Ishaan Verma',   phone: '+91 10987 65432', email: 'ishaan.verma@email.com',   category: 'School',    avatarText: 'IV', colorIndex: 2),
  Contact(name: 'Jaya Reddy',     phone: '+91 09876 54321', email: 'jaya.reddy@email.com',     category: 'Favorites', avatarText: 'JR', colorIndex: 3),
  Contact(name: 'Karthik Iyer',   phone: '+91 98765 12345', email: 'karthik.iyer@email.com',   category: 'Work',      avatarText: 'KI', colorIndex: 4),
  Contact(name: 'Lavanya Menon',  phone: '+91 87654 23456', email: 'lavanya.menon@email.com',  category: 'Friends',   avatarText: 'LM', colorIndex: 5),
  Contact(name: 'Manish Gupta',   phone: '+91 76543 34567', email: 'manish.gupta@email.com',   category: 'Family',    avatarText: 'MG', colorIndex: 0),
  Contact(name: 'Nisha Agarwal',  phone: '+91 65432 45678', email: 'nisha.agarwal@email.com',  category: 'Gym',       avatarText: 'NA', colorIndex: 1),
  Contact(name: 'Om Prakash',     phone: '+91 54321 56789', email: 'om.prakash@email.com',     category: 'School',    avatarText: 'OP', colorIndex: 2),
  Contact(name: 'Priya Desai',    phone: '+91 43210 67890', email: 'priya.desai@email.com',    category: 'Favorites', avatarText: 'PD', colorIndex: 3),
  Contact(name: 'Rahul Joshi',    phone: '+91 32109 78901', email: 'rahul.joshi@email.com',    category: 'Work',      avatarText: 'RJ', colorIndex: 4),
  Contact(name: 'Sneha Pillai',   phone: '+91 21098 89012', email: 'sneha.pillai@email.com',   category: 'Friends',   avatarText: 'SP', colorIndex: 5),
  Contact(name: 'Tanvir Ahmed',   phone: '+91 10987 90123', email: 'tanvir.ahmed@email.com',   category: 'Family',    avatarText: 'TA', colorIndex: 0),
  Contact(name: 'Usha Kumari',    phone: '+91 99887 01234', email: 'usha.kumari@email.com',    category: 'Favorites', avatarText: 'UK', colorIndex: 1),
];

// ───────────────────────── APP ─────────────────────────

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day 34 - Scrolling Widgets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
      ),
      home: const ContactListScreen(),
    );
  }
}

// ───────────────────────── MAIN SCREEN ─────────────────────────

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<Contact> get _filteredContacts {
    return contacts.where((c) {
      final matchCat = _selectedCategory == 'All' || c.category == _selectedCategory;
      final matchSearch = _searchQuery.isEmpty ||
          c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.phone.contains(_searchQuery);
      return matchCat && matchSearch;
    }).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showContactDetails(Contact contact) {
    final color = avatarColors[contact.colorIndex];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 36,
              backgroundColor: color,
              child: Text(contact.avatarText,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const SizedBox(height: 12),
            Text(contact.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
              child: Text(contact.category,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
            ),
            const SizedBox(height: 20),
            Row(children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.phone_rounded, color: color, size: 18),
              ),
              const SizedBox(width: 12),
              Text(contact.phone, style: const TextStyle(fontSize: 14, color: Color(0xFF2D3142))),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.mail_rounded, color: color, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(contact.email,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF2D3142)),
                  overflow: TextOverflow.ellipsis)),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.message_rounded, color: color),
                  label: Text('Message', style: TextStyle(color: color)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: color),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.call_rounded, color: Colors.white),
                  label: const Text('Call', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredContacts;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      // ══════════════════════════════════════════
      //  CustomScrollView  →  Slivers
      // ══════════════════════════════════════════
      body: CustomScrollView(
        slivers: [

          // ── 1. SliverAppBar (collapses on scroll) ──
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF6C63FF),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              title: const Text(
                'My Contacts',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF9C8FFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.person_add_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),

          // ── 2. SliverToBoxAdapter: Search bar ──
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 3))],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Search contacts...',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade400, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear_rounded, color: Colors.grey.shade400, size: 18),
                          onPressed: () { _searchController.clear(); setState(() => _searchQuery = ''); },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // ── 3. SliverToBoxAdapter: Category GridView ──
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                  child: Row(
                    children: [
                      const Icon(Icons.category_rounded, size: 20, color: Color(0xFF6C63FF)),
                      const SizedBox(width: 8),
                      const Text('Categories',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
                      const Spacer(),
                      TextButton(
                        onPressed: () => setState(() => _selectedCategory = 'All'),
                        child: Text('See All', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                      ),
                    ],
                  ),
                ),

                // ════════════════════════════════
                //  GridView  (crossAxisCount = 3)
                // ════════════════════════════════
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,        // fixed 3-column grid
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2.2,    // wider = shorter cards
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = _selectedCategory == cat.name;
                    return GestureDetector(
                      onTap: () => setState(() =>
                          _selectedCategory = isSelected ? 'All' : cat.name),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected ? cat.color : cat.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? cat.color : cat.color.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: isSelected
                              ? [BoxShadow(color: cat.color.withOpacity(0.35), blurRadius: 6, offset: const Offset(0, 2))]
                              : [],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(cat.icon, color: isSelected ? Colors.white : cat.color, size: 16),
                            const SizedBox(width: 5),
                            Text(cat.name,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : const Color(0xFF2D3142),
                                  fontSize: 10, fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // ── 4. SliverToBoxAdapter: Contact count header ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  const Icon(Icons.contacts_rounded, size: 18, color: Color(0xFF6C63FF)),
                  const SizedBox(width: 8),
                  Text(
                    _selectedCategory == 'All' ? 'All Contacts' : _selectedCategory,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${filtered.length} contacts',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF6C63FF))),
                  ),
                ],
              ),
            ),
          ),

          // ── 5. SliverList: Contact list (ListView.builder pattern) ──
          filtered.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        Text('No contacts found',
                            style: TextStyle(color: Colors.grey.shade400, fontSize: 16)),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  // ════════════════════════════════
                  //  ListView.builder  (via Sliver)
                  // ════════════════════════════════
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == filtered.length) return const SizedBox(height: 80);
                      final contact = filtered[index];
                      final color = avatarColors[contact.colorIndex];

                      // ════════════════════════════
                      //  ListTile
                      // ════════════════════════════
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: color,
                            child: Text(contact.avatarText,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                          title: Text(contact.name,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFF2D3142))),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Row(children: [
                                Icon(Icons.phone_rounded, size: 12, color: Colors.grey.shade400),
                                const SizedBox(width: 4),
                                Text(contact.phone,
                                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                              ]),
                              const SizedBox(height: 2),
                              Row(children: [
                                Icon(Icons.mail_rounded, size: 12, color: Colors.grey.shade400),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(contact.email,
                                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ]),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(contact.category,
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
                              ),
                              const SizedBox(height: 6),
                              Icon(Icons.chevron_right_rounded, color: Colors.grey.shade300, size: 18),
                            ],
                          ),
                          onTap: () => _showContactDetails(contact),
                        ),
                      );
                    },
                    childCount: filtered.length + 1,
                  ),
                ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF6C63FF),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text('New Contact',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}