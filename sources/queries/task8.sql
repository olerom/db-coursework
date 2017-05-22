SELECT
  c.НОМЕР_ЦЕХА                            AS "Номер цеха",
  'Производственный'                      AS "Название цеха",
  COUNT(DISTINCT v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ) AS "Кол-во видов изделий",
  i.middle                                AS "Среднее кол-во"
FROM CWПРОИЗВОДСТВ_ЦЕХ c
  JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
    ON k.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
  JOIN CWВИД_ИЗДЕЛИЯ v
    ON v.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ = k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ
  CROSS JOIN (SELECT AVG(amount) middle
              FROM (
                SELECT count(DISTINCT v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ) amount
                FROM CWЦЕХ c
                  LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
                    ON k.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
                  LEFT JOIN CWВИД_ИЗДЕЛИЯ v
                    ON v.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ = k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ
                GROUP BY c.НОМЕР_ЦЕХА)) i
GROUP BY c.НОМЕР_ЦЕХА, i.middle
HAVING COUNT(DISTINCT v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ) > (
  SELECT AVG(amount)
  FROM (
    SELECT count(DISTINCT v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ) amount
    FROM CWЦЕХ c
      LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
        ON k.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
      LEFT JOIN CWВИД_ИЗДЕЛИЯ v
        ON v.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ = k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ
    GROUP BY c.НОМЕР_ЦЕХА));
