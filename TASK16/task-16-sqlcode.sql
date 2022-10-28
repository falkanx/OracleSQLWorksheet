INDEX
------

/* INDEX tablo �zerinde yap�lan Select, �nsert, Update gibi i�lemlerin daha performansla �al��mas� i�in olu�turulur.  -*/

>%5
/* %5 Kas�t� de�i�ken fazlal���ndan kaynaklanmaktad�r se�ece�iniz kolon i�inde ne kadar farkl� de�er olursa kategorize etmek o kadar kolayla��r. -*/
/* INDEX genellikle b�y�k datalarda kullan�l�r. -*/
/* INDEX'te hangi kolonun kullan�laca�� explain plan i�inden kontrol edilebilir, de�er 1'den az olacak �ekilde ne kadar uzaksa o kadar kullan��l� hale gelir -*/

CBO - Cost Based Optimizer

cost:  cpu + memory + i/o


100   10
120   2

hint:
/* HINT bir bak�ma index komudunu zorlayarak �al��t�rmakt�r oracle daha az costla ula�aca�� yolu se�ece�i i�in 
daha fazla cost harcayacak index komudu yerine tabloyu tamamen getirir bunu engelleyip yine de index ile �al��mas�n� istersek hint komudu kullan�r�z. -*/

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
/* Yukar�daki select komudundan sonra cust_�d=987 olan datalar� ararken 
index'i olmad��� i�in ilk ba�ta kategorize olmad���ndan datalar� bulana kadar harcanan cost 2491
daha sonra index yarat�nca harcad��� cost 108'e kadar gerileyip performansta b�y�k kazan� sa�lam��t�r-*/

SELECT * FROM HR.SALES WHERE PROD_ID=13 --2490  132

CREATE INDEX HR.IDX2 ON HR.SALES(PROD_ID)
/* Yukar�daki select komudundan sonra PROD_ID=13 olan datalar� ararken 
index'i olmad��� i�in ilk ba�ta kategorize olmad���ndan datalar� bulana kadar harcanan cost 2490
daha sonra index yarat�nca harcad��� cost 132'e kadar gerileyip performansta b�y�k kazan� sa�lam��t�r-*/


SELECT * FROM HR.SALES WHERE CUST_ID=987  AND PROD_ID=13 --32
/* CUST_ID ve PROD_ID'ye ait indexleri bulduktan sonra AND'leyerek ayn� olanlar� bulup sonucu getirdi�i i�in cost azald� ve performansta kazan� sa�lad�. -*/

SELECT * FROM HR.SALES WHERE CUST_ID=987  OR PROD_ID=13 --32 1598
/* AND komuduna nazaran OR 2 SELECT gibi �al��arak HEM 987 HEM DE 13'e ait datalar� birle�tirdi�i i�in cost artm��t�r.  -*/


SELECT * FROM HR.SALES WHERE CHANNEL_ID=2  --2493

CREATE INDEX HR.IDX3 ON HR.SALES(CHANNEL_ID)

SELECT /*+  INDEX(A,IDX3) */  * FROM HR.SALES A WHERE CHANNEL_ID=2  --2493  3572
/* Bu tarz hintlenmi� indexler cost a��s�ndan art��a gidebilirler. Bu y�zden index kullan�rken %5'e yak�n veya daha az miktarda data getirecek �ekilde belirlenmelidir. */


SELECT * FROM HR.SALES WHERE CUST_ID=987 and CHANNEL_ID=3 and PROD_ID=13  --32 5
/* INDEX'leri AND komuduyla istedi�imiz kadar birle�tirebiliriz bu birle�imler cost'u �ok daha fazla azaltarak performans� �ok daha fazla artt�r�r. */


create index hr.idx4 on hr.sales(cust_id,prod_id,channel_id)
/* 3 farkl� kolonu tek index alt�nda toplay�p bu tarzda kullanarak daha anla��labilir halde de yazabiliriz.*/


alter index hr.idx4 rebuild
/* INDEX'in s�f�rdan yarat�l�p daha d�zg�n hale getirilmesine yarar tablo e�er %20'den fazla de�i�tirildiyse yap�lmas� gerekir. 
Bunu Blevel �zerinden ��renebiliriz, �ayet index 3 ve �zerindeyse rebuild edilmedilir. */
alter index hr.idx4 rebuild online
/* Online ile normal rebuild aras�ndaki fark index'in disable olmas�d�r, 
e�er aktif kullan�lan bir ortamda �al���yorsan�z rebuildi online olarak yapmak index'in kopyas�n�n yarat�l�p kullan�ma devam edilmesi i�in gereklidir.
Disable olarak rebuild edilecekse genellikle database bak�mdaysa yap�lmal�d�r*/
delete >%20
select index_name,blevel from all_indexes where index_name like 'IDX%'  >=3
/* INDEX'in ad� ve ne kadar deformasyon oldu�unu kontrol etmek i�in kullan�l�r. */