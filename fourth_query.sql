SELECT
  c.НОМЕР_ЦЕХА || '' AS "НОМР ЦЕХА",
  c.НАЗВАНИЕ_ЦЕХА,
  u.НОМЕР_УЧАСТКА || '' AS "НОМЕР УЧАСТКА",
  u.НАЗВАНИЕ_УЧАСТКА,
  s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ИМЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS "Начальник участка"

FROM ЦЕХ c
  JOIN УЧАСТОК u
    ON c.НОМЕР_ЦЕХА = u.НОМЕР_ЦЕХА
  JOIN СОТРУДНИК s
    ON u.НОМЕР_ДОГОВОРА = s.НОМЕР_ДОГОВОРА
UNION ALL
SELECT
  'Всего цехов на предприятии:',
  '' || COUNT(НОМЕР_УЧАСТКА),
  '',
  '',
  ''
FROM УЧАСТОК;



