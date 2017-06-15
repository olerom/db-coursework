SELECT
  s.ФАМИЛИЯ_СОТРУДНИКА,
  s.ИМЯ_СОТРУДНИКА,
  s.ОТЧЕСТВО_СОТРУДНИКА,
  s.ДОЛЖНОСТЬ_СОТРУДНИКА,
  'Начальник цеха' AS "Чем занимается на предприятии"
FROM CWЦЕХ c
  INNER JOIN CWРУКОВОДИТЕЛЬ r
    ON c.НАЧАЛЬНИК_ЦЕХА = r.КОД_ОТВЕТСТВ
  INNER JOIN CWСОТРУДНИК s
    ON s.КОД_СОТРУДНИКА = r.КОД_СОТРУДНИКА
WHERE c.НОМЕР_ЦЕХА = ANY (
  SELECT C.НОМЕР_ЦЕХА
  FROM CWЦЕХ C
    INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
      ON C.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
  GROUP BY C.НОМЕР_ЦЕХА
  HAVING COUNT(*) = (
    SELECT MAX(count)
    FROM (
      SELECT
        C.НОМЕР_ЦЕХА,
        COUNT(*) count
      FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ C
        INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
          ON t.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
      GROUP BY C.НОМЕР_ЦЕХА)))
UNION ALL
SELECT
  s.ФАМИЛИЯ_СОТРУДНИКА,
  s.ИМЯ_СОТРУДНИКА,
  s.ОТЧЕСТВО_СОТРУДНИКА,
  s.ДОЛЖНОСТЬ_СОТРУДНИКА,
  'Начальник участка'
FROM CWУЧАСТОК u
  INNER JOIN CWРУКОВОДИТЕЛЬ r
    ON u.НАЧАЛЬНИК_УЧАСТКА = r.КОД_ОТВЕТСТВ
  INNER JOIN CWСОТРУДНИК s
    ON s.КОД_СОТРУДНИКА = r.КОД_СОТРУДНИКА
WHERE u.НОМЕР_ЦЕХА = ANY (
  SELECT C.НОМЕР_ЦЕХА
  FROM CWЦЕХ C
    INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
      ON C.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
  GROUP BY C.НОМЕР_ЦЕХА
  HAVING COUNT(*) = (
    SELECT MAX(count)
    FROM (
      SELECT
        C.НОМЕР_ЦЕХА,
        COUNT(*) count
      FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ C
        INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
          ON t.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
      GROUP BY C.НОМЕР_ЦЕХА)))
UNION ALL
SELECT
  f,
  i,
  o,
  d,
  'Мастер'
FROM (
  SELECT
    DISTINCT
    s.ФАМИЛИЯ_СОТРУДНИКА   f,
    s.ИМЯ_СОТРУДНИКА       i,
    s.ОТЧЕСТВО_СОТРУДНИКА  o,
    s.ДОЛЖНОСТЬ_СОТРУДНИКА d,
    s.НОМЕР_ДОГОВОРА
  FROM CWУЧАСТОК u
    INNER JOIN CWРАБОТЫ r
      ON r.КОД_УЧАСТКА = u.КОД_УЧАСТКА
    INNER JOIN CWБРИГАДА b
      ON b.НОМЕР_БРИГАДЫ = r.НОМЕР_БРИГАДЫ
    INNER JOIN CWРУКОВОДИТЕЛЬ o
      ON o.КОД_ОТВЕТСТВ = b.МАСТЕР
    INNER JOIN CWСОТРУДНИК s
      ON s.КОД_СОТРУДНИКА = o.КОД_СОТРУДНИКА
  WHERE u.НОМЕР_ЦЕХА = ANY (
    SELECT C.НОМЕР_ЦЕХА
    FROM CWЦЕХ C
      INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
        ON C.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
    GROUP BY C.НОМЕР_ЦЕХА
    HAVING COUNT(*) = (
      SELECT MAX(count)
      FROM (
        SELECT
          C.НОМЕР_ЦЕХА,
          COUNT(*) count
        FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ C
          INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
            ON t.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
        GROUP BY C.НОМЕР_ЦЕХА))))
UNION ALL
SELECT
  f,
  i,
  o,
  d,
  'Бригадир'
FROM (
  SELECT
    DISTINCT
    s.ФАМИЛИЯ_СОТРУДНИКА   f,
    s.ИМЯ_СОТРУДНИКА       i,
    s.ОТЧЕСТВО_СОТРУДНИКА  o,
    s.ДОЛЖНОСТЬ_СОТРУДНИКА d,
    s.НОМЕР_ДОГОВОРА
  FROM CWУЧАСТОК u
    INNER JOIN CWРАБОТЫ r
      ON r.КОД_УЧАСТКА = u.КОД_УЧАСТКА
    INNER JOIN CWБРИГАДА b
      ON b.НОМЕР_БРИГАДЫ = r.НОМЕР_БРИГАДЫ
    INNER JOIN CWСОТРУДНИК s
      ON s.КОД_СОТРУДНИКА = b.БРИГАДИР
  WHERE u.НОМЕР_ЦЕХА = ANY (
    SELECT C.НОМЕР_ЦЕХА
    FROM CWЦЕХ C
      INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
        ON C.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
    GROUP BY C.НОМЕР_ЦЕХА
    HAVING COUNT(*) = (
      SELECT MAX(count)
      FROM (
        SELECT
          C.НОМЕР_ЦЕХА,
          COUNT(*) count
        FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ C
          INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
            ON t.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
        GROUP BY C.НОМЕР_ЦЕХА))))
UNION ALL
SELECT
  f,
  i,
  o,
  d,
  'Не бригадир'
FROM (
  SELECT
    DISTINCT
    s.ФАМИЛИЯ_СОТРУДНИКА   f,
    s.ИМЯ_СОТРУДНИКА       i,
    s.ОТЧЕСТВО_СОТРУДНИКА  o,
    s.ДОЛЖНОСТЬ_СОТРУДНИКА d,
    s.НОМЕР_ДОГОВОРА
  FROM CWУЧАСТОК u
    INNER JOIN CWРАБОТЫ r
      ON r.КОД_УЧАСТКА = u.КОД_УЧАСТКА
    INNER JOIN CWБРИГАДА b
      ON b.НОМЕР_БРИГАДЫ = r.НОМЕР_БРИГАДЫ
    INNER JOIN CWРАБОЧИЙ w
      ON b.НОМЕР_БРИГАДЫ = w.НОМЕР_БРИГАДЫ
         AND b.БРИГАДИР != w.КОД_СОТРУДНИКА
    INNER JOIN CWСОТРУДНИК s
      ON w.КОД_СОТРУДНИКА = s.КОД_СОТРУДНИКА
  WHERE u.НОМЕР_ЦЕХА = ANY (
    SELECT C.НОМЕР_ЦЕХА
    FROM CWЦЕХ C
      INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
        ON C.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
    GROUP BY C.НОМЕР_ЦЕХА
    HAVING COUNT(*) = (
      SELECT MAX(count)
      FROM (
        SELECT
          C.НОМЕР_ЦЕХА,
          COUNT(*) count
        FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ C
          INNER JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ t
            ON t.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
        GROUP BY C.НОМЕР_ЦЕХА))));
