SELECT
  mc.НОМЕР_ЦЕХА,
  mc.НАЗВАНИЕ_ЦЕХА,
  COUNT(*) AS "Кол-во видов"
FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ c
  INNER JOIN CWЦЕХ mc
    ON c.НОМЕР_ЦЕХА = mc.НОМЕР_ЦЕХА
  INNER JOIN CWТИП_КАТЕГОРИИ t
    ON c.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
  INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
    ON k.ТИП_КАТЕГОРИИ = t.ТИП_КАТЕГОРИИ
  INNER JOIN CWВИД_ИЗДЕЛИЯ v
    ON v.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ = k.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ
GROUP BY mc.НОМЕР_ЦЕХА, mc.НАЗВАНИЕ_ЦЕХА
HAVING COUNT(*) > (
  SELECT AVG(count)
  FROM (
    SELECT COUNT(*) count
    FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ C
      INNER JOIN CWТИП_КАТЕГОРИИ t
        ON C.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
      INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
        ON k.ТИП_КАТЕГОРИИ = t.ТИП_КАТЕГОРИИ
      INNER JOIN CWВИД_ИЗДЕЛИЯ v
        ON v.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ = k.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ
    GROUP BY C.НОМЕР_ЦЕХА))
UNION ALL
SELECT
  'Среднее количество: ' || AVG(count),
  NULL,
  NULL
FROM (
  SELECT COUNT(*) count
  FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ C
    INNER JOIN CWТИП_КАТЕГОРИИ t
      ON C.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
    INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
      ON k.ТИП_КАТЕГОРИИ = t.ТИП_КАТЕГОРИИ
    INNER JOIN CWВИД_ИЗДЕЛИЯ v
      ON v.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ = k.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ
  GROUP BY C.НОМЕР_ЦЕХА)

