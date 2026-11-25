/* =====================================================================
   BayiAI SQL Çalışmaları · 1. GÜN (24 Kasım, Salı)
   Konu: SELECT, WHERE, ORDER BY, TOP, DISTINCT, LIKE, NULL
   PDF: SQL 0 + SQL 1 · Cevaplar: Ek C, Gün 1
   Nasıl: Her sorunun altındaki boşluğa sorguyu kendin yaz, F5 ile dene.
          Bitince dosyayı kaydet ve GitHub'a yükle.
   HATIRLATMA: Tablo/kolon adlarında Türkçe karakter YOK (Urun, StokMiktari).
               Türkçe metinlerin başına N koy: N'İç Anadolu'
   ===================================================================== */
USE BayiAI;
GO

-- 0) HAZIRLIK (bir kez): 03_pratik_veri.sql dosyasını çalıştırdın mı?
--    Kontrol: aşağıdaki sorgu 8 dönmeli. 0 dönerse önce o dosyayı çalıştır.
SELECT COUNT(*) AS SiparisSayisi FROM Siparis;


-- 1) Tüm bölgeleri listele.


-- 2) Ürünlerin kodunu, adını ve liste fiyatını en pahalıdan en ucuza sırala.


-- 3) Her ürünün adını, liste fiyatını ve KDV dahil fiyatını KdvDahilFiyat adıyla göster.


-- 4) Stok miktarı kritik stoğun altında olan ürünleri bul.


-- 5) İskonto oranı 10 ile 15 arasında (ikisi dahil) olan bayileri listele.


-- 6) Unvanında "Gıda" geçen bayileri bul.


-- 7) E-posta adresi girilmemiş bayilerin kodunu ve unvanını listele. (= NULL değil!)


-- 8) Durumu 1 (Beklemede) veya 2 (Onaylandı) olan siparişleri en yeniden eskiye sırala. IN kullan.


-- 9) Ekim 2026'da verilen siparişler. (BETWEEN tuzağına düşme: >= ve < kullan)


-- 10) En pahalı 3 ürün.


-- 11) Kullanicilar: aktif kullanıcıların ad soyadını ve kullanıcı adını, ada göre A→Z sırala.


-- 12) Kullanicilar: Rol'ü 2 (Satış) veya 4 (Muhasebe) olanlar.


-- 13) Kullanicilar: hiç giriş yapmamış olanlar (SonGirisTarihi boş olanlar).


-- 14) NumaraSerisi tablosunun tamamını listele. Kaç belge türü var, önekleri ne?


-- 15) NumaraSerisi: Kod'u 'SIP' veya 'FTR' olan satırların Onek ve SonNumara kolonları.


-- BONUS) Siparişleri tarih sırasıyla 3'erli sayfalara böl, 3. sayfayı getir (OFFSET/FETCH).

