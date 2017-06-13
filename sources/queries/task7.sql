DEFINE manufacture_id=0;
DEFINE sector_id=1;

SELECT
  s.ФАМИЛИЯ_СОТРУДНИКА,
  s.ИМЯ_СОТРУДНИКА,
  s.ОТЧЕСТВО_СОТРУДНИКА,
  b.НОМЕР_БРИГАДЫ
FROM CWРАБОТЫ t
  INNER JOIN CWБРИГАДА b
    ON t.НОМЕР_БРИГАДЫ = b.НОМЕР_БРИГАДЫ
  INNER JOIN CWРУКОВОДИТЕЛЬ r
    ON r.КОД_ОТВЕТСТВ = b.МАСТЕР
  INNER JOIN CWСОТРУДНИК s
    ON r.КОД_СОТРУДНИКА = s.КОД_СОТРУДНИКА


WHERE t.НОМЕР_ЦЕХА = 'П321' AND t.НОМЕР_УЧАСТКА = 2;
