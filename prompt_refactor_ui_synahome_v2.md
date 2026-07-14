# PROMPT — Refactor toàn bộ UI SynaHome (Flutter) sang Glassmorphism

## 0. BỐI CẢNH DỰ ÁN

Repo: **SynaHome_Application** — Flutter, Riverpod, go_router (`StatefulShellRoute.indexedStack`), l10n (vi/en), theme sẵn có ở `lib/app/theme/`.

**Phân biệt rõ 2 thư mục (quan trọng):**
- `lib/` — **source code Dart thật của app**. Đây là nơi bạn sửa.
- `stitch_syna_home_systems/` — **KHÔNG phải code Flutter**. Đây là output của Google Stitch: mỗi màn có `code.html` + `screen.png`, cộng `lumina_ambient/DESIGN.md` (bộ color token Material). Đây chỉ là **tài liệu tham chiếu thiết kế** — bạn ĐỌC để lấy layout/ý tưởng, **TUYỆT ĐỐI KHÔNG port HTML sang Flutter kiểu 1-1, không copy class CSS**.

**Mục tiêu:** giao diện hiện tại chạy được nhưng nhìn quá "mặc định Material". Tôi muốn **refactor toàn bộ tầng UI** sang một **design system Glassmorphism** thống nhất, cao cấp, hợp gu smart-home. Bảng màu và hướng thẩm mỹ **do bạn quyết định**, miễn là:
- Tất cả screen dùng **chung một design system** — không màn nào lạc quẻ.
- Đẹp hơn hẳn hiện tại, không chỉ "bọc thêm blur".

---

## 1. BƯỚC 1 — KHẢO SÁT, CHƯA ĐƯỢC VIẾT CODE

Trước khi sửa bất kỳ file nào, xuất ra:

1. **Bảng mapping**: mỗi file trong `lib/features/**/presentation/*.dart` → màn Stitch tương ứng (`stitch_syna_home_systems/<folder>/screen.png`) → mức độ thay đổi (Áp design system / Refactor sâu / Viết lại).
2. **Bảng design tokens** bạn đề xuất (màu, blur, radius, elevation, typography) + 1 đoạn giải thích ngắn vì sao hướng màu đó hợp smart-home.
3. Danh sách widget dùng chung sẽ tạo.

Chỉ khi ba mục trên xuất hiện trong output, bạn mới được bắt đầu code.

---

## 2. DESIGN SYSTEM GLASSMORPHISM (nền tảng cho MỌI screen)

### Nơi đặt code
- Mở rộng `lib/app/theme/`: `app_colors.dart`, `app_typography.dart`, `app_radius.dart`, `app_shadows.dart`, `app_spacing.dart`, `app_theme.dart` — **giữ nguyên tên file/class hiện có, chỉ mở rộng**, không đập đi làm lại kiến trúc theme.
- Thêm `lib/app/theme/glass_tokens.dart` (blur sigma, opacity fill/border, gradient viền, glow).
- Tạo `lib/core/widgets/glass/` chứa toàn bộ primitive kính.

### Quy tắc bắt buộc
- **Dark-first.** Glassmorphism sống nhờ nền tối có chiều sâu: nền app = gradient tối + vài "ambient orb" mờ (2–3 radial gradient màu accent, opacity thấp, blur cao) đặt sau lớp kính — đây là thứ làm kính "có gì để mà mờ". Light theme vẫn phải hoạt động (frosted white glass), không được vỡ.
- **Một class `GlassContainer` duy nhất**, mọi thẻ kính trong app đều đi qua nó. Cấm gọi `BackdropFilter` rải rác trong screen.
- **Cấm hardcode** màu / radius / blur / opacity trong file screen. Tất cả lấy từ token.
- **Cấm lồng `BackdropFilter` trong `BackdropFilter`** (giết hiệu năng). Mỗi thẻ kính bọc `RepaintBoundary`.
- Motion nhất quán: `Curves.easeOutCubic`, 200–350ms. Card nhấn → `scale 0.97`. Toggle/slider có `HapticFeedback`.

