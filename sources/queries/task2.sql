DEFINE start_time = to_date('2010/07/22', 'yyyy/mm/dd');
DEFINE end_time = to_date('2038/07/22', 'yyyy/mm/dd');

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
  WHERE z.ЭТАП_ЖИЗНЕННОГО_ЦИКЛА = 'Сборка'
        AND z.КОНЕЦ <= &end_time
        AND z.НАЧАЛО >= &start_time
  GROUP BY k.ТИП_КАТЕГОРИИ, v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ, z.НОМЕР_ЭКЗЕМПЛЯРА)
GROUP BY kt, vn
UNION ALL
SELECT
  'Всего собрано ' || to_char(&start_time, 'dd.mm.yyyy') || '-' || to_char(&end_time
  , 'dd.mm.yyyy'),
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
  WHERE z.ЭТАП_ЖИЗНЕННОГО_ЦИКЛА = 'Сборка'
        AND z.КОНЕЦ <= &end_time
        AND z.НАЧАЛО >= &start_time
  GROUP BY k.ТИП_КАТЕГОРИИ, v.НАЗВАНИЕ_ВИДА_ИЗДЕЛИЯ, z.НОМЕР_ЭКЗЕМПЛЯРА);
