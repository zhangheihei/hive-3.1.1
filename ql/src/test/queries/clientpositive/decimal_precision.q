set hive.mapred.mode=nonstrict;
DROP TABLE IF EXISTS DECIMAL_PRECISION_n0;

CREATE TABLE DECIMAL_PRECISION_n0(`dec` decimal(20,10))
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY ' '
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '../../data/files/kv8.txt' INTO TABLE DECIMAL_PRECISION_n0;

SELECT * FROM DECIMAL_PRECISION_n0 ORDER BY `dec`;

SELECT `dec`, `dec` + 1, `dec` - 1 FROM DECIMAL_PRECISION_n0 ORDER BY `dec`;
SELECT `dec`, `dec` * 2, `dec` / 3  FROM DECIMAL_PRECISION_n0 ORDER BY `dec`;
SELECT `dec`, `dec` / 9 FROM DECIMAL_PRECISION_n0 ORDER BY `dec`;
SELECT `dec`, `dec` / 27 FROM DECIMAL_PRECISION_n0 ORDER BY `dec`;
SELECT `dec`, `dec` * `dec` FROM DECIMAL_PRECISION_n0 ORDER BY `dec`;

EXPLAIN SELECT avg(`dec`), sum(`dec`) FROM DECIMAL_PRECISION_n0;
SELECT avg(`dec`), sum(`dec`) FROM DECIMAL_PRECISION_n0;

SELECT `dec` * cast('12345678901234567890.12345678' as decimal(38,18)) FROM DECIMAL_PRECISION_n0 LIMIT 1;
SELECT * from DECIMAL_PRECISION_n0 WHERE `dec` > cast('1234567890123456789012345678.12345678' as decimal(38,18)) LIMIT 1;
SELECT `dec` * 12345678901234567890.12345678 FROM DECIMAL_PRECISION_n0 LIMIT 1;

SELECT MIN(cast('12345678901234567890.12345678' as decimal(38,18))) FROM DECIMAL_PRECISION_n0;
SELECT COUNT(cast('12345678901234567890.12345678' as decimal(38,18))) FROM DECIMAL_PRECISION_n0;

DROP TABLE DECIMAL_PRECISION_n0;

-- Expect overflow and return null as the value
CREATE TABLE DECIMAL_PRECISION_n0(`dec` decimal(38,18));
INSERT INTO DECIMAL_PRECISION_n0 VALUES(98765432109876543210.12345), (98765432109876543210.12345);
SELECT SUM(`dec`) FROM DECIMAL_PRECISION_n0;

DROP TABLE DECIMAL_PRECISION_n0;