### Bộ widget dùng chung phải tạo (`lib/core/widgets/glass/`)
`GlassContainer` · `GlassCard` · `GlassAppBar` (nút back/action tròn kính) · `GlassBottomNav` · `GlassFilterChip` · `GlassToggle` · `GlassSlider` · `GlassSegmentedControl` · `GlassStatusPill` · `GlassIconTile` · `SlideToConfirm` (kéo để mở khoá) · `AmbientBackground` (nền gradient + orb).

Sau khi có bộ này: **refactor `lib/core/widgets/app_card.dart`, `app_button.dart`, `app_text_field.dart`, `state_views.dart`** để chúng dùng chung ngôn ngữ kính — đây là đòn bẩy khiến các màn còn lại đồng bộ gần như miễn phí.

---

## 3. ÁP DỤNG LÊN TOÀN BỘ SCREEN (bắt buộc, không bỏ sót)

Mọi file dưới đây phải được chuyển sang design system mới:

```
lib/app/router/shell_scaffold.dart            (bottom nav → GlassBottomNav)
lib/features/home/presentation/home_screen.dart              (1134 dòng)
lib/features/rooms/presentation/rooms_screen.dart            (304)
lib/features/rooms/presentation/room_device.dart             (612)
lib/features/devices/presentation/device_detail_screen.dart  (259)
lib/features/automation/presentation/automation_screen.dart  (964)  ← refactor sâu
lib/features/camera/presentation/camera_screen.dart          (820)  ← refactor sâu
lib/features/ai_assistant/presentation/ai_assistant_screen.dart     (421)
lib/features/energy/presentation/energy_screen.dart          (782)
lib/features/profile/presentation/profile_screen.dart        (400)
lib/features/notifications/presentation/notifications_screen.dart   (309)
lib/features/settings/presentation/settings_screen.dart      (37)
lib/features/onboarding/presentation/onboarding_screen.dart  (330)
lib/features/splash/presentation/splash_screen.dart          (175)
lib/features/authentication/presentation/login_screen.dart   (459)
lib/features/authentication/presentation/register_screen.dart(416)
```

**Thứ tự thi công:** design system → shell_scaffold → home → rooms → room_device → device_detail → automation → camera → phần còn lại.

---

## 4. YÊU CẦU RIÊNG TỪNG MÀN

### 4.1 HOME DASHBOARD — mô hình 3D ngôi nhà
Tham chiếu: `docs/design_refs/ref_1_dashboard.docx` (file .docx — **giải nén ảnh ra bằng cách unzip, ảnh nằm trong `word/media/`**, rồi xem trực tiếp).

- Thêm **Hero Card kính** ở đầu `home_screen.dart`: bên trái là icon trạng thái + tiêu đề lớn (VD "Nhà an toàn") + mô tả; bên phải là **mô hình 3D ngôi nhà isometric, tràn nhẹ ra mép thẻ**, có shadow mềm bên dưới.
- Model có sẵn: **`assets/models/modern_house.glb`**.
- Dùng package **`model_viewer_plus`** (thêm vào `pubspec.yaml`): `autoRotate: true`, `cameraControls: true`, `disableZoom: true`, `backgroundColor: Colors.transparent`, camera orbit isometric (~`45deg 60deg auto`). Bọc `RepaintBoundary`, có shimmer placeholder lúc load, lazy-init để không chặn first frame.
- Bên dưới hero: dải **3 pill kính** hiển thị số liệu thật lấy từ `deviceProviders`/`roomProviders` (VD Cửa 1/4 mở · Đèn 3/8 bật · Hệ thống đã kích hoạt), tap → điều hướng.
- Các section còn lại của home (scene, phòng, thiết bị) chuyển hết sang `GlassCard`.

