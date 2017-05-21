DEFINE manufacture_id=0;
DEFINE sector_id=1;

SELECT DISTINCT
  s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ИМЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS "ФИО",
  b.ИД_БРИГАДЫ                                                                    AS "Номер бригады",
  &sector_id                                                                      AS "Номер участка",
  &manufacture_id                                                                 AS "Номер цеха"
FROM УЧАСТОК u
  JOIN МАСТЕР_НАЧАЛЬНИК n
    ON n.ДОГОВОР_НАЧ_УЧ = u.НОМЕР_ДОГОВОРА
  JOIN МАСТЕР_БРИГАДА m
    ON m.НОМЕР_ДОГОВОРА = n.ДОГОВОР_МАСТЕР
  JOIN БРИГАДА b
    ON b.ИД_БРИГАДЫ = m.ИД_БРИГАДЫ
  JOIN РАБОЧИЙ r
    ON r.ИД_БРИГАДЫ = b.ИД_БРИГАДЫ
  JOIN СОТРУДНИК s
    ON s.НОМЕР_ДОГОВОРА = r.НОМЕР_ДОГОВОРА

WHERE u.НОМЕР_УЧАСТКА = &sector_id
      AND u.НОМЕР_ЦЕХА = &manufacture_id
ORDER BY b.ИД_БРИГАДЫ ASC;
