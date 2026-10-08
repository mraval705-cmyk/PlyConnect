# PlyConnect - Widget Documentation

Ye file batata hai ki har page me kaun kaun se Flutter widgets use hue hain
aur har page me kitne widgets hain.
Sirf wo widgets count hue hain jo code me sach me use hue hain, comment nahi.

- Total screens/files: 60
- Total widget types used: 758
- Total widget uses: 1633

## 1. Har page me kitne widgets

Widget types = alag alag widget. Total uses = wo widget kitni baar code me likha gaya.

| # | Page (file) | Lines | Widget types | Total uses |
|---|-------------|-------|--------------|------------|
| 1 | `guest/home.dart` | 518 | 24 | 78 |
| 2 | `admin/local_products.dart` | 658 | 20 | 70 |
| 3 | `guest/browse_products.dart` | 451 | 24 | 61 |
| 4 | `admin/reports_page.dart` | 548 | 18 | 58 |
| 5 | `admin/manage_products.dart` | 397 | 26 | 56 |
| 6 | `admin/stock_management.dart` | 425 | 26 | 54 |
| 7 | `guest/product_details.dart` | 326 | 19 | 52 |
| 8 | `user/order_summary.dart` | 368 | 20 | 49 |
| 9 | `user/my_orders.dart` | 307 | 18 | 47 |
| 10 | `admin/manage_orders.dart` | 321 | 19 | 47 |
| 11 | `admin/admin_profile.dart` | 346 | 22 | 46 |
| 12 | `signup.dart` | 332 | 18 | 42 |
| 13 | `guest/contact_shop.dart` | 265 | 15 | 42 |
| 14 | `guest/select_product.dart` | 345 | 16 | 41 |
| 15 | `login.dart` | 356 | 21 | 41 |
| 16 | `user/my_profile.dart` | 302 | 16 | 39 |
| 17 | `components/product_form.dart` | 441 | 20 | 39 |
| 18 | `user/order_success.dart` | 236 | 17 | 38 |
| 19 | `user/payment.dart` | 297 | 15 | 38 |
| 20 | `admin/manage_customers.dart` | 277 | 19 | 38 |
| 21 | `components/brand_form.dart` | 325 | 20 | 36 |
| 22 | `admin/manage_brands.dart` | 206 | 18 | 36 |
| 23 | `components/category_form.dart` | 303 | 20 | 36 |
| 24 | `guest/compare_products.dart` | 245 | 16 | 34 |
| 25 | `admin/edit_admin_profile.dart` | 238 | 20 | 34 |
| 26 | `user/wishlist.dart` | 224 | 17 | 34 |
| 27 | `admin/admin_login.dart` | 230 | 19 | 33 |
| 28 | `user/edit_address.dart` | 218 | 14 | 32 |
| 29 | `admin/manage_categories.dart` | 175 | 17 | 31 |
| 30 | `user/change_password.dart` | 254 | 16 | 30 |
| 31 | `user/edit_profile.dart` | 209 | 16 | 28 |
| 32 | `guest/welcome.dart` | 153 | 14 | 27 |
| 33 | `components/admin/product_form.dart` | 117 | 9 | 24 |
| 34 | `guest/categories_page.dart` | 179 | 11 | 22 |
| 35 | `admin/customer_details.dart` | 179 | 10 | 21 |
| 36 | `admin/admin_dashboard.dart` | 177 | 11 | 19 |
| 37 | `components/admin/order_detail_sheet.dart` | 133 | 11 | 19 |
| 38 | `admin/admin_menu_page.dart` | 203 | 10 | 18 |
| 39 | `guest/brand_products.dart` | 129 | 11 | 17 |
| 40 | `components/admin/product_card.dart` | 113 | 8 | 15 |
| 41 | `components/guest_page.dart` | 87 | 6 | 15 |
| 42 | `admin/dashboard_stats.dart` | 101 | 5 | 13 |
| 43 | `splash.dart` | 85 | 8 | 11 |
| 44 | `components/admin/animated_number.dart` | 85 | 4 | 10 |
| 45 | `components/admin/low_stock_row.dart` | 74 | 8 | 9 |
| 46 | `components/admin/recent_order_row.dart` | 92 | 6 | 8 |
| 47 | `components/admin/stat_card.dart` | 76 | 7 | 8 |
| 48 | `components/admin/pulsing_dot.dart` | 68 | 6 | 7 |
| 49 | `components/admin/loading_ring.dart` | 73 | 6 | 7 |
| 50 | `components/admin/section_box.dart` | 52 | 6 | 6 |
| 51 | `resources/theme_resources.dart` | 59 | 3 | 5 |
| 52 | `admin/low_stock_section.dart` | 64 | 2 | 2 |
| 53 | `admin/recent_orders_section.dart` | 35 | 2 | 2 |
| 54 | `main.dart` | 28 | 2 | 2 |
| 55 | `admin/add_product.dart` | 17 | 1 | 1 |
| 56 | `admin/add_category.dart` | 11 | 1 | 1 |
| 57 | `admin/add_brand.dart` | 18 | 1 | 1 |
| 58 | `admin/edit_product.dart` | 24 | 1 | 1 |
| 59 | `admin/edit_category.dart` | 11 | 1 | 1 |
| 60 | `admin/edit_brand.dart` | 24 | 1 | 1 |

