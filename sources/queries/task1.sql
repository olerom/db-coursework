DEFINE manufactory='П321';

SELECT
  v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ,
  k.ТИП_КАТЕГОРИИ
FROM CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
  INNER JOIN CWВИД_ИЗДЕЛИЯ v
    ON v.ТИП_КАТЕГОРИИ = k.ТИП_КАТЕГОРИИ
WHERE k.ТИП_КАТЕГОРИИ = ANY (SELECT t.ТИП_КАТЕГОРИИ
                             FROM CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
                             WHERE t.НОМЕР_ЦЕХА = '&manufactory')
UNION ALL
SELECT
  'Всего видов изделий на указанном цеху: ' || COUNT(*),
  ''
FROM CWВИД_ИЗДЕЛИЯ v
  INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
    ON v.ТИП_КАТЕГОРИИ = k.ТИП_КАТЕГОРИИ
WHERE k.НОМЕР_ЦЕХА = '&manufactory'
UNION ALL
SELECT
  'Всего видов изделий на предприятии: ' || COUNT(*),
  ''
FROM CWВИД_ИЗДЕЛИЯ v
  INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
    ON v.ТИП_КАТЕГОРИИ = k.ТИП_КАТЕГОРИИ;
