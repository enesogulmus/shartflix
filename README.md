# Shartflix - Movie App

Nodelabs Flutter Developer Case Study projesi. Netflix benzeri bir film streaming uygulaması.

## 🎯 Proje Özellikleri

### ✅ Tamamlanan Özellikler

#### 🔐 Kimlik Doğrulama
- [x] Kullanıcı girişi (Login)
- [x] Kullanıcı kaydı (Register)
- [x] Güvenli token yönetimi
- [x] Otomatik ana sayfa yönlendirmesi

#### 🏠 Ana Sayfa
- [x] Sonsuz kaydırma (Infinite scroll)
- [x] Her sayfada 5 film gösterimi
- [x] Otomatik yükleme göstergesi
- [x] Pull-to-refresh özelliği
- [x] Favori film işlemlerinde anlık UI güncellemesi

#### 👤 Profil
- [x] Kullanıcı bilgilerinin görüntülenmesi
- [x] Favori filmler listesi
- [x] Profil fotoğrafı yükleme altyapısı

#### 🧭 Navigasyon
- [x] Bottom Navigation Bar ile sayfa geçişleri
- [x] Ana sayfa state yönetimi ve korunması

#### 🏗️ Kod Yapısı
- [x] Clean Architecture
- [x] MVVM Pattern
- [x] Bloc State Management
- [x] Dio HTTP Client

#### 🎨 Bonus Özellikler
- [x] Custom Theme
- [x] Navigation Service
- [x] Localization Service (Türkçe, İngilizce)
- [x] Logger Service
- [x] Firebase Crashlytics, Analytics entegrasyonu
- [x] Splash screen ve uygulama ikonu

## 🛠️ Teknolojiler

- **Framework**: Flutter 3.8.0+
- **State Management**: Bloc (flutter_bloc)
- **HTTP Client**: Dio
- **Navigation**: GoRouter
- **Local Storage**: SharedPreferences
- **Image Loading**: CachedNetworkImage
- **Code Generation**: json_serializable, build_runner

## 📱 Ekranlar

1. **Splash Screen** - Uygulama başlangıç ekranı
2. **Login Screen** - Giriş ekranı
3. **Register Screen** - Kayıt ekranı
4. **Home Screen** - Ana sayfa (Film listesi)
5. **Profile Screen** - Profil sayfası
6. **Profile Photo Screen** - Profil Fotoğrafı Ekle ekranı

## 🔥 Firebase Analytics & Crashlytics

### Takip Edilen Olaylar

#### 📊 Analytics Olayları
- **movie_favorited**: Film favorileme/favoriden çıkarma
  - Parametreler: `movie_id`, `movie_title`, `is_favorited`, `timestamp`
- **user_login**: Kullanıcı girişi
  - Parametreler: `user_id`, `login_method`, `timestamp`
- **movie_viewed**: Film görüntüleme
  - Parametreler: `movie_id`, `movie_title`, `timestamp`

![img.png](img.png)

#### 🐛 Crashlytics
- Flutter hataları otomatik olarak yakalanır
- Platform channel hataları kaydedilir
- Özel hata kaydetme fonksiyonu mevcuttur

![img_1.png](img_1.png)

## 👨‍💻 Geliştirici

**Enes** - Flutter Developer

---

⭐ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın!
