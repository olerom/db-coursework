SELECT
  s.ФАМИЛИЯ_СОТРУДНИКА,
  s.ИМЯ_СОТРУДНИКА,
  s.ОТЧЕСТВО_СОТРУДНИКА,
  'Начальник цеха' AS "Чем занимается на предприятии"
FROM CWЦЕХ c
  INNER JOIN CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ p
    ON c.НОМЕР_ЦЕХА = p.НОМЕР_ЦЕХА
  INNER JOIN CWТИП_КАТЕГОРИИ t
    ON c.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
  INNER JOIN CWРУКОВОДИТЕЛЬ r
    ON r.КОД_ОТВЕТСТВ = c.НАЧАЛЬНИК_ЦЕХА
  INNER JOIN CWСОТРУДНИК s
    ON s.КОД_СОТРУДНИКА = r.КОД_СОТРУДНИКА
GROUP BY s.ФАМИЛИЯ_СОТРУДНИКА, s.ОТЧЕСТВО_СОТРУДНИКА, s.ИМЯ_СОТРУДНИКА, s.КОД_СОТРУДНИКА
HAVING COUNT(*) = (
  SELECT MAX(count)
  FROM (
    SELECT
      c.НОМЕР_ЦЕХА,
      COUNT(*) count
    FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ c
      INNER JOIN CWТИП_КАТЕГОРИИ t
        ON t.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
    GROUP BY C.НОМЕР_ЦЕХА))
UNION ALL
SELECT
  s.ФАМИЛИЯ_СОТРУДНИКА,
  s.ИМЯ_СОТРУДНИКА,
  s.ОТЧЕСТВО_СОТРУДНИКА,
  'Начальник участка'
FROM CWЦЕХ c
  INNER JOIN CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ p
    ON c.НОМЕР_ЦЕХА = p.НОМЕР_ЦЕХА
  INNER JOIN CWТИП_КАТЕГОРИИ t
    ON c.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
  INNER JOIN CWУЧАСТОК u
    ON u.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
  INNER JOIN CWРУКОВОДИТЕЛЬ r
    ON r.КОД_ОТВЕТСТВ = u.НАЧАЛЬНИК_УЧАСТКА
  INNER JOIN CWСОТРУДНИК s
    ON s.КОД_СОТРУДНИКА = r.КОД_СОТРУДНИКА
GROUP BY s.ФАМИЛИЯ_СОТРУДНИКА, s.ОТЧЕСТВО_СОТРУДНИКА, s.ИМЯ_СОТРУДНИКА, s.КОД_СОТРУДНИКА
HAVING COUNT(*) = (
  SELECT MAX(count)
  FROM (
    SELECT
      c.НОМЕР_ЦЕХА,
      COUNT(*) count
    FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ c
      INNER JOIN CWТИП_КАТЕГОРИИ t
        ON t.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
    GROUP BY C.НОМЕР_ЦЕХА));


SELECT
  DISTINCT
  s.ФАМИЛИЯ_СОТРУДНИКА,
  s.ИМЯ_СОТРУДНИКА,
  s.ОТЧЕСТВО_СОТРУДНИКА,
  s.НОМЕР_ДОГОВОРА,
  'Мастер' AS "Чем занимается на предприятии"
FROM CWРАБОТЫ r
  INNER JOIN CWБРИГАДА b
    ON b.НОМЕР_БРИГАДЫ = r.НОМЕР_БРИГАДЫ
  INNER JOIN CWРУКОВОДИТЕЛЬ o
    ON o.КОД_ОТВЕТСТВ = b.МАСТЕР
  INNER JOIN CWСОТРУДНИК s
    ON s.КОД_СОТРУДНИКА = o.КОД_СОТРУДНИКА
WHERE r.НОМЕР_ЦЕХА = ANY (
  SELECT C.НОМЕР_ЦЕХА
  FROM CWЦЕХ C
    INNER JOIN CWТИП_КАТЕГОРИИ t
      ON C.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
  GROUP BY C.НОМЕР_ЦЕХА
  HAVING COUNT(*) = (
    SELECT MAX(count)
    FROM (
      SELECT
        C.НОМЕР_ЦЕХА,
        COUNT(*) count
      FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ C
        INNER JOIN CWТИП_КАТЕГОРИИ t
          ON t.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
      GROUP BY C.НОМЕР_ЦЕХА)));

SELECT
  DISTINCT
  s.ФАМИЛИЯ_СОТРУДНИКА,
  s.ИМЯ_СОТРУДНИКА,
  s.ОТЧЕСТВО_СОТРУДНИКА,
  s.НОМЕР_ДОГОВОРА,
  'В бригаде, (не бригадир)' AS "Чем занимается на предприятии"
FROM CWРАБОТЫ r
  INNER JOIN CWБРИГАДА b
    ON b.НОМЕР_БРИГАДЫ = r.НОМЕР_БРИГАДЫ
  INNER JOIN CWРАБОЧИЙ w
    ON w.НОМЕР_БРИГАДЫ = b.НОМЕР_БРИГАДЫ
       AND w.КОД_СОТРУДНИКА != b.БРИГАДИР
  INNER JOIN CWСОТРУДНИК s
    ON s.КОД_СОТРУДНИКА = w.КОД_СОТРУДНИКА
WHERE r.НОМЕР_ЦЕХА = ANY (
  SELECT C.НОМЕР_ЦЕХА
  FROM CWЦЕХ C
    INNER JOIN CWТИП_КАТЕГОРИИ t
      ON C.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
  GROUP BY C.НОМЕР_ЦЕХА
  HAVING COUNT(*) = (
    SELECT MAX(count)
    FROM (
      SELECT
        C.НОМЕР_ЦЕХА,
        COUNT(*) count
      FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ C
        INNER JOIN CWТИП_КАТЕГОРИИ t
          ON t.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
      GROUP BY C.НОМЕР_ЦЕХА)));
SELECT
  DISTINCT
  s.ФАМИЛИЯ_СОТРУДНИКА,
  s.ИМЯ_СОТРУДНИКА,
  s.ОТЧЕСТВО_СОТРУДНИКА,
  s.НОМЕР_ДОГОВОРА,
  'Бригадир' AS "Чем занимается на предприятии"
FROM CWРАБОТЫ r
  INNER JOIN CWБРИГАДА b
    ON b.НОМЕР_БРИГАДЫ = r.НОМЕР_БРИГАДЫ
  INNER JOIN CWРАБОЧИЙ w
    ON w.НОМЕР_БРИГАДЫ = b.НОМЕР_БРИГАДЫ
       AND w.КОД_СОТРУДНИКА = b.БРИГАДИР
  INNER JOIN CWСОТРУДНИК s
    ON s.КОД_СОТРУДНИКА = w.КОД_СОТРУДНИКА
WHERE r.НОМЕР_ЦЕХА = ANY (
  SELECT C.НОМЕР_ЦЕХА
  FROM CWЦЕХ C
    INNER JOIN CWТИП_КАТЕГОРИИ t
      ON C.НОМЕР_ЦЕХА = t.НОМЕР_ЦЕХА
  GROUP BY C.НОМЕР_ЦЕХА
  HAVING COUNT(*) = (
    SELECT MAX(count)
    FROM (
      SELECT
        C.НОМЕР_ЦЕХА,
        COUNT(*) count
      FROM CWПРОИЗВОДСТВЕННЫЙ_ЦЕХ C
        INNER JOIN CWТИП_КАТЕГОРИИ t
          ON t.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
      GROUP BY C.НОМЕР_ЦЕХА)));
