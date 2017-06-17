DEFINE manufactory='П321';
DEFINE cat = 'Мотоциклы';

SELECT
  v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ
FROM CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
  INNER JOIN CWВИД_ИЗДЕЛИЯ v
    ON v.ТИП_КАТЕГОРИИ = k.ТИП_КАТЕГОРИИ
WHERE k.НОМЕР_ЦЕХА = '&manufactory' AND k.ТИП_КАТЕГОРИИ = '&cat'
UNION ALL
SELECT
  'Всего видов изделий на указанном цеху с указанной категорией: ' || COUNT(*) 
FROM CWВИД_ИЗДЕЛИЯ v
  INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
    ON v.ТИП_КАТЕГОРИИ = k.ТИП_КАТЕГОРИИ
WHERE k.НОМЕР_ЦЕХА = '&manufactory' AND k.ТИП_КАТЕГОРИИ = '&cat'
UNION ALL
SELECT
  'Всего видов изделий на указанном цеху: ' || COUNT(*)
FROM CWВИД_ИЗДЕЛИЯ v
  INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
    ON v.ТИП_КАТЕГОРИИ = k.ТИП_КАТЕГОРИИ
WHERE k.НОМЕР_ЦЕХА = '&manufactory'
UNION ALL
SELECT
  'Всего видов изделий на предприятии: ' || COUNT(*)
FROM CWВИД_ИЗДЕЛИЯ v
  INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
    ON v.ТИП_КАТЕГОРИИ = k.ТИП_КАТЕГОРИИ;
