-- DEFINE manufactory_id=0;

SELECT
  v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ,
  k.ТИП_КАТЕГОРИИ
FROM CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
  INNER JOIN CWВИД_ИЗДЕЛИЯ v
    ON v.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ = k.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ
WHERE k.ТИП_КАТЕГОРИИ = ANY (SELECT t.ТИП_КАТЕГОРИИ
                             FROM CWТИП_КАТЕГОРИИ t
                             WHERE t.НОМЕР_ЦЕХА = 'П321')
UNION ALL
SELECT
  'Всего изделий: ' || COUNT(*),
  ''
FROM CWВИД_ИЗДЕЛИЯ;
