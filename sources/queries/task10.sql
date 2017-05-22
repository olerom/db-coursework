-- Для начальников цехов
SELECT
  s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ИМЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS "ФИО",
  'Начальник цеха'                                                                AS "Должность"
FROM CWЦЕХ c
  JOIN CWСОТРУДНИК s
    ON s.НОМЕР_ДОГОВОРА = c.НОМЕР_ДОГОВОРА

WHERE c.НОМЕР_ЦЕХА = ANY (
  SELECT c.НОМЕР_ЦЕХА
  FROM CWПРОИЗВОДСТВ_ЦЕХ c
  MINUS
  SELECT l.m
  FROM
    (SELECT
       COUNT(DISTINCT k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ) n,
       c.НОМЕР_ЦЕХА                                 m
     FROM CWПРОИЗВОДСТВ_ЦЕХ c
       LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
         ON k.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
     GROUP BY c.НОМЕР_ЦЕХА) l
    JOIN (SELECT
            COUNT(DISTINCT k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ) n,
            c.НОМЕР_ЦЕХА                                 m
          FROM CWПРОИЗВОДСТВ_ЦЕХ C
            LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
              ON k.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
          GROUP BY c.НОМЕР_ЦЕХА) r
      ON l.n < r.n)
-- Для начальников участков
UNION ALL
SELECT
  s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ИМЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS "ФИО",
  'Начальник участка'                                                             AS "Должность"
FROM CWЦЕХ c
  JOIN CWУЧАСТОК u
    ON u.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
  JOIN CWСОТРУДНИК s
    ON s.НОМЕР_ДОГОВОРА = u.НОМЕР_ДОГОВОРА
WHERE c.НОМЕР_ЦЕХА = ANY (
  SELECT c.НОМЕР_ЦЕХА
  FROM CWПРОИЗВОДСТВ_ЦЕХ c
  MINUS
  SELECT l.m
  FROM
    (SELECT
       COUNT(DISTINCT k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ) n,
       c.НОМЕР_ЦЕХА                                 m
     FROM CWПРОИЗВОДСТВ_ЦЕХ c
       LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
         ON k.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
     GROUP BY c.НОМЕР_ЦЕХА) l
    JOIN (SELECT
            COUNT(DISTINCT k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ) n,
            c.НОМЕР_ЦЕХА                                 m
          FROM CWПРОИЗВОДСТВ_ЦЕХ C
            LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
              ON k.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
          GROUP BY c.НОМЕР_ЦЕХА) r
      ON l.n < r.n)
-- Для мастеров
UNION ALL
SELECT
  t.fio AS "ФИО",
  t.d   AS "Должность"
FROM (
       SELECT DISTINCT
         s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ИМЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS fio,
         'Мастер'                                                                        AS d,
         s.НОМЕР_ДОГОВОРА
       FROM CWЦЕХ c
         JOIN CWУЧАСТОК u
           ON u.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
         JOIN CWМАСТЕР_НАЧАЛЬНИК m
           ON m.ДОГОВОР_НАЧ_УЧ = u.НОМЕР_ДОГОВОРА
         JOIN CWСОТРУДНИК s
           ON s.НОМЕР_ДОГОВОРА = m.ДОГОВОР_МАСТЕР
       WHERE c.НОМЕР_ЦЕХА = ANY (
         SELECT c.НОМЕР_ЦЕХА
         FROM CWПРОИЗВОДСТВ_ЦЕХ c
         MINUS
         SELECT l.m
         FROM
           (SELECT
              COUNT(DISTINCT k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ) n,
              c.НОМЕР_ЦЕХА                                 m
            FROM CWПРОИЗВОДСТВ_ЦЕХ c
              LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
                ON k.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
            GROUP BY c.НОМЕР_ЦЕХА) l
           JOIN (SELECT
                   COUNT(DISTINCT k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ) n,
                   c.НОМЕР_ЦЕХА                                 m
                 FROM CWПРОИЗВОДСТВ_ЦЕХ C
                   LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
                     ON k.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
                 GROUP BY c.НОМЕР_ЦЕХА) r
             ON l.n < r.n)) t
-- Для бригадиров
UNION ALL
SELECT
  t.fio,
  t.d
