/* =====================================================================
   BayiAI SQL Çalışmaları · 4. GÜN (27 Kasım, Cuma)
   Konu: INSERT, UPDATE, DELETE, OUTPUT + alt sorgu, EXISTS, CTE
   PDF: SQL 4 + SQL 5 (5.1–5.3) · Cevaplar: Ek C, Gün 4 ve Gün 5 (1–4)
   GÜVENLİK: A bölümünü BEGIN TRAN ... ROLLBACK arasında yap. Veritabanın bozulmaz.
             Transaction'ı açık bırakma (uygulama donar).
   ===================================================================== */
USE BayiAI;
GO

/* ---------- A) VERİ DEĞİŞTİRME (hepsi bu transaction içinde) ---------- */
BEGIN TRAN;

-- A1) "Doğu Anadolu" bölgesini ekle.


-- A2) Meyve Suyu kategorisine MS-002 "Şeftali Suyu 1 L (12'li koli)" ekle
--     (Koli, 400 TL, stok 120, kritik 25). KategoriId'yi alt sorguyla bul.


-- A3) "Gazlı İçecek" ürünlerine %10 zam; OUTPUT ile eski ve yeni fiyatı göster.


-- A4) B-0005'in risk limitini 75.000, iskontosunu 7 yap.


-- A5) SP-0007'yi soft delete yap (SilindiMi = 1), sonra silinmemiş siparişleri listele.


-- A6) Kullanicilar: 'mehmet' kullanıcısını pasif yap (AktifMi = 0), OUTPUT ile göster.


-- A7) NumaraSerisi: 'SIP' serisinin SonNumara'sını 1 artır ve yeni numarayı OUTPUT ile göster.


-- KONTROL: Değişikliklere bir göz at, sonra geri al.
ROLLBACK;
-- (Kalıcı olsun isteseydin ROLLBACK yerine COMMIT yazardın.)


/* ---------- B) HATA DENEMELERİ (hata alman normal, mesajı oku) ---------- */
-- B1) Bir ürünün stoğunu -10 yapmayı dene. Hangi kısıt engelledi? Cevabı yorum olarak yaz.


-- B2) B-0001 koduyla yeni bayi eklemeyi dene. Hata mesajındaki kısıt adı ne?


-- B3) Var olan bir KullaniciAdi ('ayse') ile yeni kullanıcı eklemeyi dene. Ne oldu?


/* ---------- C) ALT SORGU, EXISTS, CTE ---------- */
-- C1) Liste fiyatı, ortalama fiyattan yüksek ürünler.


-- C2) Hiç sipariş vermemiş bayiler, NOT EXISTS ile.


-- C3) Her bayinin son sipariş tarihi (correlated alt sorgu); siparişi yoksa 'Sipariş yok'.


-- C4) CTE: bayi bazında iptal hariç ciro; ortalama cironun üstündekiler.


-- C5) CTE: Fatura ve Tahsilat'ı AYRI grupla, sonra Bayi'ye bağla → her bayinin bakiyesi.
--     (3. gündeki bonus sorunun doğru çözümü)

