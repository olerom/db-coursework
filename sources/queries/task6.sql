DEFINE manufactory='П321';
DEFINE sector=2;

SELECT
  s.ИМЯ_СОТРУДНИКА || ' ' || s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS "ФИО",
  r.НОМЕР_БРИГАДЫ,
  u.НОМЕР_УЧАСТКА,
  u.НОМЕР_ЦЕХА

FROM CWРАБОТЫ t
  INNER JOIN CWУЧАСТОК u
    ON t.КОД_УЧАСТКА = u.КОД_УЧАСТКА
  INNER JOIN CWБРИГАДА b
    ON b.НОМЕР_БРИГАДЫ = t.НОМЕР_БРИГАДЫ
  INNER JOIN CWРАБОЧИЙ r
    ON b.НОМЕР_БРИГАДЫ = r.НОМЕР_БРИГАДЫ
  INNER JOIN CWСОТРУДНИК s
    ON s.КОД_СОТРУДНИКА = r.КОД_СОТРУДНИКА

WHERE u.НОМЕР_ЦЕХА = '&manufactory' AND u.НОМЕР_УЧАСТКА = &sector
ORDER BY r.НОМЕР_БРИГАДЫ;
