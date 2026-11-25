/* =====================================================================
   BayiAI SQL Çalışmaları · 5. GÜN (28 Kasım, Cumartesi)
   Konu: Pencere fonksiyonları (cari ekstre), VIEW, transaction + TRY/CATCH,
         stored procedure
   PDF: SQL 5.5, SQL 6.5, SQL 7 · Cevaplar: Ek C, Gün 5 (7), Gün 6 (5–6), Gün 7
   NOT: CREATE VIEW / PROCEDURE batch'in ilk komutu olmalı: önüne GO koy.
        Projenin tablolarını ALTER etme (EF Core migration yönetiyor).
        View ve prosedür eklemek sorun değil.
   ===================================================================== */
USE BayiAI;
GO

/* ---------- A) PENCERE FONKSİYONLARI ---------- */
-- A1) B-0001 için cari ekstre: Tarih, Aciklama, Borc, Alacak ve yürüyen Bakiye
--     (SUM(Borc - Alacak) OVER (ORDER BY Tarih, Id ROWS UNBOUNDED PRECEDING)).


-- A2) Her bayinin en büyük siparişi (ROW_NUMBER + PARTITION BY BayiId).


/* ---------- B) VIEW ---------- */
-- B1) vw_KritikStok: kritik stok altındaki aktif ürünler, kategori adı, eksik miktar.
GO


GO
-- B2) vw_BayiBakiye: her bayinin kodu, unvanı, bölgesi, risk limiti ve bakiyesi
--     (CariHareket'ten SUM(Borc - Alacak), hareketi olmayan 0).
GO


GO
-- B3) vw_BayiBakiye'den risk limitinin %10'undan fazlasını kullanan bayiler.


/* ---------- C) TRANSACTION + TRY/CATCH ---------- */
-- C1) TRY/CATCH içinde: önce geçerli bir tahsilat ekle (Aciklama = N'TEST'), sonra
--     CariHareket'e Borc = 0, Alacak = 0 ile kayıt eklemeye çalış (CHECK hatası).
--     CATCH'te ROLLBACK yap ve ERROR_MESSAGE()'ı yazdır.
--     Sonra SELECT ile TEST tahsilatının OLMADIĞINI kanıtla.


/* ---------- D) STORED PROCEDURE ---------- */
-- D1) dbo.sp_BayiCiroRaporu @Baslangic DATE, @Bitis DATE:
--     aralıktaki iptal hariç siparişlerden bayi bazında sipariş sayısı ve ciro
--     (bayi unvanı ve bölgesiyle, siparişi olmayan bayi 0).
GO


GO
-- D2) Ekim ve Kasım 2026 için çalıştır.


-- D3) dbo.sp_KullaniciKilitAc @KullaniciAdi NVARCHAR(50):
--     kullanıcının HataliGirisSayisi = 0, KilitBitisTarihi = NULL yapsın.
--     Kullanıcı yoksa THROW 50001 ile 'Kullanıcı bulunamadı' hatası versin.
GO


GO
-- D4) dbo.sp_SonrakiNumara @Kod NVARCHAR(10), @Numara NVARCHAR(30) OUTPUT:
--     NumaraSerisi'nde ilgili satırın SonNumara'sını 1 artırsın ve
--     Onek + Yil + sıfır dolgulu numarayı OUTPUT parametresiyle döndürsün
--     (C#'taki NumaraSerisi.SonrakiNumara() metodunun SQL karşılığı).
--     Denerken BEGIN TRAN ... ROLLBACK içinde çağır, gerçek sayaç ilerlemesin.
GO


GO
-- BONUS) Bu hafta öğrendiklerinle vw_RiskliBayiler view'ını yaz (PDF, SQL 7 ödev 8).

