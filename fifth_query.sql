DEFINE id_item=0;

SELECT k.НАЗВАНИЕ_УЧАСТКА
FROM ВИД_ИЗДЕЛИЯ v
  JOIN УЧАСТОК_КАТЕГОРИЯ_ИЗДЕЛИЯ u
    ON v.ИД_КАТЕГОРИИ_ИЗДЕЛИЯ = u.ИД_КАТЕГОРИИ_ИЗДЕЛИЯ
  JOIN УЧАСТОК k
    ON u.НОМЕР_УЧАСТКА = k.НОМЕР_УЧАСТКА

WHERE v.ИД_КАТЕГОРИИ_ИЗДЕЛИЯ = 0;
