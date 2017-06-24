DEFINE manufactory='П321';
DEFINE sector=2;

SELECT
  s.ИМЯ_СОТРУДНИКА || ' ' || s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS "ФИО",
  r.НОМЕР_БРИГАДЫ                                                                 AS "Номер бригады",
  &sector AS "Номер участка",
  '&manufactory' as "Номер цеха"
FROM CWСОТРУДНИК s
  INNER JOIN CWРАБОЧИЙ r
    ON s.КОД_СОТРУДНИКА = r.КОД_СОТРУДНИКА
WHERE r.НОМЕР_БРИГАДЫ = ANY (
  SELECT
    DISTINCT i.НОМЕР_БРИГАДЫ
  FROM CWИЗГОТОВКА i
    INNER JOIN CWУЧАСТОК u
      ON i.КОД_УЧАСТКА = u.КОД_УЧАСТКА
  WHERE u.НОМЕР_ЦЕХА = '&manufactory' AND u.НОМЕР_УЧАСТКА = &sector
  UNION
  SELECT
    DISTINCT s.НОМЕР_БРИГАДЫ
  FROM CWCБОРКА s
    INNER JOIN CWУЧАСТОК u
      ON s.КОД_УЧАСТКА = u.КОД_УЧАСТКА
  WHERE u.НОМЕР_ЦЕХА = '&manufactory' AND u.НОМЕР_УЧАСТКА = &sector)
ORDER BY r.НОМЕР_БРИГАДЫ;