### 4.2 ROOM DEVICE — `lib/features/rooms/presentation/room_device.dart`
Tham chiếu: `docs/design_refs/ref_2_room.png`. Asset: **`assets/images/room_devices/livingroom_devices/`** (ảnh nền phòng + ảnh từng thiết bị).

- **Ảnh nền phòng full-bleed** + gradient scrim tối dần (đảm bảo contrast chữ ≥ 4.5:1), parallax nhẹ khi scroll.
- `GlassAppBar` trong suốt (back tròn + `...` tròn).
- Header: tên phòng cỡ lớn + subtitle đếm động `X thiết bị • Y đang bật`.
- **Filter chips** cuộn ngang (Tất cả / Chiếu sáng / Thiết bị điện / Cảm biến / Khác) — map theo `DeviceType` trong `lib/features/devices/domain/device.dart` (`light, thermostat, lock, speaker, camera, fan, sensor`). Chip active dùng màu accent, animate mượt.
- **Grid card kính** (2 cột mobile / 4 cột tablet, dùng `LayoutBuilder`): ảnh sản phẩm PNG chiếm phần trên, tên + category, control ở đáy **thay đổi theo loại thiết bị**: toggle (đèn/quạt), toggle + nhiệt độ (thermostat), stepper `‹ 60% ›` (rèm), badge trạng thái (cảm biến).
- Card ON: viền sáng hơn + glow accent nhẹ + ảnh sáng lên. Card OFF: ảnh giảm bão hoà. Tap card → device detail (Hero animation trên ảnh sản phẩm). Tap toggle → **không** điều hướng.

### 4.3 DEVICE DETAIL — `lib/features/devices/presentation/device_detail_screen.dart`
> Lưu ý: file `room_detail.dart` không tồn tại trong repo — màn detail chính là file trên.

Tham chiếu: `docs/design_refs/ref_3_device_detail.docx` (unzip lấy ảnh trong `word/media/`). Asset: **`assets/images/devices/`**.

- **Ảnh sản phẩm làm background full-bleed**, phóng lớn, canh lệch, có glow màu toả ra theo trạng thái; phía trên phủ scrim + blur cục bộ ở vùng có nội dung.
- Layer control kính nổi bên trên: `GlassAppBar` → khối trạng thái → khối điều khiển chính → khối phụ (lịch trình / lịch sử).
- **Một `DeviceDetailScaffold` dùng chung**, control render theo `DeviceType` — cấm copy-paste screen cho từng loại:
  - `light` → `GlassSegmentedControl` (Ấm/Trung tính/Lạnh) + `GlassSlider` độ sáng % + nút nguồn tròn + danh sách **lịch trình theo thứ** (giờ bật/tắt + toggle từng dòng).
  - `lock` → hàng status pill (góc quay, Đã khoá, Pin %) + lịch sử mở khoá gần nhất + 3 thẻ hành động nhanh (Mã tạm thời / Quản lý thành viên / Ngữ cảnh) + **`SlideToConfirm` kéo để mở khoá** (bắt buộc kéo, không tap).
  - `thermostat` / `fan` / `speaker` / `sensor` / `camera` → khối control tương ứng, cùng ngôn ngữ thị giác.

### 4.4 AUTOMATION — `automation_screen.dart` + LỐI VÀO
**Vấn đề hiện tại:** route `/automation` được khai báo trong `app_router.dart` như sub-route của branch AI Assistant, và chỉ được `push` từ `ai_assistant_screen.dart` **dòng 163** — quá chìm, người dùng gần như không tìm thấy.

