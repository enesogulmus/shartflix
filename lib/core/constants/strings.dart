class Strings {
  static const Map<String, Map<String, String>> auth = {
    'tr': {
      'login': 'Giriş Yap',
      'register': 'Şimdi Kaydol',
      'logout': 'Çıkış Yap',
      'name': 'Ad Soyad',
      'email': 'E-posta',
      'password': 'Şifre',
      'forgotPassword': 'Şifremi unuttum',
      'confirmPassword': 'Şifre Tekrar',
      'emailHint': 'E-posta adresiniz',
      'passwordHint': 'Şifreniz',
      'confirmPasswordHint': 'Şifrenizi tekrar girin',
      'noAccount': 'Bir hesabın yok mu?',
      'hasAccount': 'Zaten hesabın var mı?',
      'loginSuccess': 'Başarıyla giriş yapıldı',
      'registerSuccess': 'Hesabınız başarıyla oluşturuldu',
      'logoutSuccess': 'Başarıyla çıkış yapıldı',
      'welcomeMessageTitle': 'Merhabalar',
      'welcomeMessage': 'Tempus varius a vitae interdum id tortor elementum tristique eleifend at.',
      'agreement2': 'Kullanıcı sözleşmesini ',
      'agreement3': 'okudum ve kabul ediyorum.',
      'agreement': 'Bu sözelşmeyi okuyarak devam ediniz lütfen.',
      'registerMessageTitle': 'Hoşgeldiniz',
      'requiredName': 'Ad Soyad gerekli',
      'nameAtLeast': 'Ad Soyad en az 2 karakter olmalı',
    },
    'en': {
      'login': 'Login',
      'register': 'Register',
      'logout': 'Logout',
      'name': 'Full Name',
      'email': 'Email',
      'password': 'Password',
      'forgorPassword': 'Forgot Password',
      'confirmPassword': 'Confirm Password',
      'emailHint': 'Your email address',
      'passwordHint': 'Your password',
      'confirmPasswordHint': 'Confirm your password',
      'noAccount': 'Don\'t have an account?',
      'hasAccount': 'Already have an account?',
      'loginSuccess': 'Successfully logged in',
      'registerSuccess': 'Account created successfully',
      'logoutSuccess': 'Successfully logged out',
      'welcomeMessageTitle': 'Greetings',
      'welcomeMessage': 'Tempus varius a vitae interdum id tortor elementum tristique eleifend at.',
      'agreement2': ' the User Agreement.',
      'agreemnet3': 'I have read and accept',
      'agreement': ' Please read the agreement to continue.',
      'registerMessageTitle': 'Welcome',
      'requiredName': 'Full name is required.',
      'nameAtLeast': 'Full name must be at least 2 characters long.',
    },
  };

  static const Map<String, Map<String, String>> errors = {
    'tr': {
      'networkError': 'İnternet bağlantınızı kontrol edin',
      'serverError': 'Sunucu hatası oluştu',
      'unknownError': 'Bilinmeyen bir hata oluştu',
      'emailRequired': 'E-posta adresi gerekli',
      'passwordRequired': 'Şifre gerekli',
      'confirmPasswordRequired': 'Şifre tekrarı gerekli',
      'notEqualPasswordFields': 'Şifreler eşleşmiyor',
      'invalidEmail': 'Geçerli bir e-posta adresi girin',
      'passwordTooShort': 'Şifre en az 6 karakter olmalı',
      'passwordsNotMatch': 'Şifreler eşleşmiyor',
      'invalidAuth': 'Oturum süreniz dolmuş. Lütfen tekrar giriş yapın.',
      'deniedPermission': 'Bu işlem için yetkiniz bulunmuyor.',
      'notFound': 'İstenen kaynak bulunamadı.',
      'cancelled': 'İstek iptal edildi.',
      'genericError': 'Bir hata oluştu',
      'userExist': 'Kullanıcı mevcut, parolanız ile giriş yapabilirsiniz.',
      'fileSize': 'Dosya boyutu çok büyük. Lütfen 1MB\'dan küçük bir fotoğraf seçin.',
    },
    'en': {
      'networkError': 'Check your internet connection',
      'serverError': 'Server error occurred',
      'unknownError': 'An unknown error occurred',
      'emailRequired': 'Email is required',
      'passwordRequired': 'Password is required',
      'confirmPasswordRequired': 'Password confirmation is required.',
      'notEqualPasswordFields': 'Passwords do not match.',
      'invalidEmail': 'Please enter a valid email',
      'passwordTooShort': 'Password must be at least 6 characters',
      'passwordsNotMatch': 'Passwords do not match',
      'invalidAuth': 'Your session has expired. Please log in again.',
      'deniedPermission': 'You do not have permission to perform this action.',
      'notFound': 'The requested resource was not found.',
      'cancelled': 'The request was cancelled.',
      'genericError': 'An error occurred.',
      'userExist': 'User exist, login with password',
      'fileSize': 'The file size is too large. Please select a photo smaller than 1MB.',
    },
  };

  static const Map<String, Map<String, String>> navigation = {
    'tr': {'home': 'Anasayfa', 'profile': 'Profil'},
    'en': {'home': 'Home', 'profile': 'Profile'},
  };

  static const Map<String, Map<String, String>> language = {
    'tr': {'tr': 'Türkçe', 'en': 'İngilizce'},
    'en': {'tr': 'Turkish', 'en': 'English'},
  };

  static const Map<String, Map<String, String>> common = {
    'tr': {
      'loading': 'Yükleniyor...',
      'retry': 'Tekrar Dene',
      'cancel': 'İptal',
      'language': 'Dil',
      'more': ' Daha Fazlası',
      'continue': 'Devam Et',
    },
    'en': {
      'loading': 'Loading...',
      'retry': 'Retry',
      'cancel': 'Cancel',
      'language': 'Language',
      'more': ' More',
      'continue': 'Continue',
    },
  };

  static const Map<String, Map<String, String>> profile = {
    'tr': {
      'profileDetail': 'Profil Detayı',
      'addPhoto': 'Fotoğraf Ekle',
      'logout': 'Çıkış Yap',
      'logoutConfirm': 'Hesabınızdan çıkış yapmak istediğinizden emin misiniz?',
      'logoutError': 'Çıkış yapılırken bir hata oluştu',
      'limitedOffer': 'Sınırlı Teklif',
      'noFavorites': 'Henüz favori filminiz yok',
      'favoritesDescription': 'Filmleri favorilere ekleyerek burada görebilirsiniz',
      'favoriteMovies': 'Beğendiğim Filmler',
      'unknown': 'Bilinmiyor',
      'error': 'Bir hata oluştu',
      'importGallery': 'Galeriden Seç',
      'importCamera': 'Kamera ile Çek',
      'successUploadPhoto': 'Profil fotoğrafınız başarıyla güncellendi',
    },
    'en': {
      'profileDetail': 'Profile Detail',
      'addPhoto': 'Add Photo',
      'logout': 'Logout',
      'logoutConfirm': 'Are you sure you want to logout from your account?',
      'logoutError': 'An error occurred while logging out',
      'limitedOffer': 'Limited Offer',
      'noFavorites': 'You don\'t have any favorite movies yet',
      'favoritesDescription': 'You can see them here by adding movies to favorites',
      'favoriteMovies': 'My Favorite Movies',
      'unknown': 'Unknown',
      'error': 'An error occurred',
      'importGallery': 'Choose from Gallery',
      'importCamera': 'Capture with Camera',
      'successUploadPhoto': 'Your profile photo has been updated successfully.',
    },
  };

  static const Map<String, Map<String, String>> photo = {
    'tr': {'uploadPhotos': 'Fotoğraflarınızı Yükleyin', 'selectPhoto': 'Fotoğraf Seçin'},
    'en': {'uploadPhotos': 'Upload Your Photos', 'selectPhoto': 'Select Photo'},
  };

  static const Map<String, Map<String, String>> offer = {
    'tr': {
      'bonuses': 'Alacağınız Bonuslar',
      'unlockJetons': 'Kilidi açmak için bir jeton paketi seçin',
      'jeton': 'Jeton',
      'weeklyPer': 'Başına haftalık',
      'plus10': '+10%',
      'plus70': '+70%',
      'plus35': '+35%',
      'limitedOfferTitle': 'Sınırlı Teklif',
      'limitedOfferDesc': 'Jeton paketin’ni seçerek bonus kazanın ve yeni bölümlerin kilidini açın!',
      'premiumAccount': 'Premium Hesap',
      'moreMatch': 'Daha Fazla Eşleşme',
      'highlihts': 'Öne Çıkarma',
      'moreLike': 'Daha Fazla Beğeni',
      'showAll': 'Tüm Jetonları Gör',
    },
    'en': {
      'bonuses': 'Bonuses You Will Receive',
      'unlockJetons': 'Select a jeton package to unlock',
      'jeton': 'Jeton',
      'weeklyPer': 'Weekly per',
      'plus10': '+10%',
      'plus70': '+70%',
      'plus35': '+35%',
      'limitedOfferTitle': 'Limited Offer',
      'limitedOfferDesc': 'Choose your coin pack to earn bonuses and unlock new episodes!',
      'premiumAccount': 'Premium Account',
      'moreMatch': 'More Matches',
      'highlihts': 'Highlights',
      'moreLike': 'More Likes',
      'showAll': 'View All Coins',
    },
  };

  static String get(String category, String key, String language) {
    final categoryMap = _getCategoryMap(category);
    return categoryMap[language]?[key] ?? categoryMap['tr']?[key] ?? key;
  }

  static Map<String, Map<String, String>> _getCategoryMap(String category) {
    switch (category) {
      case 'auth':
        return auth;
      case 'errors':
        return errors;
      case 'navigation':
        return navigation;
      case 'language':
        return language;
      case 'common':
        return common;
      case 'profile':
        return profile;
      case 'photo':
        return photo;
      case 'offer':
        return offer;
      default:
        return common;
    }
  }
}