## 2. Unit wise widgets, har page me


## Unit 2 - Layout and screens

| # | File | Widgets |
|---|------|---------|
| 1 | `admin/add_brand.dart` | StatelessWidget |
| 2 | `admin/add_category.dart` | StatelessWidget |
| 3 | `admin/add_product.dart` | StatelessWidget |
| 4 | `admin/admin_dashboard.dart` | Scaffold, AppBar, SafeArea, ListTile, Container, StatelessWidget |
| 5 | `admin/admin_login.dart` | Scaffold, AppBar, SafeArea, Column, StatefulWidget |
| 6 | `admin/admin_menu_page.dart` | Scaffold, AppBar, Column, Row, Container, StatelessWidget |
| 7 | `admin/admin_profile.dart` | Scaffold, AppBar, SafeArea, ListTile, Column, Row, Container, StatelessWidget |
| 8 | `admin/customer_details.dart` | Scaffold, AppBar, Column, Row, Container, StatelessWidget |
| 9 | `admin/dashboard_stats.dart` | Column, Row, StatelessWidget |
| 10 | `admin/edit_admin_profile.dart` | Scaffold, AppBar, SafeArea, Column, Container, StatefulWidget |
| 11 | `admin/edit_brand.dart` | StatelessWidget |
| 12 | `admin/edit_category.dart` | StatelessWidget |
| 13 | `admin/edit_product.dart` | StatelessWidget |
| 14 | `admin/local_products.dart` | Scaffold, AppBar, Column, Row, Container, StatelessWidget, StatefulWidget |
| 15 | `admin/low_stock_section.dart` | Column, StatelessWidget |
| 16 | `admin/manage_brands.dart` | Scaffold, AppBar, SafeArea, Column, Row, Container, StatefulWidget |
| 17 | `admin/manage_categories.dart` | Scaffold, AppBar, SafeArea, Column, Row, Container, StatefulWidget |
| 18 | `admin/manage_customers.dart` | Scaffold, AppBar, SafeArea, Column, Row, Container, StatefulWidget |
| 19 | `admin/manage_orders.dart` | Scaffold, AppBar, SafeArea, Column, Row, Container, StatefulWidget |
| 20 | `admin/manage_products.dart` | Scaffold, AppBar, SafeArea, Column, Row, Container, StatefulWidget |
| 21 | `admin/recent_orders_section.dart` | Column, StatelessWidget |
| 22 | `admin/reports_page.dart` | Scaffold, AppBar, Column, Row, Container, StatefulWidget |
| 23 | `admin/stock_management.dart` | Scaffold, AppBar, SafeArea, Column, Row, Container, StatefulWidget |
| 24 | `components/admin/animated_number.dart` | Container, StatelessWidget |
| 25 | `components/admin/loading_ring.dart` | Container, StatefulWidget |
| 26 | `components/admin/low_stock_row.dart` | Column, Row, Container, StatelessWidget |
| 27 | `components/admin/order_detail_sheet.dart` | Row, Container, StatelessWidget |
| 28 | `components/admin/product_card.dart` | Column, Row, Container, StatelessWidget |
| 29 | `components/admin/product_form.dart` | Column, Row, Container, StatelessWidget |
| 30 | `components/admin/pulsing_dot.dart` | Container, StatefulWidget |
| 31 | `components/admin/recent_order_row.dart` | Column, Row, Container, StatelessWidget |
| 32 | `components/admin/section_box.dart` | Column, Row, Container, StatelessWidget |
| 33 | `components/admin/stat_card.dart` | Column, Row, Container, StatelessWidget |
| 34 | `components/brand_form.dart` | Scaffold, AppBar, SafeArea, Column, Row, Container, StatefulWidget |
| 35 | `components/category_form.dart` | Scaffold, AppBar, SafeArea, Column, Row, Container, StatefulWidget |
| 36 | `components/guest_page.dart` | Scaffold, AppBar, BottomNavigationBar, SafeArea, StatelessWidget |
| 37 | `components/product_form.dart` | Scaffold, AppBar, SafeArea, Column, Container, StatefulWidget |
| 38 | `guest/brand_products.dart` | Scaffold, AppBar, Column, Row, Container, StatelessWidget |
| 39 | `guest/browse_products.dart` | Scaffold, AppBar, BottomNavigationBar, Column, Row, Container, StatefulWidget |
| 40 | `guest/categories_page.dart` | Scaffold, AppBar, Column, Row, Container, StatelessWidget |
| 41 | `guest/compare_products.dart` | Scaffold, Column, Row, Container, StatelessWidget |
| 42 | `guest/contact_shop.dart` | Scaffold, ListTile, Column, Row, Container, StatelessWidget |
| 43 | `guest/home.dart` | Scaffold, AppBar, Drawer, BottomNavigationBar, SafeArea, ListTile, Column, Row, Container, StatefulWidget |
| 44 | `guest/product_details.dart` | Scaffold, AppBar, BottomNavigationBar, Column, Row, Container, StatelessWidget |
| 45 | `guest/select_product.dart` | Scaffold, Column, Row, Container, StatefulWidget |
| 46 | `guest/welcome.dart` | Scaffold, SafeArea, Column, Row, StatelessWidget |
| 47 | `login.dart` | Scaffold, AppBar, SafeArea, Column, Row, Container, StatefulWidget |
| 48 | `main.dart` | MaterialApp, StatelessWidget |
| 49 | `resources/theme_resources.dart` | AppBar |
| 50 | `signup.dart` | Scaffold, AppBar, SafeArea, Column, StatefulWidget |
| 51 | `splash.dart` | Scaffold, SafeArea, Column, StatefulWidget |
| 52 | `user/change_password.dart` | Scaffold, AppBar, SafeArea, Column, Container, StatefulWidget |
| 53 | `user/edit_address.dart` | Scaffold, AppBar, SafeArea, Column, StatefulWidget |
| 54 | `user/edit_profile.dart` | Scaffold, AppBar, SafeArea, Column, Container, StatefulWidget |
| 55 | `user/my_orders.dart` | Scaffold, Column, Row, Container, StatefulWidget |
| 56 | `user/my_profile.dart` | Scaffold, ListTile, Column, Row, Container, StatefulWidget |
| 57 | `user/order_success.dart` | Scaffold, Column, Row, Container, StatelessWidget |
| 58 | `user/order_summary.dart` | Scaffold, Column, Row, Container, StatefulWidget |
| 59 | `user/payment.dart` | Scaffold, ListTile, Column, Row, Container, StatefulWidget |
| 60 | `user/wishlist.dart` | Scaffold, Column, Row, Container, StatefulWidget |