Bạn phải:
1. **Refactor sâu** `automation_screen.dart` (964 dòng) theo `stitch_syna_home_systems/automation/screen.png` + `code.html`, dựng lại bằng design system kính: danh sách rule/scene dạng thẻ kính có toggle, badge trigger (thời gian / cảm biến / vị trí), nút tạo rule nổi, empty state đẹp.
2. **Thêm lối vào rõ ràng**: (a) một **quick-action tile hiển thị ngay trên Home Dashboard**, và (b) một entry nổi bật trong AI Assistant (không phải nút chìm như hiện tại). Nếu bạn thấy hợp lý hơn thì đề xuất đưa Automation lên thành **tab riêng trên bottom nav** — nhưng phải hỏi/ghi rõ trade-off trong phần tổng kết trước khi đổi cấu trúc branch của `StatefulShellRoute`.

### 4.5 CAMERA — `camera_screen.dart` + LỐI VÀO
**Vấn đề nghiêm trọng hơn:** route `/camera` tồn tại (sub-route của branch Energy) nhưng **KHÔNG có bất kỳ chỗ nào trong app `push` tới nó** — màn này hoàn toàn không truy cập được.

Bạn phải:
1. **Refactor sâu** `camera_screen.dart` (820 dòng) theo `stitch_syna_home_systems/camera_feed/screen.png` + `code.html`: khung feed live bo góc lớn với overlay kính (LIVE badge, timestamp, tên camera), hàng thumbnail chuyển camera, cụm nút điều khiển kính (chụp, ghi, mic, đèn), timeline sự kiện dạng thẻ kính. **Dùng đúng design system chung** — làm một lần, không quay lại sửa lại.
2. **Thêm lối vào**: quick-action tile trên Home + card camera trong Rooms/Security. Đảm bảo `context.push('/camera')` hoạt động.

---

## 5. RÀNG BUỘC KỸ THUẬT

- **Không phá** logic Riverpod provider, repository, model, router path/name hiện có. Nếu buộc phải đổi, ghi rõ lý do trong tổng kết.
- **`pubspec.yaml`**: thêm `model_viewer_plus`; khai báo assets mới:
  ```yaml
  assets:
    - config/
    - stitch_syna_home_systems/
    - assets/models/
    - assets/images/devices/
    - assets/images/room_devices/livingroom_devices/
  ```
  (Kiểm tra file thật có tồn tại trước khi khai báo; thiếu gì ghi vào `assets/ASSETS_NEEDED.md`.)
- **Không thêm dependency ngoài** ngoài `model_viewer_plus`, trừ khi có lý do rõ ràng và xin phép trong tổng kết.
- **Text UI đi qua l10n** (`lib/l10n/app_localizations*.dart`) — key mới phải bổ sung cả `vi` và `en`, không hardcode chuỗi trong screen.
- Responsive mobile + tablet bằng `LayoutBuilder`, không số cứng.
- `flutter analyze` **0 error, 0 warning**; `dart format .`; test hiện có trong `test/` phải còn xanh.
- Hiệu năng: scroll 60fps, không jank khi mở device detail; `precacheImage` cho ảnh nền phòng/thiết bị.

---

## 6. NGHIỆM THU (tự kiểm trước khi báo hoàn thành)

- [ ] Tất cả 16 screen dùng chung `GlassContainer` + token duy nhất, không màn nào còn Material mặc định.
- [ ] Home có mô hình 3D `modern_house.glb` xoay được trong hero card kính.
- [ ] Room device: ảnh nền phòng + filter chips + grid card ảnh sản phẩm + control theo loại thiết bị.
- [ ] Device detail: ảnh sản phẩm full-bleed làm background + control kính nổi + slide-to-unlock cho khoá.
- [ ] Automation **và** Camera đều có lối vào rõ ràng, bấm được từ Home; cả hai đã refactor theo Stitch + design system.
- [ ] Không hardcode màu/blur ngoài theme; không lồng BackdropFilter.
- [ ] `flutter analyze` sạch, app build & chạy được, test xanh.

**Tổng kết cuối cùng:** liệt kê file tạo mới / file sửa, dependency thêm, asset còn thiếu, các quyết định thiết kế bạn tự chọn (bảng màu + lý do), và những chỗ bạn đã làm đẹp hơn so với ảnh tham chiếu.
