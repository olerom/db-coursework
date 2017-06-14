DEFINE manufactory='П321';
DEFINE sector=2;

SELECT
  s.ФАМИЛИЯ_СОТРУДНИКА,
  s.ИМЯ_СОТРУДНИКА,
  s.ОТЧЕСТВО_СОТРУДНИКА,
  b.НОМЕР_БРИГАДЫ
FROM CWРАБОТЫ t
  INNER JOIN CWУЧАСТОК u
    ON t.КОД_УЧАСТКА = u.КОД_УЧАСТКА
  INNER JOIN CWБРИГАДА b
    ON t.НОМЕР_БРИГАДЫ = b.НОМЕР_БРИГАДЫ
  INNER JOIN CWРУКОВОДИТЕЛЬ r
    ON r.КОД_ОТВЕТСТВ = b.МАСТЕР
  INNER JOIN CWСОТРУДНИК s
    ON r.КОД_СОТРУДНИКА = s.КОД_СОТРУДНИКА

WHERE u.НОМЕР_ЦЕХА = '&manufactory' AND u.НОМЕР_УЧАСТКА = &sector;
