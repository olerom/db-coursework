SELECT
  u.НАЗВАНИЕ_УЧАСТКА,
  u.НОМЕР_ЦЕХА,
  u.НОМЕР_УЧАСТКА,
  s.ИМЯ_СОТРУДНИКА || ' ' || s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS "Начальник участка"
FROM CWУЧАСТОК u
  INNER JOIN CWРУКОВОДИТЕЛЬ r
    ON u.НАЧАЛЬНИК_УЧАСТКА = r.КОД_ОТВЕТСТВ
  INNER JOIN CWСОТРУДНИК s
    ON s.КОД_СОТРУДНИКА = r.КОД_СОТРУДНИКА
UNION ALL
SELECT
  'Всего участков: ' || COUNT(*),
  NULL,
  NULL,
  NULL
FROM CWУЧАСТОК;

