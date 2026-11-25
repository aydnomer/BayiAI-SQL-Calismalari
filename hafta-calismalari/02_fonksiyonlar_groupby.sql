/* =====================================================================
   BayiAI SQL Çalışmaları · 2. GÜN (25 Kasım, Çarşamba)
   Konu: Metin/tarih/sayı fonksiyonları, CASE, COUNT/SUM/AVG, GROUP BY, HAVING
   PDF: SQL 2 · Cevaplar: Ek C, Gün 2
   Kural: SELECT'te aggregate (SUM, COUNT...) olmayan her kolon GROUP BY'da olmalı.
          WHERE satırları, HAVING grupları süzer.
   ===================================================================== */
USE BayiAI;
GO

-- 1) Kaç ürün var, toplam stok kaç koli, toplam stok değeri (StokMiktari * ListeFiyati)? Tek sorgu.


-- 2) Ürünlerin ortalama (2 haneye yuvarlanmış), en düşük ve en yüksek liste fiyatı.


-- 3) Durum bazında sipariş sayısı ve toplam tutar; durumu CASE ile adıyla göster
--    (1 Beklemede, 2 Onaylandı, 3 Sevk Edildi, 4 Teslim Edildi, 5 İptal).


-- 4) Her bayinin (BayiId) iptal hariç toplam sipariş tutarı, büyükten küçüğe.


-- 5) İptal hariç cirosu 20.000 TL'yi geçen bayiler (HAVING).


-- 6) Ay ay sipariş sayısı ve ciro (yıl ve ay ayrı kolon).


-- 7) Ürünleri "Tükendi / Kritik / Yeterli" diye sınıflandır (CASE).


-- 8) Bayilerin unvanını BÜYÜK harfle, bayi numarasını (B-0004 → 4, sayı) ve telefon alan kodunu göster.


-- 9) Her fatura için vadeye kalan gün; vadesi geçenlere "Gecikmiş", diğerlerine "Normal".


-- 10) Kullanicilar: Rol'e göre kaç kullanıcı var? Rol numarası yerine adını yaz
--     (1 Admin, 2 Satış, 3 Depo, 4 Muhasebe).


-- 11) Kullanicilar: KullaniciAdi'nın uzunluğu ve AdSoyad'ın ilk kelimesi (ipucu: LEFT + CHARINDEX).


-- 12) NumaraSerisi: bir sonraki belge numarasının nasıl görüneceğini SQL ile üret.
--     Örn. Onek 'FTR', Yil 2026, SonNumara 0, Uzunluk 6 → 'FTR2026000001'
--     İpucu: CONCAT(Onek, Yil, RIGHT(REPLICATE('0', Uzunluk) + CAST(SonNumara + 1 AS VARCHAR(10)), Uzunluk))


-- BONUS) KategoriId'ye göre: ürün sayısı ve stok değeri; sadece stok değeri 50.000'den büyük olanlar.

