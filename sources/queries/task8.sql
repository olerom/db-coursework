SELECT
  mc.НОМЕР_ЦЕХА,
  mc.НАЗВАНИЕ_ЦЕХА,
  COUNT(*) AS "Кол-во видов"
FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ c
  INNER JOIN CWЦЕХ mc
    ON c.НОМЕР_ЦЕХА = mc.НОМЕР_ЦЕХА
  INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
    ON k.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
  INNER JOIN CWВИД_ИЗДЕЛИЯ v
    ON v.ТИП_КАТЕГОРИИ = k.ТИП_КАТЕГОРИИ
GROUP BY mc.НОМЕР_ЦЕХА, mc.НАЗВАНИЕ_ЦЕХА
HAVING COUNT(*) > (
  SELECT AVG(count)
  FROM (
    SELECT COUNT(*) count
    FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ c
      INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
        ON k.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
      INNER JOIN CWВИД_ИЗДЕЛИЯ v
        ON v.ТИП_КАТЕГОРИИ = k.ТИП_КАТЕГОРИИ
    GROUP BY c.НОМЕР_ЦЕХА))
UNION ALL
SELECT
  'Среднее количество: ' || AVG(count),
  NULL,
  NULL
FROM (
  SELECT COUNT(*) count
  FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ c
    INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
      ON k.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
    INNER JOIN CWВИД_ИЗДЕЛИЯ v
      ON v.ТИП_КАТЕГОРИИ = k.ТИП_КАТЕГОРИИ
  GROUP BY c.НОМЕР_ЦЕХА);
