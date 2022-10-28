INDEX
------

/* INDEX tablo üzerinde yapýlan Select, Ýnsert, Update gibi iþlemlerin daha performansla çalýþmasý için oluþturulur.  -*/

>%5
/* %5 Kasýtý deðiþken fazlalýðýndan kaynaklanmaktadýr seçeceðiniz kolon içinde ne kadar farklý deðer olursa kategorize etmek o kadar kolaylaþýr. -*/
/* INDEX genellikle büyük datalarda kullanýlýr. -*/
/* INDEX'te hangi kolonun kullanýlacaðý explain plan içinden kontrol edilebilir, deðer 1'den az olacak þekilde ne kadar uzaksa o kadar kullanýþlý hale gelir -*/

CBO - Cost Based Optimizer

cost:  cpu + memory + i/o


100   10
120   2

hint:
/* HINT bir bakýma index komudunu zorlayarak çalýþtýrmaktýr oracle daha az costla ulaþacaðý yolu seçeceði için 
daha fazla cost harcayacak index komudu yerine tabloyu tamamen getirir bunu engelleyip yine de index ile çalýþmasýný istersek hint komudu kullanýrýz. -*/

select * from hr.employees
select /*+  INDEX(A,EMP_EMP_ID_PK) */  * from hr.employees A



select * from hr.employees where employee_id=100
select /*+  FULL(a) */  * from hr.employees a where employee_id=100


CREATE TABLE HR.SALES AS SELECT * FROM SH.SALES


SELECT * FROM HR.SALES


STATISTIC

SELECT TABLE_NAME,NUM_ROWS,LAST_ANALYZED FROM ALL_TABLES WHERE TABLE_NAME='SALES'

SELECT * FROM ALL_TAB_COL_STATISTICS

INSERT INTO HR.SALES SELECT * FROM HR.SALES


ROLLBACK


%10 DML
CALL DBMS_STATS.GATHER_TABLE_STATS('HR','SALES')

SELECT * FROM ALL_TAB_MODIFICATIONS WHERE TABLE_NAME='SALES'


SELECT * FROM SH.SALES


SELECT * FROM ALL_TAB_COL_STATISTICS WHERE TABLE_NAME='SALES' AND OWNER='HR'



SELECT * FROM HR.SALES WHERE CUST_ID=987  -- 2491 108

CREATE INDEX HR.IDX ON HR.SALES(CUST_ID)
/* Yukarýdaki select komudundan sonra cust_ýd=987 olan datalarý ararken 
index'i olmadýðý için ilk baþta kategorize olmadýðýndan datalarý bulana kadar harcanan cost 2491
daha sonra index yaratýnca harcadýðý cost 108'e kadar gerileyip performansta büyük kazanç saðlamýþtýr-*/

SELECT * FROM HR.SALES WHERE PROD_ID=13 --2490  132

CREATE INDEX HR.IDX2 ON HR.SALES(PROD_ID)
/* Yukarýdaki select komudundan sonra PROD_ID=13 olan datalarý ararken 
index'i olmadýðý için ilk baþta kategorize olmadýðýndan datalarý bulana kadar harcanan cost 2490
daha sonra index yaratýnca harcadýðý cost 132'e kadar gerileyip performansta büyük kazanç saðlamýþtýr-*/


SELECT * FROM HR.SALES WHERE CUST_ID=987  AND PROD_ID=13 --32
/* CUST_ID ve PROD_ID'ye ait indexleri bulduktan sonra AND'leyerek ayný olanlarý bulup sonucu getirdiði için cost azaldý ve performansta kazanç saðladý. -*/

SELECT * FROM HR.SALES WHERE CUST_ID=987  OR PROD_ID=13 --32 1598
/* AND komuduna nazaran OR 2 SELECT gibi çalýþarak HEM 987 HEM DE 13'e ait datalarý birleþtirdiði için cost artmýþtýr.  -*/


SELECT * FROM HR.SALES WHERE CHANNEL_ID=2  --2493

CREATE INDEX HR.IDX3 ON HR.SALES(CHANNEL_ID)

SELECT /*+  INDEX(A,IDX3) */  * FROM HR.SALES A WHERE CHANNEL_ID=2  --2493  3572
/* Bu tarz hintlenmiþ indexler cost açýsýndan artýþa gidebilirler. Bu yüzden index kullanýrken %5'e yakýn veya daha az miktarda data getirecek þekilde belirlenmelidir. */


SELECT * FROM HR.SALES WHERE CUST_ID=987 and CHANNEL_ID=3 and PROD_ID=13  --32 5
/* INDEX'leri AND komuduyla istediðimiz kadar birleþtirebiliriz bu birleþimler cost'u çok daha fazla azaltarak performansý çok daha fazla arttýrýr. */


create index hr.idx4 on hr.sales(cust_id,prod_id,channel_id)
/* 3 farklý kolonu tek index altýnda toplayýp bu tarzda kullanarak daha anlaþýlabilir halde de yazabiliriz.*/


alter index hr.idx4 rebuild
/* INDEX'in sýfýrdan yaratýlýp daha düzgün hale getirilmesine yarar tablo eðer %20'den fazla deðiþtirildiyse yapýlmasý gerekir. 
Bunu Blevel üzerinden öðrenebiliriz, þayet index 3 ve üzerindeyse rebuild edilmedilir. */
alter index hr.idx4 rebuild online
/* Online ile normal rebuild arasýndaki fark index'in disable olmasýdýr, 
eðer aktif kullanýlan bir ortamda çalýþýyorsanýz rebuildi online olarak yapmak index'in kopyasýnýn yaratýlýp kullanýma devam edilmesi için gereklidir.
Disable olarak rebuild edilecekse genellikle database bakýmdaysa yapýlmalýdýr*/
delete >%20
select index_name,blevel from all_indexes where index_name like 'IDX%'  >=3
/* INDEX'in adý ve ne kadar deformasyon olduðunu kontrol etmek için kullanýlýr. */