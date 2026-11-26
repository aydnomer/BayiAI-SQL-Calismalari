# BayiAI SQL Çalışmaları

BayiAI projesini geliştirirken yaptığım SQL Server alıştırmaları.

Bu alıştırmalar [BayiAI projesiyle](https://github.com/aydnomer/BayiAI) aynı dönemde yapılmıştır.

## İçerik

| Dosya | Konu |
|---|---|
| [`00_kontrol.sql`](00_kontrol.sql) | Veritabanının alıştırmalara hazır olup olmadığını kontrol eder |
| [`03_pratik_veri.sql`](03_pratik_veri.sql) | Alıştırmalar için sipariş / fatura / tahsilat örnek verisi |
| [`hafta-calismalari/01_select_where_orderby.sql`](hafta-calismalari/01_select_where_orderby.sql) | SELECT, WHERE, ORDER BY, TOP, DISTINCT, LIKE, NULL |
| [`hafta-calismalari/02_fonksiyonlar_groupby.sql`](hafta-calismalari/02_fonksiyonlar_groupby.sql) | Metin/tarih/sayı fonksiyonları, CASE, toplama fonksiyonları, GROUP BY, HAVING |
| [`hafta-calismalari/03_join.sql`](hafta-calismalari/03_join.sql) | JOIN türleri |
| [`hafta-calismalari/04_veri_degistirme_altsorgu.sql`](hafta-calismalari/04_veri_degistirme_altsorgu.sql) | INSERT, UPDATE, DELETE, OUTPUT, alt sorgu, EXISTS, CTE |
| [`hafta-calismalari/05_view_transaction_procedure.sql`](hafta-calismalari/05_view_transaction_procedure.sql) | Pencere fonksiyonları, VIEW, transaction + TRY/CATCH, stored procedure |

## Gereksinimler

- SQL Server 2016 veya üzeri (ücretsiz Express ya da Developer sürümü yeterli)
- SQL Server Management Studio (SSMS) ya da Azure Data Studio

## Nasıl çalıştırılır

1. [BayiAI](https://github.com/aydnomer/BayiAI) reposundaki `database/01_tablolar.sql` ve `database/02_ornek_veri.sql` dosyalarını SQL Server'da çalıştır.
2. Bu repodaki `03_pratik_veri.sql` dosyasını bir kez çalıştır.
3. `00_kontrol.sql` ile tüm tabloların dolu olduğunu doğrula.
4. `hafta-calismalari/` altındaki dosyaları sırayla aç; her sorunun altına sorguyu yazıp F5 ile dene.

## İlerleme

- [ ] 1. gün: SELECT, WHERE, ORDER BY
- [ ] 2. gün: Fonksiyonlar, GROUP BY
- [ ] 3. gün: JOIN
- [ ] 4. gün: Veri değiştirme, alt sorgu
- [ ] 5. gün: VIEW, transaction, procedure
