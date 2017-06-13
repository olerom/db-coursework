SELECT
  kt       AS "Категори",
  vn       AS "Вид",
  COUNT(*) AS "Кол-во"
FROM (
  SELECT
    k.ТИП_КАТЕГОРИИ         kt,
    v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ vn,
    z.НОМЕР_ЭКЗЕМПЛЯРА      ne
  FROM CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
    INNER JOIN CWВИД_ИЗДЕЛИЯ v
      ON v.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ = k.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ
    INNER JOIN CWЭКЗЕМПЛЯР_ИЗДЕЛИЯ e
      ON e.НОМЕР_ВИДА_ИЗДЕЛИЯ = v.НОМЕР_ВИДА_ИЗДЕЛИЯ
    INNER JOIN CWЖУРНАЛ z
      ON z.НОМЕР_ЭКЗЕМПЛЯРА = e.НОМЕР_ЭКЗЕМПЛЯРА
  WHERE z.ЖИЗНЕННЫЙ_ЦИКЛ = 'Сборка'
        AND z.КОНЕЦ <= to_date('2038/07/22', 'yyyy/mm/dd')
        AND z.НАЧАЛО >= to_date('2010/07/22', 'yyyy/mm/dd')
  GROUP BY k.ТИП_КАТЕГОРИИ, v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ, z.НОМЕР_ЭКЗЕМПЛЯРА)
GROUP BY kt, vn
UNION ALL
SELECT
  'Всего собрано дата - дата',
  '',
  COUNT(*)
FROM (
  SELECT
    k.ТИП_КАТЕГОРИИ         kt,
    v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ vn,
    z.НОМЕР_ЭКЗЕМПЛЯРА      ne
  FROM CWКАТЕГОРИЯ_ИЗДЕЛИЯ k
    INNER JOIN CWВИД_ИЗДЕЛИЯ v
      ON v.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ = k.НОМЕР_КАТЕГОРИИ_ИЗДЕЛИЯ
    INNER JOIN CWЭКЗЕМПЛЯР_ИЗДЕЛИЯ e
      ON e.НОМЕР_ВИДА_ИЗДЕЛИЯ = v.НОМЕР_ВИДА_ИЗДЕЛИЯ
    INNER JOIN CWЖУРНАЛ z
      ON z.НОМЕР_ЭКЗЕМПЛЯРА = e.НОМЕР_ЭКЗЕМПЛЯРА
  WHERE z.ЖИЗНЕННЫЙ_ЦИКЛ = 'Сборка'
        AND z.КОНЕЦ <= to_date('2038/07/22', 'yyyy/mm/dd')
        AND z.НАЧАЛО >= to_date('2010/07/22', 'yyyy/mm/dd')
  GROUP BY k.ТИП_КАТЕГОРИИ, v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ, z.НОМЕР_ЭКЗЕМПЛЯРА);