## Unit 3 - Buttons and inputs

| # | File | Widgets |
|---|------|---------|
| 1 | `admin/admin_dashboard.dart` | IconButton, SnackBar, ScaffoldMessenger, Icon |
| 2 | `admin/admin_login.dart` | ElevatedButton, TextButton, IconButton, TextFormField, Form, SnackBar, ScaffoldMessenger, CircularProgressIndicator, Image.asset, Icon |
| 3 | `admin/admin_menu_page.dart` | Icon |
| 4 | `admin/admin_profile.dart` | ElevatedButton, TextButton, TextField, AlertDialog, SnackBar, ScaffoldMessenger, Image.asset, Icon, Divider |
| 5 | `admin/edit_admin_profile.dart` | ElevatedButton, OutlinedButton, IconButton, TextFormField, Form, SnackBar, ScaffoldMessenger, Image.asset, Icon |
| 6 | `admin/local_products.dart` | ElevatedButton, OutlinedButton, IconButton, TextField, SnackBar, ScaffoldMessenger, CircularProgressIndicator, Icon |
| 7 | `admin/manage_brands.dart` | ElevatedButton, IconButton, TextField, SnackBar, ScaffoldMessenger, Image.asset, Icon |
| 8 | `admin/manage_categories.dart` | ElevatedButton, IconButton, TextField, SnackBar, ScaffoldMessenger, Icon |
| 9 | `admin/manage_customers.dart` | IconButton, TextField, SnackBar, ScaffoldMessenger, Icon |
| 10 | `admin/manage_orders.dart` | ElevatedButton, OutlinedButton, TextField, SnackBar, ScaffoldMessenger, Icon, Divider |
| 11 | `admin/manage_products.dart` | ElevatedButton, OutlinedButton, TextButton, IconButton, FloatingActionButton, Checkbox, TextField, AlertDialog, SnackBar, ScaffoldMessenger, Image.asset, Icon |
| 12 | `admin/reports_page.dart` | OutlinedButton, DropdownButton, Switch, SwitchListTile, showDatePicker, Icon, Divider |
| 13 | `admin/stock_management.dart` | OutlinedButton, TextButton, Checkbox, CheckboxListTile, Slider, TextField, AlertDialog, ExpansionTile, SnackBar, ScaffoldMessenger, LinearProgressIndicator, Icon, Divider |
| 14 | `components/admin/low_stock_row.dart` | TextButton, Icon |
| 15 | `components/admin/order_detail_sheet.dart` | IconButton, showModalBottomSheet, Icon |
| 16 | `components/admin/product_card.dart` | IconButton, Icon |
| 17 | `components/admin/product_form.dart` | ElevatedButton, OutlinedButton, TextField |
| 18 | `components/admin/stat_card.dart` | Icon |
| 19 | `components/brand_form.dart` | ElevatedButton, OutlinedButton, TextButton, TextFormField, Form, SnackBar, ScaffoldMessenger, CircularProgressIndicator, Image.asset, Icon |
| 20 | `components/category_form.dart` | ElevatedButton, OutlinedButton, TextButton, TextFormField, Form, SnackBar, ScaffoldMessenger, CircularProgressIndicator, Image.asset, Icon |
| 21 | `components/guest_page.dart` | Icon |
| 22 | `components/product_form.dart` | ElevatedButton, OutlinedButton, TextButton, DropdownButton, DropdownButtonFormField, TextFormField, Form, SnackBar, ScaffoldMessenger, CircularProgressIndicator, Image.asset, Icon |
| 23 | `guest/brand_products.dart` | OutlinedButton, Image.asset |
| 24 | `guest/browse_products.dart` | ElevatedButton, IconButton, DropdownButton, TextField, SnackBar, ScaffoldMessenger, Image.asset, Icon |
| 25 | `guest/categories_page.dart` | Image.asset, Icon |
| 26 | `guest/compare_products.dart` | ElevatedButton, OutlinedButton, SnackBar, ScaffoldMessenger, Image.asset |
| 27 | `guest/contact_shop.dart` | ElevatedButton, SnackBar, ScaffoldMessenger, Image.asset, Icon, Divider |
| 28 | `guest/home.dart` | ElevatedButton, TextButton, IconButton, TextField, SnackBar, ScaffoldMessenger, Image.asset, Icon |
| 29 | `guest/product_details.dart` | ElevatedButton, OutlinedButton, IconButton, SnackBar, ScaffoldMessenger, Image.asset, Icon, Divider |
| 30 | `guest/select_product.dart` | ElevatedButton, DropdownButton, TextField, SnackBar, ScaffoldMessenger, Image.asset, Icon |
| 31 | `guest/welcome.dart` | ElevatedButton, OutlinedButton, Image.asset, Icon |
| 32 | `login.dart` | ElevatedButton, TextButton, IconButton, TextFormField, Form, SnackBar, ScaffoldMessenger, CircularProgressIndicator, Icon |
| 33 | `resources/theme_resources.dart` | ElevatedButton, OutlinedButton |
| 34 | `signup.dart` | ElevatedButton, TextButton, TextFormField, Form, SnackBar, ScaffoldMessenger, CircularProgressIndicator, Image.asset, Icon |
| 35 | `splash.dart` | CircularProgressIndicator, Image.asset |
| 36 | `user/change_password.dart` | ElevatedButton, OutlinedButton, IconButton, TextFormField, Form, SnackBar, ScaffoldMessenger, Icon |
| 37 | `user/edit_address.dart` | ElevatedButton, OutlinedButton, TextFormField, Form, SnackBar, ScaffoldMessenger, Icon |
| 38 | `user/edit_profile.dart` | ElevatedButton, OutlinedButton, TextFormField, Form, SnackBar, ScaffoldMessenger, Icon |
| 39 | `user/my_orders.dart` | ElevatedButton, OutlinedButton, TextField, SnackBar, ScaffoldMessenger, Image.asset, Icon, Divider |
| 40 | `user/my_profile.dart` | TextButton, SnackBar, ScaffoldMessenger, Icon, Divider |
| 41 | `user/order_success.dart` | ElevatedButton, OutlinedButton, TextButton, SnackBar, ScaffoldMessenger, Image.asset, Icon, Divider |
| 42 | `user/order_summary.dart` | ElevatedButton, TextButton, IconButton, TextField, TextFormField, Form, SnackBar, ScaffoldMessenger, Image.asset, Icon, Divider |
| 43 | `user/payment.dart` | ElevatedButton, OutlinedButton, SnackBar, ScaffoldMessenger, Image.asset, Icon |
| 44 | `user/wishlist.dart` | ElevatedButton, OutlinedButton, IconButton, SnackBar, ScaffoldMessenger, Image.asset, Icon, Divider |

