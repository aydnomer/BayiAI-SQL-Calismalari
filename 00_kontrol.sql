/* =====================================================================
   BayiAI SQL Çalışmaları · 00_kontrol.sql
   Alıştırmalara başlamadan önce veritabanının hazır olduğunu kontrol eder.
   Tamamını seçip F5'e basın; her satırda Durum = 'TAMAM' görmelisiniz.
   ===================================================================== */
USE BayiAI;
GO

SELECT Tablo, KayitSayisi,
       CASE WHEN KayitSayisi > 0 THEN N'TAMAM' ELSE N'EKSİK' END AS Durum
FROM (
    SELECT N'Bayi'          AS Tablo, COUNT(*) AS KayitSayisi FROM Bayi
    UNION ALL SELECT N'Urun',          COUNT(*) FROM Urun
    UNION ALL SELECT N'Kullanici',     COUNT(*) FROM Kullanici
    UNION ALL SELECT N'Siparis',       COUNT(*) FROM Siparis
    UNION ALL SELECT N'SiparisKalemi', COUNT(*) FROM SiparisKalemi
    UNION ALL SELECT N'Fatura',        COUNT(*) FROM Fatura
    UNION ALL SELECT N'Tahsilat',      COUNT(*) FROM Tahsilat
    UNION ALL SELECT N'CariHareket',   COUNT(*) FROM CariHareket
) AS t
ORDER BY Tablo;

/* EKSİK görürseniz:
   - Bayi / Urun / Kullanici boşsa  -> BayiAI reposundaki database/02_ornek_veri.sql
   - Siparis / Fatura / Tahsilat boşsa -> bu repodaki 03_pratik_veri.sql */