FROM (
       SELECT DISTINCT
         s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ИМЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS fio,
         'Бригадир'                                                                      AS d,
         s.НОМЕР_ДОГОВОРА
       FROM CWЦЕХ c
         JOIN CWУЧАСТОК u
           ON u.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
         JOIN CWМАСТЕР_НАЧАЛЬНИК m
           ON m.ДОГОВОР_НАЧ_УЧ = u.НОМЕР_ДОГОВОРА
         JOIN CWМАСТЕР_БРИГАДА i
           ON i.НОМЕР_ДОГОВОРА = m.ДОГОВОР_МАСТЕР
         JOIN CWРАБОЧИЙ r
           ON r.ИД_БРИГАДЫ = i.ИД_БРИГАДЫ
         JOIN CWБРИГАДА b
           ON b.ИД_БРИГАДЫ = i.ИД_БРИГАДЫ
              AND b.НОМЕР_ДОГОВОРА = r.НОМЕР_ДОГОВОРА
         JOIN CWСОТРУДНИК s
           ON s.НОМЕР_ДОГОВОРА = b.НОМЕР_ДОГОВОРА
       WHERE C.НОМЕР_ЦЕХА = ANY (
         SELECT C.НОМЕР_ЦЕХА
         FROM CWПРОИЗВОДСТВ_ЦЕХ C
         MINUS
         SELECT l.m
         FROM
           (SELECT
              COUNT(DISTINCT k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ) n,
              C.НОМЕР_ЦЕХА                                 m
            FROM CWПРОИЗВОДСТВ_ЦЕХ C
              LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
                ON k.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
            GROUP BY C.НОМЕР_ЦЕХА) l
           JOIN (SELECT
                   COUNT(DISTINCT k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ) n,
                   C.НОМЕР_ЦЕХА                                 m
                 FROM CWПРОИЗВОДСТВ_ЦЕХ C
                   LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
                     ON k.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
                 GROUP BY C.НОМЕР_ЦЕХА) r
             ON l.n < r.n)) t
-- Для рабочих
UNION ALL
SELECT
  t.fio,
  t.d
FROM (
       SELECT DISTINCT
         s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ИМЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS fio,
         'Рабочий'                                                                       AS d
       FROM CWЦЕХ c
         JOIN CWУЧАСТОК u
           ON u.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
         JOIN CWМАСТЕР_НАЧАЛЬНИК m
           ON m.ДОГОВОР_НАЧ_УЧ = u.НОМЕР_ДОГОВОРА
         JOIN CWМАСТЕР_БРИГАДА i
           ON i.НОМЕР_ДОГОВОРА = m.ДОГОВОР_МАСТЕР
         JOIN CWРАБОЧИЙ r
           ON r.ИД_БРИГАДЫ = i.ИД_БРИГАДЫ
         JOIN CWБРИГАДА b
           ON b.ИД_БРИГАДЫ = i.ИД_БРИГАДЫ
              AND b.НОМЕР_ДОГОВОРА != r.НОМЕР_ДОГОВОРА
         JOIN CWСОТРУДНИК s
           ON s.НОМЕР_ДОГОВОРА = r.НОМЕР_ДОГОВОРА
       WHERE c.НОМЕР_ЦЕХА = ANY (
         SELECT c.НОМЕР_ЦЕХА
         FROM CWПРОИЗВОДСТВ_ЦЕХ c
         MINUS
         SELECT l.m
         FROM
           (SELECT
              COUNT(DISTINCT k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ) n,
              c.НОМЕР_ЦЕХА                                 m
            FROM CWПРОИЗВОДСТВ_ЦЕХ c
              LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
                ON k.НОМЕР_ЦЕХА = c.НОМЕР_ЦЕХА
            GROUP BY c.НОМЕР_ЦЕХА) l
           JOIN (SELECT
                   COUNT(DISTINCT k.НАЗВАНИЕ_КАТЕГОРИИ_ИЗДЕЛИЯ) n,
                   c.НОМЕР_ЦЕХА                                 m
                 FROM CWПРОИЗВОДСТВ_ЦЕХ C
                   LEFT JOIN CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
                     ON k.НОМЕР_ЦЕХА = C.НОМЕР_ЦЕХА
                 GROUP BY c.НОМЕР_ЦЕХА) r
             ON l.n < r.n)) t;