## Unit 4 - Positioning and lists

| # | File | Widgets |
|---|------|---------|
| 1 | `admin/admin_dashboard.dart` | ListView |
| 2 | `admin/admin_login.dart` | Center, Align, SizedBox, SingleChildScrollView |
| 3 | `admin/admin_menu_page.dart` | SizedBox, Expanded, ListView |
| 4 | `admin/admin_profile.dart` | Center, Padding, SizedBox, Expanded, SingleChildScrollView |
| 5 | `admin/customer_details.dart` | Center, SizedBox, Expanded, SingleChildScrollView |
| 6 | `admin/dashboard_stats.dart` | SizedBox, Expanded |
| 7 | `admin/edit_admin_profile.dart` | Center, SizedBox, Stack, Positioned, SingleChildScrollView |
| 8 | `admin/local_products.dart` | Center, Padding, SizedBox, Expanded, SingleChildScrollView |
| 9 | `admin/manage_brands.dart` | Padding, SizedBox, Expanded, ListView |
| 10 | `admin/manage_categories.dart` | Padding, SizedBox, Expanded, ListView |
| 11 | `admin/manage_customers.dart` | Center, Padding, SizedBox, Expanded, ListView, FutureBuilder, RefreshIndicator |
| 12 | `admin/manage_orders.dart` | Padding, SizedBox, Expanded, ListView, SingleChildScrollView |
| 13 | `admin/manage_products.dart` | Center, Padding, SizedBox, Expanded, ListView, Wrap |
| 14 | `admin/reports_page.dart` | Padding, SizedBox, Expanded, Table, SingleChildScrollView |
| 15 | `admin/stock_management.dart` | Center, Align, Padding, SizedBox, Expanded, ListView |
| 16 | `components/admin/loading_ring.dart` | Align, SizedBox |
| 17 | `components/admin/low_stock_row.dart` | SizedBox, Expanded |
| 18 | `components/admin/order_detail_sheet.dart` | Center, Padding, SizedBox, ListView, Table |
| 19 | `components/admin/product_card.dart` | SizedBox, Expanded |
| 20 | `components/admin/product_form.dart` | SizedBox, Expanded |
| 21 | `components/admin/recent_order_row.dart` | SizedBox, Expanded |
| 22 | `components/admin/section_box.dart` | SizedBox, Expanded |
| 23 | `components/admin/stat_card.dart` | SizedBox, Expanded |
| 24 | `components/brand_form.dart` | SizedBox, Expanded, SingleChildScrollView |
| 25 | `components/category_form.dart` | SizedBox, Expanded, SingleChildScrollView |
| 26 | `components/product_form.dart` | SizedBox, SingleChildScrollView |
| 27 | `guest/brand_products.dart` | SizedBox, Expanded, ListView |
| 28 | `guest/browse_products.dart` | Align, Padding, SizedBox, Expanded, Stack, Positioned, SingleChildScrollView, Wrap, LayoutBuilder |
| 29 | `guest/categories_page.dart` | SizedBox, Expanded, ListView |
| 30 | `guest/compare_products.dart` | Padding, SizedBox, Expanded, Table, SingleChildScrollView, LayoutBuilder |
| 31 | `guest/contact_shop.dart` | SizedBox, Expanded, SingleChildScrollView |
| 32 | `guest/home.dart` | Padding, SizedBox, ListView, SingleChildScrollView, Wrap, LayoutBuilder |
| 33 | `guest/product_details.dart` | Padding, SizedBox, Expanded, SingleChildScrollView |
| 34 | `guest/select_product.dart` | Padding, SizedBox, Expanded, SingleChildScrollView |
| 35 | `guest/welcome.dart` | Padding, SizedBox, ConstrainedBox, SingleChildScrollView, LayoutBuilder |
| 36 | `login.dart` | Align, SizedBox, Expanded, SingleChildScrollView, Wrap |
| 37 | `signup.dart` | Center, SizedBox, SingleChildScrollView, Wrap |
| 38 | `splash.dart` | Center, SizedBox |
| 39 | `user/change_password.dart` | SizedBox, SingleChildScrollView |
| 40 | `user/edit_address.dart` | SizedBox, SingleChildScrollView |
| 41 | `user/edit_profile.dart` | Center, SizedBox, SingleChildScrollView |
| 42 | `user/my_orders.dart` | Padding, SizedBox, Expanded, ListView, SingleChildScrollView |
| 43 | `user/my_profile.dart` | Center, Padding, SizedBox, Expanded, SingleChildScrollView |
| 44 | `user/order_success.dart` | Padding, SizedBox, Expanded, SingleChildScrollView |
| 45 | `user/order_summary.dart` | Padding, SizedBox, Expanded, SingleChildScrollView |
| 46 | `user/payment.dart` | SizedBox, Expanded, SingleChildScrollView |
| 47 | `user/wishlist.dart` | Padding, SizedBox, Expanded, ListView |

## Unit 5 - Animation

| # | File | Widgets |
|---|------|---------|
| 1 | `admin/manage_products.dart` | AnimatedSize |
| 2 | `components/admin/animated_number.dart` | Tween, TweenAnimationBuilder |
| 3 | `components/admin/loading_ring.dart` | AnimatedBuilder, AnimationController |
| 4 | `components/admin/pulsing_dot.dart` | AnimationController, Tween, FadeTransition, ScaleTransition |

## 3. Syllabus widgets not used anywhere

- Card
- RadioListTile
- Radio
- SimpleDialog
- AspectRatio
- FittedBox
- Flexible
- GridView
- CustomScrollView
- SliverAppBar
- Builder
- StreamBuilder
- ReorderableListView
- AnimatedContainer
- AnimatedOpacity
- AnimatedAlign
- AnimatedScale
- AnimatedRotation
- AnimatedList
- AnimatedSwitcher
- SlideTransition
- Hero
