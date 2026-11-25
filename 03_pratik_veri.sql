/* =====================================================================
   BayiAI - 03_pratik_veri.sql : SQL çalışması için sipariş / fatura /
   tahsilat verisi. 01_tablolar.sql (veya EF migration) ve
   02_ornek_veri.sql çalıştırıldıktan SONRA bir kez çalıştırın.
   Tek batch'tir: tamamını seçip F5'e basın.
   ===================================================================== */
USE BayiAI;
GO

IF NOT EXISTS (SELECT 1 FROM Bayi WHERE BayiKodu = N'B-0001')
BEGIN
    PRINT N'Önce 02_ornek_veri.sql çalıştırılmalı.';
    RETURN;
END;

IF EXISTS (SELECT 1 FROM Siparis WHERE SiparisNo = N'SP-0001')
BEGIN
    PRINT N'Pratik veri zaten yüklü.';
    RETURN;
END;

DECLARE @ayse   INT = (SELECT Id FROM Kullanici WHERE KullaniciAdi = N'ayse');
DECLARE @zeynep INT = (SELECT Id FROM Kullanici WHERE KullaniciAdi = N'zeynep');

-- İki bayiye e-posta verelim (IS NULL örnekleri için diğerleri boş kalsın)
UPDATE Bayi SET Eposta = N'info@yildizgida.example' WHERE BayiKodu = N'B-0001';
UPDATE Bayi SET Eposta = N'siparis@egetoptan.example' WHERE BayiKodu = N'B-0002';

-- 1) Siparişler (Durum: 1 Beklemede, 2 Onaylandi, 3 SevkEdildi, 4 TeslimEdildi, 5 Iptal)
INSERT INTO Siparis (SiparisNo, BayiId, KullaniciId, SiparisTarihi, Durum, Aciklama)
SELECT v.SiparisNo, b.Id, @ayse, v.Tarih, v.Durum, v.Aciklama
FROM (VALUES
    (N'SP-0001', N'B-0001', CAST('2026-10-05 10:30' AS DATETIME2), 4, NULL),
    (N'SP-0002', N'B-0002', CAST('2026-10-12 14:15' AS DATETIME2), 4, N'Hafta sonu teslim'),
    (N'SP-0003', N'B-0001', CAST('2026-10-20 09:00' AS DATETIME2), 4, NULL),
    (N'SP-0004', N'B-0004', CAST('2026-10-28 16:45' AS DATETIME2), 3, N'Acil'),
    (N'SP-0005', N'B-0003', CAST('2026-11-03 11:20' AS DATETIME2), 2, NULL),
    (N'SP-0006', N'B-0002', CAST('2026-11-10 13:00' AS DATETIME2), 1, NULL),
    (N'SP-0007', N'B-0004', CAST('2026-11-15 10:10' AS DATETIME2), 5, N'Bayi iptal etti'),
    (N'SP-0008', N'B-0001', CAST('2026-11-18 15:30' AS DATETIME2), 1, NULL)
) AS v(SiparisNo, BayiKodu, Tarih, Durum, Aciklama)
JOIN Bayi b ON b.BayiKodu = v.BayiKodu;

-- 2) Sipariş kalemleri (fiyat ve iskonto o anki değerlerden kopyalanır)
--    Hesap, C# tarafındaki SiparisKalemi sınıfıyla aynı:
--    IskontoluTutar = ROUND(Miktar * BirimFiyat * (1 - Iskonto/100), 2)
--    KdvTutari      = ROUND(IskontoluTutar * KdvOrani / 100, 2)
--    SatirToplam    = IskontoluTutar + KdvTutari   (KDV DAHİL)
INSERT INTO SiparisKalemi (SiparisId, UrunId, Miktar, BirimFiyat, IskontoOrani, KdvOrani, SatirToplam)
SELECT x.SiparisId, x.UrunId, x.Miktar, x.BirimFiyat, x.IskontoOrani, x.KdvOrani,
       x.Net + ROUND(x.Net * x.KdvOrani / 100, 2)
FROM (
  SELECT s.Id AS SiparisId, u.Id AS UrunId, v.Miktar, u.ListeFiyati AS BirimFiyat,
         b.IskontoOrani, u.KdvOrani,
         ROUND(v.Miktar * u.ListeFiyati * (1 - b.IskontoOrani / 100), 2) AS Net
  FROM (VALUES
    (N'SP-0001', N'GZ-001', 20), (N'SP-0001', N'CP-001', 10),
    (N'SP-0002', N'GZ-001', 30), (N'SP-0002', N'MS-001', 15), (N'SP-0002', N'BS-001', 10),
    (N'SP-0003', N'CP-001',  8), (N'SP-0003', N'MS-001',  5),
    (N'SP-0004', N'GZ-001', 40), (N'SP-0004', N'CP-001', 20), (N'SP-0004', N'BS-001', 15),
    (N'SP-0005', N'MS-001', 12),
    (N'SP-0006', N'GZ-001', 25), (N'SP-0006', N'BS-001',  6),
    (N'SP-0007', N'CP-001', 10),
    (N'SP-0008', N'GZ-001', 10), (N'SP-0008', N'MS-001', 10)
  ) AS v(SiparisNo, UrunKodu, Miktar)
  JOIN Siparis s ON s.SiparisNo = v.SiparisNo
  JOIN Bayi    b ON b.Id = s.BayiId
  JOIN Urun    u ON u.UrunKodu = v.UrunKodu
) AS x;

