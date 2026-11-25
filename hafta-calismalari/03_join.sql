/* =====================================================================
   BayiAI SQL Çalışmaları · 3. GÜN (26 Kasım, Perşembe)
   Konu: INNER / LEFT / RIGHT / FULL / CROSS / SELF JOIN, JOIN + GROUP BY
   PDF: SQL 3 · Cevaplar: Ek C, Gün 3
   Kural: Her kolonun önüne tablo takma adı yaz (b.Id, s.BayiId).
          LEFT JOIN'de sağ tablonun filtresi ON'a, COUNT(sag.Id) kullan.
   ===================================================================== */
USE BayiAI;
GO

-- 1) Bayileri bölge adıyla listele (BayiKodu, Unvan, Bolge).


-- 2) Ürünleri kategori adıyla ve üst kategori adıyla listele (iki JOIN, biri LEFT).


-- 3) Siparişleri bayi unvanı ve siparişi giren kullanıcının AdSoyad'ı ile listele.


-- 4) Hiç sipariş vermemiş bayiler (LEFT JOIN + IS NULL).


-- 5) Hiç satılmamış ürünler.


-- 6) Her bölgenin iptal hariç cirosu; siparişi olmayan bölge 0 görünsün.


-- 7) SP-0004'ün kalemleri (ürün adı, miktar, birim fiyat, satır toplamı) +
--    ayrı sorguyla: kalemlerin SatirToplam toplamı = siparişin GenelToplam'ı mı?


-- 8) Ürün bazında satılan toplam miktar ve ciro (iptal hariç), en çok satan üstte.


-- 9) Faturaları bayi unvanı ve sipariş numarasıyla, vadesi geçenler üstte.


-- 10) Kullanicilar: her satış temsilcisinin (Bayi.SorumluKullaniciId) sorumlu olduğu bayi sayısı.
--     Hiç bayisi olmayan kullanıcılar da 0 ile görünsün.


-- 11) Kategori tablosunu kendisiyle birleştir: AltKategori | UstKategori (SELF JOIN).


-- BONUS) Bayi + Fatura + Tahsilat'ı direkt JOIN'leyip toplamları al. B-0001'in rakamları neden şişti?
--        Cevabını yorum olarak yaz.

