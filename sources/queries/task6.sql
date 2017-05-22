DEFINE manufacture_id=0;
DEFINE sector_id=1;

SELECT
  t.fio AS "ФИО",
  t.nb  AS "Номер бригады",
  t.nu  AS "Номер участка",
  t.nc  AS "Номер цеха"
FROM (
       SELECT
         DISTINCT
         s.ФАМИЛИЯ_СОТРУДНИКА || ' ' || s.ИМЯ_СОТРУДНИКА || ' ' || s.ОТЧЕСТВО_СОТРУДНИКА AS fio,
         b.ИД_БРИГАДЫ                                                                    AS nb,
         &sector_id                                                                      AS nu,
         &manufacture_id                                                                 AS nc,
         s.НОМЕР_ДОГОВОРА
       FROM CWУЧАСТОК u
         JOIN CWМАСТЕР_НАЧАЛЬНИК n
           ON n.ДОГОВОР_НАЧ_УЧ = u.НОМЕР_ДОГОВОРА
         JOIN CWМАСТЕР_БРИГАДА m
           ON m.НОМЕР_ДОГОВОРА = n.ДОГОВОР_МАСТЕР
         JOIN CWБРИГАДА b
           ON b.ИД_БРИГАДЫ = m.ИД_БРИГАДЫ
         JOIN CWРАБОЧИЙ r
           ON r.ИД_БРИГАДЫ = b.ИД_БРИГАДЫ
         JOIN CWСОТРУДНИК s
           ON s.НОМЕР_ДОГОВОРА = r.НОМЕР_ДОГОВОРА

       WHERE u.НОМЕР_УЧАСТКА = &sector_id
             AND u.НОМЕР_ЦЕХА = &manufacture_id
       ORDER BY b.ИД_БРИГАДЫ ASC) t;