-- 3) Sipariş toplamlarını kalemlerden hesapla (Siparis.HesaplaToplam() ile aynı mantık)
--    AraToplam = iskonto düşülmüş, KDV hariç tutar; GenelToplam = AraToplam + KDV
UPDATE s
SET AraToplam     = k.Net,
    IskontoTutari = k.Brut - k.Net,
    KdvTutari     = k.Kdv,
    GenelToplam   = k.Net + k.Kdv
FROM Siparis s
JOIN (SELECT SiparisId,
             SUM(Miktar * BirimFiyat) AS Brut,
             SUM(ROUND(Miktar * BirimFiyat * (1 - IskontoOrani / 100), 2)) AS Net,
             SUM(ROUND(ROUND(Miktar * BirimFiyat * (1 - IskontoOrani / 100), 2) * KdvOrani / 100, 2)) AS Kdv
      FROM SiparisKalemi
      GROUP BY SiparisId) k ON k.SiparisId = s.Id
WHERE s.SiparisNo LIKE N'SP-%';

-- 4) Sevk edilen / teslim edilen siparişler için sevkiyat
INSERT INTO Sevkiyat (SiparisId, SevkTarihi, AracPlaka, KargoFirmasi, TakipNo, TeslimTarihi)
SELECT s.Id, DATEADD(DAY, 2, s.SiparisTarihi), N'34 ABC ' + RIGHT(s.SiparisNo, 3),
       N'Hızlı Lojistik', N'TK' + RIGHT(s.SiparisNo, 4),
       CASE WHEN s.Durum = 4 THEN DATEADD(DAY, 4, s.SiparisTarihi) END
FROM Siparis s
WHERE s.Durum IN (3, 4) AND s.SiparisNo LIKE N'SP-%';

-- 5) Faturalar (vade = sipariş + 31 gün)
INSERT INTO Fatura (FaturaNo, SiparisId, BayiId, FaturaTarihi, VadeTarihi, AraToplam, KdvTutari, GenelToplam)
SELECT N'FT-' + RIGHT(s.SiparisNo, 4), s.Id, s.BayiId,
       DATEADD(DAY, 1, s.SiparisTarihi),
       CAST(DATEADD(DAY, 31, s.SiparisTarihi) AS DATE),
       s.AraToplam, s.KdvTutari, s.GenelToplam
FROM Siparis s
WHERE s.Durum IN (3, 4) AND s.SiparisNo LIKE N'SP-%';

-- 6) Tahsilatlar (OdemeTipi: 1 Nakit, 2 Havale, 3 Cek, 4 KrediKarti)
INSERT INTO Tahsilat (BayiId, KasaBankaId, Tarih, Tutar, OdemeTipi, Aciklama, KullaniciId)
SELECT b.Id, kb.Id, v.Tarih, v.Tutar, v.OdemeTipi, v.Aciklama, @zeynep
FROM (VALUES
    (N'B-0001', N'Banka TL Hesabı', CAST('2026-10-25 10:00' AS DATETIME2), 15000.00, 2, N'Havale'),
    (N'B-0002', N'Banka TL Hesabı', CAST('2026-11-05 12:00' AS DATETIME2), 20000.00, 3, N'Çek'),
    (N'B-0001', N'Merkez Kasa',     CAST('2026-11-12 17:00' AS DATETIME2),  5000.00, 1, N'Nakit')
) AS v(BayiKodu, KasaAd, Tarih, Tutar, OdemeTipi, Aciklama)
JOIN Bayi b       ON b.BayiKodu = v.BayiKodu
JOIN KasaBanka kb ON kb.Ad = v.KasaAd;

-- 7) Cari hareketler: fatura = BORÇ, tahsilat = ALACAK
INSERT INTO CariHareket (BayiId, Tarih, IslemTipi, FaturaId, Borc, Aciklama)
SELECT f.BayiId, f.FaturaTarihi, 1, f.Id, f.GenelToplam, N'Fatura ' + f.FaturaNo
FROM Fatura f;

INSERT INTO CariHareket (BayiId, Tarih, IslemTipi, TahsilatId, Alacak, Aciklama)
SELECT t.BayiId, t.Tarih, 2, t.Id, t.Tutar, N'Tahsilat - ' + t.Aciklama
FROM Tahsilat t;

PRINT N'Pratik veri yüklendi: 8 sipariş, 16 kalem, 4 fatura, 3 tahsilat.';
