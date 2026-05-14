import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveApp());
}

// ─────────────────────────────────────────────
//  APP ROOT
// ─────────────────────────────────────────────
class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day 33 – Responsive Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const DashboardScreen(),
    );
  }
}

// ─────────────────────────────────────────────
//  BREAKPOINTS
// ─────────────────────────────────────────────
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
}

// ─────────────────────────────────────────────
//  DASHBOARD SCREEN
//  Uses MediaQuery + LayoutBuilder to switch layouts
// ─────────────────────────────────────────────
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
    _NavItem(icon: Icons.bar_chart_rounded, label: 'Analytics'),
    _NavItem(icon: Icons.people_alt_rounded, label: 'Users'),
    _NavItem(icon: Icons.settings_rounded, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    // ── MediaQuery: read screen width ──
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= Breakpoints.mobile;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),

      // Mobile: bottom nav bar
      bottomNavigationBar: isTablet
          ? null
          : _MobileBottomNav(
              items: _navItems,
              selectedIndex: _selectedIndex,
              onTap: (i) => setState(() => _selectedIndex = i),
            ),

      // Mobile: appbar
      appBar: isTablet
          ? null
          : AppBar(
              backgroundColor: const Color(0xFF1E3A5F),
              foregroundColor: Colors.white,
              title: const Text(
                'Dashboard',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFF2563EB),
                    child: const Text('JD',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),

      body: LayoutBuilder(
        // ── LayoutBuilder: rebuild whenever constraints change ──
        builder: (context, constraints) {
          final bool isTabletLayout =
              constraints.maxWidth >= Breakpoints.mobile;

          if (isTabletLayout) {
            // ── TABLET: Sidebar + Main side by side (Row + Expanded) ──
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sidebar — fixed width via SizedBox, content uses Expanded
                _Sidebar(
                  items: _navItems,
                  selectedIndex: _selectedIndex,
                  onTap: (i) => setState(() => _selectedIndex = i),
                ),

                // Main content — Expanded fills remaining space
                Expanded(                          // <── EXPANDED
                  child: _MainContent(
                    selectedIndex: _selectedIndex,
                    isTablet: true,
                  ),
                ),
              ],
            );
          } else {
            // ── MOBILE: just the main content, nav via bottom bar ──
            return _MainContent(
              selectedIndex: _selectedIndex,
              isTablet: false,
            );
          }
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  SIDEBAR (Tablet only)
//  Uses Column + Expanded internally
// ─────────────────────────────────────────────
class _Sidebar extends StatelessWidget {
  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _Sidebar({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: double.infinity,
      color: const Color(0xFF1E3A5F),
      child: Column(                              // <── COLUMN
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo area
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 36, 20, 28),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.bolt_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Nexus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          // Nav items — Flexible allows list to take available space
          Flexible(                               // <── FLEXIBLE
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: items.length,
              itemBuilder: (_, i) => _SidebarTile(
                item: items[i],
                selected: selectedIndex == i,
                onTap: () => onTap(i),
              ),
            ),
          ),

          // User profile pinned to bottom
          const Divider(color: Colors.white12, height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFF2563EB),
                  child: Text('JD',
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 10),
                Expanded(                         // <── EXPANDED (name truncate)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Jane Doe',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis),
                      Text('Admin',
                          style: TextStyle(
                              color: Colors.white54, fontSize: 11)),
                    ],
                  ),
                ),
                const Icon(Icons.logout_rounded,
                    color: Colors.white38, size: 18),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF2563EB)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(item.icon,
                color: selected ? Colors.white : Colors.white54, size: 20),
            const SizedBox(width: 12),
            Text(
              item.label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.white60,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  MOBILE BOTTOM NAV
// ─────────────────────────────────────────────
class _MobileBottomNav extends StatelessWidget {
  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _MobileBottomNav({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1E3A5F),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, -2))
        ],
      ),
      child: Row(                                // <── ROW (bottom nav items)
        children: List.generate(
          items.length,
          (i) => Expanded(                       // <── EXPANDED (equal width tabs)
            child: GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[i].icon,
                      color: selectedIndex == i
                          ? const Color(0xFF60A5FA)
                          : Colors.white38,
                      size: 22,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[i].label,
                      style: TextStyle(
                        fontSize: 10,
                        color: selectedIndex == i
                            ? const Color(0xFF60A5FA)
                            : Colors.white38,
                        fontWeight: selectedIndex == i
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  MAIN CONTENT AREA
//  Uses LayoutBuilder to build responsive grid
// ─────────────────────────────────────────────
class _MainContent extends StatelessWidget {
  final int selectedIndex;
  final bool isTablet;

  const _MainContent({
    required this.selectedIndex,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isTablet) ...[
            // Tablet header row
            Row(
              children: [
                Expanded(                         // <── EXPANDED
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Good Morning, Jane 👋',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1E3A5F))),
                      SizedBox(height: 4),
                      Text('Here\'s what\'s happening today.',
                          style: TextStyle(
                              fontSize: 13, color: Colors.black45)),
                    ],
                  ),
                ),
                _DateChip(),
              ],
            ),
            const SizedBox(height: 24),
          ] else ...[
            const Text('Good Morning, Jane 👋',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E3A5F))),
            const SizedBox(height: 16),
          ],

          // ── STAT CARDS — LayoutBuilder picks column count ──
          LayoutBuilder(                          // <── LAYOUTBUILDER
            builder: (context, constraints) {
              final cols = constraints.maxWidth >= 500 ? 2 : 1;
              return _StatCardGrid(cols: cols);
            },
          ),

          const SizedBox(height: 20),

          // ── BOTTOM ROW: Chart + Recent — Flexible proportions ──
          LayoutBuilder(                          // <── LAYOUTBUILDER
            builder: (context, constraints) {
              if (constraints.maxWidth >= 600) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(                     // <── FLEXIBLE (flex:2 = 2/3 width)
                      flex: 2,
                      child: _ChartCard(),
                    ),
                    const SizedBox(width: 16),
                    Flexible(                     // <── FLEXIBLE (flex:1 = 1/3 width)
                      flex: 1,
                      child: _RecentActivityCard(),
                    ),
                  ],
                );
              }
              // Mobile: stacked
              return Column(
                children: [
                  _ChartCard(),
                  const SizedBox(height: 16),
                  _RecentActivityCard(),
                ],
              );
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  STAT CARD GRID
// ─────────────────────────────────────────────
class _StatCardGrid extends StatelessWidget {
  final int cols;
  const _StatCardGrid({required this.cols});

  static const _stats = [
    _StatData('Total Revenue', '\$48,295', '+12.5%', Icons.attach_money_rounded, Color(0xFF2563EB)),
    _StatData('Active Users', '8,421', '+3.2%', Icons.people_alt_rounded, Color(0xFF7C3AED)),
    _StatData('New Orders', '1,084', '+8.7%', Icons.shopping_bag_rounded, Color(0xFF059669)),
    _StatData('Bounce Rate', '24.3%', '-1.4%', Icons.trending_down_rounded, Color(0xFFDC2626)),
  ];

  @override
  Widget build(BuildContext context) {
    if (cols == 1) {
      return Column(
        children: _stats
            .map((s) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _StatCard(data: s),
                ))
            .toList(),
      );
    }
    // 2-column grid using Row + Expanded pairs
    return Column(
      children: [
        for (int i = 0; i < _stats.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(child: _StatCard(data: _stats[i])),   // <── EXPANDED
                const SizedBox(width: 12),
                Expanded(child: _StatCard(data: _stats[i + 1])), // <── EXPANDED
              ],
            ),
          ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final _StatData data;
  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isPositive = !data.change.startsWith('-');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: data.color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(                               // <── EXPANDED
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.label,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(data.value,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E3A5F))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isPositive
                  ? const Color(0xFF059669).withOpacity(0.1)
                  : const Color(0xFFDC2626).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              data.change,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isPositive
                    ? const Color(0xFF059669)
                    : const Color(0xFFDC2626),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CHART CARD (Bar chart simulation)
// ─────────────────────────────────────────────
class _ChartCard extends StatelessWidget {
  final _barData = const [
    _Bar('Mon', 0.55),
    _Bar('Tue', 0.80),
    _Bar('Wed', 0.65),
    _Bar('Thu', 0.90),
    _Bar('Fri', 0.72),
    _Bar('Sat', 0.45),
    _Bar('Sun', 0.60),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(                     // <── EXPANDED
                child: Text('Weekly Revenue',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E3A5F))),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('This Week',
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: Row(                           // <── ROW of bars
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _barData
                  .map((b) => Expanded(           // <── EXPANDED (equal bar widths)
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(           // <── FLEXIBLE
                                fit: FlexFit.loose,
                                child: FractionallySizedBox(
                                  heightFactor: b.value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF2563EB),
                                          Color(0xFF60A5FA)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(b.label,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.black38)),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  RECENT ACTIVITY CARD
// ─────────────────────────────────────────────
class _RecentActivityCard extends StatelessWidget {
  static const _activities = [
    _Activity('New user signup', '2m ago', Icons.person_add_rounded, Color(0xFF2563EB)),
    _Activity('Order #1042 placed', '15m ago', Icons.shopping_bag_rounded, Color(0xFF059669)),
    _Activity('Server alert', '1h ago', Icons.warning_rounded, Color(0xFFDC2626)),
    _Activity('Report generated', '3h ago', Icons.description_rounded, Color(0xFF7C3AED)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Activity',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3A5F))),
          const SizedBox(height: 14),
          ..._activities.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(               // <── ROW
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: a.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(a.icon, color: a.color, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(             // <── EXPANDED
                      child: Text(a.title,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E3A5F)),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(a.time,
                        style: const TextStyle(
                            fontSize: 11, color: Colors.black38)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DATE CHIP
// ─────────────────────────────────────────────
class _DateChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: const [
          Icon(Icons.calendar_today_rounded,
              size: 15, color: Color(0xFF2563EB)),
          SizedBox(width: 6),
          Text('May 14, 2026',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E3A5F))),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

class _StatData {
  final String label;
  final String value;
  final String change;
  final IconData icon;
  final Color color;
  const _StatData(this.label, this.value, this.change, this.icon, this.color);
}

class _Bar {
  final String label;
  final double value; // 0.0 – 1.0
  const _Bar(this.label, this.value);
}

class _Activity {
  final String title;
  final String time;
  final IconData icon;
  final Color color;
  const _Activity(this.title, this.time, this.icon, this.color);
}