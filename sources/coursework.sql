DROP TABLE CWИнженер CASCADE CONSTRAINTS PURGE;

DROP TABLE CWТехник CASCADE CONSTRAINTS PURGE;

DROP TABLE CWСборщик CASCADE CONSTRAINTS PURGE;

DROP TABLE CWТокарь CASCADE CONSTRAINTS PURGE;

DROP TABLE CWСлесарь CASCADE CONSTRAINTS PURGE;

DROP TABLE CWВспомогательный_цех CASCADE CONSTRAINTS PURGE;

DROP TABLE CWМотоциклы CASCADE CONSTRAINTS PURGE;

DROP TABLE CWАвтобусы CASCADE CONSTRAINTS PURGE;

DROP TABLE CWГрузовые_автомобили CASCADE CONSTRAINTS PURGE;

DROP TABLE CWИзготовка CASCADE CONSTRAINTS PURGE;

DROP TABLE CWИзготовительный_участок CASCADE CONSTRAINTS PURGE;

DROP TABLE CWЖурнал CASCADE CONSTRAINTS PURGE;

DROP TABLE CWЭкземпляр_изделия CASCADE CONSTRAINTS PURGE;

DROP TABLE CWВид_изделия CASCADE CONSTRAINTS PURGE;

DROP VIEW Представление CASCADE CONSTRAINTS;

DROP TABLE CWCборка CASCADE CONSTRAINTS PURGE;

DROP TABLE CWРабочий CASCADE CONSTRAINTS PURGE;

DROP TABLE CWБригада CASCADE CONSTRAINTS PURGE;

DROP TABLE CWСборочный_участок CASCADE CONSTRAINTS PURGE;

DROP TABLE CWУчасток CASCADE CONSTRAINTS PURGE;

DROP TABLE CWКатегория_изделия CASCADE CONSTRAINTS PURGE;

DROP TABLE CWПроизводственный_цех CASCADE CONSTRAINTS PURGE;

DROP TABLE CWЦех CASCADE CONSTRAINTS PURGE;

DROP TABLE CWРуководитель CASCADE CONSTRAINTS PURGE;

DROP TABLE CWИТП CASCADE CONSTRAINTS PURGE;

DROP TABLE CWСотрудник CASCADE CONSTRAINTS PURGE;

CREATE TABLE CWCборка
(
  Код_участка     VARCHAR2(16) NOT NULL,
  Номер_бригады   NUMBER(3, 0) NOT NULL,
  Категорский_цех VARCHAR2(13) NOT NULL
);

CREATE UNIQUE INDEX XPKCборка_изделия
  ON CWCборка
  (Категорский_цех ASC);

ALTER TABLE CWCборка
  ADD CONSTRAINT XPKCборка_изделия PRIMARY KEY (Категорский_цех);

ALTER TABLE CWCборка
  ADD CONSTRAINT Работы_соотв_451714171 CHECK (SUBSTR(Код_участка, 1, 4) = SUBSTR(Категорский_цех, 1, 4));

CREATE INDEX XIE1Cборка_изделия
  ON CWCборка
  (Код_участка ASC);

CREATE INDEX XIE2Cборка_изделия
  ON CWCборка
  (Номер_бригады ASC);

CREATE TABLE CWАвтобусы
(
  Вместимость NUMBER(4, 0) NOT NULL,
  Код_вида    VARCHAR2(12) NOT NULL
);

CREATE UNIQUE INDEX XPKАвтобусы
  ON CWАвтобусы
  (Код_вида ASC);

ALTER TABLE CWАвтобусы
  ADD CONSTRAINT XPKАвтобусы PRIMARY KEY (Код_вида);

ALTER TABLE CWАвтобусы
  ADD CONSTRAINT Автобусы_соотв_65300351 CHECK (SUBSTR(Код_вида, 1, 8) = 'Автобусы');

ALTER TABLE CWАвтобусы
  MODIFY Вместимость CONSTRAINT Полож_965469913 CHECK (Вместимость >= 0);

CREATE TABLE CWБригада
(
  Номер_бригады    NUMBER(3, 0) NOT NULL,
  Название_бригады VARCHAR2(14) NOT NULL,
  Бригадир         VARCHAR2(14) NOT NULL,
  Мастер           VARCHAR2(21) NOT NULL
);

CREATE UNIQUE INDEX XPKБригада
  ON CWБригада
  (Номер_бригады ASC);

ALTER TABLE CWБригада
  ADD CONSTRAINT XPKБригада PRIMARY KEY (Номер_бригады);

CREATE UNIQUE INDEX XAK2Бригада
  ON CWБригада
  (Название_бригады ASC);

ALTER TABLE CWБригада
  ADD CONSTRAINT XAK2Бригада UNIQUE (Название_бригады);

CREATE UNIQUE INDEX XAK1Бригада
  ON CWБригада
  (Бригадир ASC);

ALTER TABLE CWБригада
  ADD CONSTRAINT Мастер_бриг_соотв_1274688691 CHECK (SUBSTR(Мастер, 1, 6) = 'Мастер');

ALTER TABLE CWБригада
  MODIFY Номер_бригады CONSTRAINT Номер_бригады_1200055689 CHECK (Номер_бригады >= 1);

CREATE INDEX XIE3Бригада
  ON CWБригада
  (Мастер ASC);

CREATE TABLE CWВид_изделия
(
  Номер_вида_изделия    VARCHAR2(3)  NOT NULL,
  Код_вида              VARCHAR2(12) NOT NULL,
  Тип_категории         VARCHAR2(9)  NOT NULL,
  Название_вида_изделия VARCHAR2(18) NOT NULL
);

CREATE UNIQUE INDEX XPKКатегория_изделия
  ON CWВид_изделия
  (Номер_вида_изделия ASC);

ALTER TABLE CWВид_изделия
  ADD CONSTRAINT XPKКатегория_изделия PRIMARY KEY (Номер_вида_изделия);

CREATE UNIQUE INDEX XAK2Категория_изделия
  ON CWВид_изделия
  (Код_вида ASC);

ALTER TABLE CWВид_изделия
  ADD CONSTRAINT XAK2Категория_изделия UNIQUE (Код_вида);

CREATE UNIQUE INDEX XAK3Категория_изделия
  ON CWВид_изделия
  (Название_вида_изделия ASC);

ALTER TABLE CWВид_изделия
  ADD CONSTRAINT XAK3Категория_изделия UNIQUE (Название_вида_изделия);

ALTER TABLE CWВид_изделия
  ADD CONSTRAINT Кат_изд_соотв_1333772069 CHECK (Тип_категории || Номер_вида_изделия = Код_вида);

CREATE INDEX XIE1Категория_изделия
  ON CWВид_изделия
  (Тип_категории ASC);

CREATE TABLE CWВспомогательный_цех
(
  Тип_вспомогательного_цеха VARCHAR2(13) NOT NULL,
  Номер_цеха                VARCHAR2(4)  NOT NULL
);

CREATE UNIQUE INDEX XPKВспомогательный_цех
  ON CWВспомогательный_цех
  (Номер_цеха ASC);

ALTER TABLE CWВспомогательный_цех
  ADD CONSTRAINT XPKВспомогательный_цех PRIMARY KEY (Номер_цеха);

ALTER TABLE CWВспомогательный_цех
  ADD CONSTRAINT Вспомагат_соотв_1592414896 CHECK (SUBSTR(Номер_цеха, 1, 1) = 'В'
);

ALTER TABLE CWВспомогательный_цех
  MODIFY Тип_вспомогательного_цеха CONSTRAINT Вспомогат_цех_1656618676 CHECK (Тип_вспомогательного_цеха IN
                                                                              ('ремонтный', 'тестировочный'));

CREATE TABLE CWГрузовые_автомобили
(
  Грузоподъемность NUMBER(5, 0) NOT NULL,
  Код_вида         VARCHAR2(12) NOT NULL
);

CREATE UNIQUE INDEX XPKГрузовые_автомобили
  ON CWГрузовые_автомобили
  (Код_вида ASC);

ALTER TABLE CWГрузовые_автомобили
  ADD CONSTRAINT XPKГрузовые_автомобили PRIMARY KEY (Код_вида);

ALTER TABLE CWГрузовые_автомобили
  ADD CONSTRAINT Грузовые_соотв_1823080338 CHECK (SUBSTR(Код_вида, 1, 8) = 'Грузовые');

ALTER TABLE CWГрузовые_автомобили
  MODIFY Грузоподъемность CONSTRAINT Полож_1841523636 CHECK (Грузоподъемность >= 0);

CREATE TABLE CWЖурнал
(
  Начало                DATE         NOT NULL,
  Конец                 DATE         NULL,
  Этап_жизненного_цикла VARCHAR2(18) NOT NULL,
  Номер_экземпляра      NUMBER(6, 0) NOT NULL
);

CREATE UNIQUE INDEX XPKЖурнал
  ON CWЖурнал
  (Начало ASC, Номер_экземпляра ASC);

ALTER TABLE CWЖурнал
  ADD CONSTRAINT XPKЖурнал PRIMARY KEY (Начало, Номер_экземпляра);

ALTER TABLE CWЖурнал
  ADD CONSTRAINT Соответствие_дат_1004688284 CHECK (Начало < Конец);

ALTER TABLE CWЖурнал
  MODIFY Этап_жизненного_цикла CONSTRAINT Жизненный_цикл_1107733670 CHECK (Этап_жизненного_цикла IN
                                                                           ('Сборка', 'Передача дилеру', 'Гарантийный ремонт', 'Тестирование'));

CREATE INDEX XIE1Журнал
  ON CWЖурнал
  (Номер_экземпляра ASC);

CREATE TABLE CWИТП
(
  Код_сотрудника VARCHAR2(14) NOT NULL,
  Должность_ИТП  VARCHAR2(7)  NOT NULL
);

CREATE UNIQUE INDEX XPKИТП
  ON CWИТП
  (Код_сотрудника ASC);

ALTER TABLE CWИТП
  ADD CONSTRAINT XPKИТП PRIMARY KEY (Код_сотрудника);

ALTER TABLE CWИТП
  ADD CONSTRAINT ИТП_соотв_1970182668 CHECK (SUBSTR(Код_сотрудника, 1, 1) = 'И'
                                             AND SUBSTR(Код_сотрудника, 2, LENGTH(Должность_ИТП)) = Должность_ИТП);

CREATE TABLE CWИзготовительный_участок
(
  Код_участка   VARCHAR2(16) NOT NULL,
  Часть_изделия VARCHAR2(16) NOT NULL
);

CREATE UNIQUE INDEX XPKИзготовительный_участок
  ON CWИзготовительный_участок
  (Код_участка ASC);

ALTER TABLE CWИзготовительный_участок
  ADD CONSTRAINT XPKИзготовительный_участок PRIMARY KEY (Код_участка);

ALTER TABLE CWИзготовительный_участок
  ADD CONSTRAINT Изготов_участок_333364944 CHECK (SUBSTR(Код_участка, 5, 9) = 'изготовка');

ALTER TABLE CWИзготовительный_участок
  MODIFY Код_участка CONSTRAINT Изготов_участок_2036339226 CHECK (SUBSTR(Код_участка, 5, 9) = 'изготовка');

CREATE TABLE CWИзготовка
(
  Категорский_цех VARCHAR2(13) NOT NULL,
  Код_участка     VARCHAR2(16) NOT NULL,
  Номер_бригады   NUMBER(3, 0) NOT NULL
);

CREATE UNIQUE INDEX XPKРаботы
  ON CWИзготовка
  (Категорский_цех ASC, Код_участка ASC);

ALTER TABLE CWИзготовка
  ADD CONSTRAINT XPKРаботы PRIMARY KEY (Категорский_цех, Код_участка);

ALTER TABLE CWИзготовка
  ADD CONSTRAINT Работы_соотв_1982503329 CHECK (SUBSTR(Код_участка, 1, 4) = SUBSTR(Категорский_цех, 1, 4));

CREATE INDEX XIE1Работы
  ON CWИзготовка
  (Код_участка ASC);

CREATE INDEX XIE2Работы
  ON CWИзготовка
  (Номер_бригады ASC);

CREATE TABLE CWИнженер
(
  Специализация_инженера VARCHAR2(16) NOT NULL,
  Код_сотрудника         VARCHAR2(14) NOT NULL
);

CREATE UNIQUE INDEX XPKИнженер
  ON CWИнженер
  (Код_сотрудника ASC);

ALTER TABLE CWИнженер
  ADD CONSTRAINT XPKИнженер PRIMARY KEY (Код_сотрудника);

ALTER TABLE CWИнженер
  ADD CONSTRAINT Инженер_соотв_2040157128 CHECK (SUBSTR(Код_сотрудника, 2, 7) = 'Инженер');

ALTER TABLE CWИнженер
  MODIFY Специализация_инженера CONSTRAINT Специализация_инжен_1462496655 CHECK (Специализация_инженера IN
                                                                                 ('проектирование', 'прототипирование'));

CREATE TABLE CWКатегория_изделия
(
  Тип_категории   VARCHAR2(9)  NOT NULL,
  Номер_цеха      VARCHAR2(4)  NOT NULL,
  Категорский_цех VARCHAR2(13) NOT NULL
);

CREATE UNIQUE INDEX XPKТиа_категории
  ON CWКатегория_изделия
  (Тип_категории ASC);

ALTER TABLE CWКатегория_изделия
  ADD CONSTRAINT XPKТиа_категории PRIMARY KEY (Тип_категории);

CREATE UNIQUE INDEX XAK1Тиа_категории
  ON CWКатегория_изделия
  (Категорский_цех ASC);

ALTER TABLE CWКатегория_изделия
  ADD CONSTRAINT XAK1Тиа_категории UNIQUE (Категорский_цех);

ALTER TABLE CWКатегория_изделия
  ADD CONSTRAINT Кат_цех_220740898 CHECK (Номер_цеха || Тип_категории = Категорский_цех);

ALTER TABLE CWКатегория_изделия
  MODIFY Тип_категории CONSTRAINT Тип_категории_2087399618 CHECK (Тип_категории IN
                                                                  ('Мотоциклы', 'Автобусы', 'Грузовые'));

CREATE INDEX XIE1Тиа_категории
  ON CWКатегория_изделия
  (Номер_цеха ASC);

CREATE TABLE CWМотоциклы
(
  Колво_тактов_мотора NUMBER(1, 0) NOT NULL,
  Код_вида            VARCHAR2(12) NOT NULL
);

CREATE UNIQUE INDEX XPKМотоциклы
  ON CWМотоциклы
  (Код_вида ASC);

ALTER TABLE CWМотоциклы
  ADD CONSTRAINT XPKМотоциклы PRIMARY KEY (Код_вида);

ALTER TABLE CWМотоциклы
  ADD CONSTRAINT Мотоциклы_соотв_1987687452 CHECK (SUBSTR(Код_вида, 1, 9) = 'Мотоциклы');

ALTER TABLE CWМотоциклы
  MODIFY Колво_тактов_мотора CONSTRAINT Полож_1171472626 CHECK (Колво_тактов_мотора >= 0);

CREATE TABLE CWПроизводственный_цех
(
  Номер_цеха           VARCHAR2(4)  NOT NULL,
  Спонсор_производства VARCHAR2(16) NULL
);

CREATE UNIQUE INDEX XPKПроизводственный_цех
  ON CWПроизводственный_цех
  (Номер_цеха ASC);

ALTER TABLE CWПроизводственный_цех
  ADD CONSTRAINT XPKПроизводственный_цех PRIMARY KEY (Номер_цеха);

ALTER TABLE CWПроизводственный_цех
  ADD CONSTRAINT Производств_соотв_1637157749 CHECK (SUBSTR(Номер_цеха, 1, 1) = 'П'
);

CREATE TABLE CWРабочий
(
  Номер_бригады      NUMBER(3, 0) NULL,
  Код_сотрудника     VARCHAR2(14) NOT NULL,
  Должность_рабочего VARCHAR2(7)  NOT NULL
);

CREATE UNIQUE INDEX XPKРабочий
  ON CWРабочий
  (Код_сотрудника ASC);

ALTER TABLE CWРабочий
  ADD CONSTRAINT XPKРабочий PRIMARY KEY (Код_сотрудника);

ALTER TABLE CWРабочий
  ADD CONSTRAINT Рабочий_соотв_2122034973 CHECK (SUBSTR(Код_сотрудника, 1, 1) = 'Р'
                                                 AND SUBSTR(Код_сотрудника, 2, LENGTH(Должность_рабочего)) =
                                                     Должность_рабочего);

ALTER TABLE CWРабочий
  MODIFY Номер_бригады CONSTRAINT Номер_бригады_1401248355 CHECK (Номер_бригады >= 1);

CREATE INDEX XIE1Рабочий
  ON CWРабочий
  (Номер_бригады ASC);

CREATE TABLE CWРуководитель
(
  Код_сотрудника  VARCHAR2(14) NOT NULL,
  Ответственность VARCHAR2(7)  NOT NULL,
  Код_ответств    VARCHAR2(21) NOT NULL
);

CREATE UNIQUE INDEX XPKРуководитель
  ON CWРуководитель
  (Код_сотрудника ASC);

ALTER TABLE CWРуководитель
  ADD CONSTRAINT XPKРуководитель PRIMARY KEY (Код_сотрудника);

CREATE UNIQUE INDEX XAK1Руководитель
  ON CWРуководитель
  (Код_ответств ASC);

ALTER TABLE CWРуководитель
  ADD CONSTRAINT XAK1Руководитель UNIQUE (Код_ответств);

ALTER TABLE CWРуководитель
  ADD CONSTRAINT Код_ответсв_1918082216 CHECK (Ответственность || Код_сотрудника = Код_ответств);

ALTER TABLE CWРуководитель
  MODIFY Ответственность CONSTRAINT Руковолитель_отвественность CHECK (Ответственность IN ('Участок', 'Цех', 'Мастер'));

CREATE TABLE CWСборочный_участок
(
  Код_участка     VARCHAR2(16) NOT NULL,
  Колво_сбор_конв NUMBER(2, 0) NOT NULL
);

CREATE UNIQUE INDEX XPKСборочный_участок
  ON CWСборочный_участок
  (Код_участка ASC);

ALTER TABLE CWСборочный_участок
  ADD CONSTRAINT XPKСборочный_участок PRIMARY KEY (Код_участка);

ALTER TABLE CWСборочный_участок
  ADD CONSTRAINT Сборочн_соотв_805914176 CHECK (SUBSTR(Код_участка, 5, 6) = 'сборка');

ALTER TABLE CWСборочный_участок
  MODIFY Код_участка CONSTRAINT Сборочн_соотв_1499196068 CHECK (SUBSTR(Код_участка, 5, 6) = 'сборка');

ALTER TABLE CWСборочный_участок
  MODIFY Колво_сбор_конв CONSTRAINT Полож_1306510629 CHECK (Колво_сбор_конв >= 0);

CREATE TABLE CWСборщик
(
  Специализация_сборщика VARCHAR2(9)  NOT NULL,
  Код_сотрудника         VARCHAR2(14) NOT NULL
);

CREATE UNIQUE INDEX XPKСбощик
  ON CWСборщик
  (Код_сотрудника ASC);

ALTER TABLE CWСборщик
  ADD CONSTRAINT XPKСбощик PRIMARY KEY (Код_сотрудника);

ALTER TABLE CWСборщик
  ADD CONSTRAINT Сборщик_соотв_2053938968 CHECK (SUBSTR(Код_сотрудника, 2, 7) = 'Сборщик');

ALTER TABLE CWСборщик
  MODIFY Специализация_сборщика CONSTRAINT Сбрщик_спец_1691720949 CHECK (Специализация_сборщика IN
                                                                         ('двигатель', 'подвеска', 'кузов'));

CREATE TABLE CWСлесарь
(
  Разряд_слесаря NUMBER(1, 0) NOT NULL,
  Код_сотрудника VARCHAR2(14) NOT NULL
);

CREATE UNIQUE INDEX XPKСлесарь
  ON CWСлесарь
  (Код_сотрудника ASC);

ALTER TABLE CWСлесарь
  ADD CONSTRAINT XPKСлесарь PRIMARY KEY (Код_сотрудника);

ALTER TABLE CWСлесарь
  ADD CONSTRAINT Слесарь_соотв_2125359824 CHECK (SUBSTR(Код_сотрудника, 2, 7) = 'Слесарь');

ALTER TABLE CWСлесарь
  MODIFY Разряд_слесаря CONSTRAINT Слесарь_разряд_1046431093 CHECK (Разряд_слесаря BETWEEN 1 AND 6);

CREATE TABLE CWСотрудник
(
  Номер_договора       VARCHAR2(6)  NOT NULL,
  Имя_сотрудника       VARCHAR2(14) NOT NULL,
  Фамилия_сотрудника   VARCHAR2(16) NOT NULL,
  Отчество_сотрудника  VARCHAR2(16) NULL,
  Тип_сотрудника       VARCHAR2(1)  NOT NULL,
  Дата_рождения        DATE         NULL,
  Код_сотрудника       VARCHAR2(14) NOT NULL,
  Должность_сотрудника VARCHAR2(7)  NULL
);

CREATE UNIQUE INDEX XPKСотрудник
  ON CWСотрудник
  (Номер_договора ASC);

ALTER TABLE CWСотрудник
  ADD CONSTRAINT XPKСотрудник PRIMARY KEY (Номер_договора);

CREATE UNIQUE INDEX XAK1Сотрудник
  ON CWСотрудник
  (Код_сотрудника ASC);

ALTER TABLE CWСотрудник
  ADD CONSTRAINT XAK1Сотрудник UNIQUE (Код_сотрудника);

ALTER TABLE CWСотрудник
  ADD CONSTRAINT Код_сотрудника_152408122 CHECK (Тип_сотрудника || Должность_сотрудника || Номер_договора =
                                                 Код_сотрудника);

ALTER TABLE CWСотрудник
  MODIFY Тип_сотрудника CONSTRAINT Тип_сотрудник_1488454748 CHECK (Тип_сотрудника IN ('Р', 'И'));

ALTER TABLE CWСотрудник
  MODIFY Должность_сотрудника CONSTRAINT Должность_сотрудника_195850548 CHECK (Должность_сотрудника IN
                                                                               ('Сборщик', 'Токарь', 'Слесарь', 'Техник', 'Инженер'));

ALTER TABLE CWСотрудник
  MODIFY Отчество_сотрудника DEFAULT 'Нет отчества';

CREATE TABLE CWТехник
(
  Специализация_техника VARCHAR2(7)  NOT NULL,
  Код_сотрудника        VARCHAR2(14) NOT NULL
);

CREATE UNIQUE INDEX XPKТехник
  ON CWТехник
  (Код_сотрудника ASC);

ALTER TABLE CWТехник
  ADD CONSTRAINT XPKТехник PRIMARY KEY (Код_сотрудника);

ALTER TABLE CWТехник
  ADD CONSTRAINT Техник_соотв_469433198 CHECK (SUBSTR(Код_сотрудника, 2, 6) = 'Техник');

ALTER TABLE CWТехник
  MODIFY Специализация_техника CONSTRAINT Специализация_техни_1611615165 CHECK (Специализация_техника IN
                                                                                ('схемы', 'чертежи'));

CREATE TABLE CWТокарь
(
  Разряд_токаря  NUMBER(1, 0) NOT NULL,
  Код_сотрудника VARCHAR2(14) NOT NULL
);

CREATE UNIQUE INDEX XPKТокарь
  ON CWТокарь
  (Код_сотрудника ASC);

ALTER TABLE CWТокарь
  ADD CONSTRAINT XPKТокарь PRIMARY KEY (Код_сотрудника);

ALTER TABLE CWТокарь
  ADD CONSTRAINT Токарь_соотв_518848096 CHECK (SUBSTR(Код_сотрудника, 2, 6) = 'Токарь');

ALTER TABLE CWТокарь
  MODIFY Разряд_токаря CONSTRAINT Токарь_разряд_1073954959 CHECK (Разряд_токаря BETWEEN 1 AND 7);

CREATE TABLE CWУчасток
(
  Номер_участка     NUMBER(3, 0) NOT NULL,
  Начальник_участка VARCHAR2(21) NOT NULL,
  Тип_участка       VARCHAR2(9)  NOT NULL,
  Название_участка  VARCHAR2(13) NOT NULL,
  Код_участка       VARCHAR2(16) NOT NULL,
  Номер_цеха        VARCHAR2(4)  NOT NULL
);

CREATE UNIQUE INDEX XPKУчасток
  ON CWУчасток
  (Номер_участка ASC, Номер_цеха ASC);

ALTER TABLE CWУчасток
  ADD CONSTRAINT XPKУчасток PRIMARY KEY (Номер_участка, Номер_цеха);

CREATE UNIQUE INDEX XAK1Участок
  ON CWУчасток
  (Начальник_участка ASC);

ALTER TABLE CWУчасток
  ADD CONSTRAINT XAK1Участок UNIQUE (Начальник_участка);

CREATE UNIQUE INDEX XAK2Участок
  ON CWУчасток
  (Название_участка ASC);

ALTER TABLE CWУчасток
  ADD CONSTRAINT XAK2Участок UNIQUE (Название_участка);

CREATE UNIQUE INDEX XAK3Участок
  ON CWУчасток
  (Код_участка ASC);

ALTER TABLE CWУчасток
  ADD CONSTRAINT XAK3Участок UNIQUE (Код_участка);

ALTER TABLE CWУчасток
  ADD CONSTRAINT Участок_нач_соотв_2107159506 CHECK (SUBSTR(Начальник_участка, 1, 7) = 'Участок');

ALTER TABLE CWУчасток
  ADD CONSTRAINT Уч_цех_1191576499 CHECK (Номер_цеха || Тип_участка || Номер_участка = Код_участка);

ALTER TABLE CWУчасток
  MODIFY Тип_участка CONSTRAINT Тип_участка_367341758 CHECK (Тип_участка IN ('сборка', 'изготовка'));

CREATE INDEX XIE1Участок
  ON CWУчасток
  (Номер_цеха ASC);

CREATE TABLE CWЦех
(
  Номер_цеха     VARCHAR2(4)  NOT NULL,
  Начальник_цеха VARCHAR2(21) NOT NULL,
  Название_цеха  VARCHAR2(14) NOT NULL,
  Тип_цеха       VARCHAR2(1)  NOT NULL
);

CREATE UNIQUE INDEX XPKЦех
  ON CWЦех
  (Номер_цеха ASC);

ALTER TABLE CWЦех
  ADD CONSTRAINT XPKЦех PRIMARY KEY (Номер_цеха);

CREATE UNIQUE INDEX XAK2Цех
  ON CWЦех
  (Начальник_цеха ASC);

ALTER TABLE CWЦех
  ADD CONSTRAINT XAK2Цех UNIQUE (Начальник_цеха);

CREATE UNIQUE INDEX XAK3Цех
  ON CWЦех
  (Название_цеха ASC);

ALTER TABLE CWЦех
  ADD CONSTRAINT XAK3Цех UNIQUE (Название_цеха);

ALTER TABLE CWЦех
  ADD CONSTRAINT Цех_нач_соотв_1933448208 CHECK (SUBSTR(Начальник_цеха, 1, 3) = 'Цех');

ALTER TABLE CWЦех
  ADD CONSTRAINT Номер_цеха_905638907 CHECK ((SUBSTR(Номер_цеха, 1, 1) = 'П'
                                              OR SUBSTR(Номер_цеха, 1, 1) = 'В')
                                             AND LENGTH(Номер_цеха) = 4
                                             AND SUBSTR(Номер_цеха, 1, 1) = Тип_цеха
);

CREATE TABLE CWЭкземпляр_изделия
(
  Номер_экземпляра   NUMBER(6, 0) NOT NULL,
  Номер_вида_изделия VARCHAR2(3)  NOT NULL
);

CREATE UNIQUE INDEX XPKЭкземпляр_изделия
  ON CWЭкземпляр_изделия
  (Номер_экземпляра ASC);

ALTER TABLE CWЭкземпляр_изделия
  ADD CONSTRAINT XPKЭкземпляр_изделия PRIMARY KEY (Номер_экземпляра);

ALTER TABLE CWЭкземпляр_изделия
  MODIFY Номер_экземпляра CONSTRAINT Полож_264450153 CHECK (Номер_экземпляра >= 0);

CREATE INDEX XIE1Экземпляр_изделия
  ON CWЭкземпляр_изделия
  (Номер_вида_изделия ASC);

CREATE VIEW Представление ( Количество_участков, Номер_цеха, Номер_участка, Название_участка, Тип_участка, Фамилия_начальника, Имя_начальника, Отчество_начальника )
AS
  SELECT
    COUNT(u2.Название_участка),
    u1.Номер_цеха,
    u1.Номер_участка,
    u1.Название_участка,
    u1.Тип_участка,
    s.Фамилия_сотрудника,
    s.Имя_сотрудника,
    s.Отчество_сотрудника
  FROM CWУчасток u1, CWУчасток u2, CWРуководитель r, CWСотрудник s
  WHERE u1.Начальник_участка = r.Код_ответств AND s.Код_сотрудника = r.Код_сотрудника
  GROUP BY u1.Название_участка,
    u1.Номер_участка,
    u1.Номер_цеха,
    u1.Тип_участка,
    s.Фамилия_сотрудника,
    s.Имя_сотрудника,
    s.Отчество_сотрудника;

ALTER TABLE CWCборка
  ADD (CONSTRAINT R_83 FOREIGN KEY (Код_участка) REFERENCES CWСборочный_участок (Код_участка));

ALTER TABLE CWCборка
  ADD (CONSTRAINT R_84 FOREIGN KEY (Номер_бригады) REFERENCES CWБригада (Номер_бригады));

ALTER TABLE CWCборка
  ADD (CONSTRAINT R_82 FOREIGN KEY (Категорский_цех) REFERENCES CWКатегория_изделия (Категорский_цех));

ALTER TABLE CWАвтобусы
  ADD (CONSTRAINT O5 FOREIGN KEY (Код_вида) REFERENCES CWВид_изделия (Код_вида) ON DELETE CASCADE);

ALTER TABLE CWБригада
  ADD (CONSTRAINT R_13 FOREIGN KEY (Бригадир) REFERENCES CWРабочий (Код_сотрудника));

ALTER TABLE CWБригада
  ADD (CONSTRAINT R_56 FOREIGN KEY (Мастер) REFERENCES CWРуководитель (Код_ответств));

ALTER TABLE CWВид_изделия
  ADD (CONSTRAINT R_77 FOREIGN KEY (Тип_категории) REFERENCES CWКатегория_изделия (Тип_категории));

ALTER TABLE CWВспомогательный_цех
  ADD (CONSTRAINT O2 FOREIGN KEY (Номер_цеха) REFERENCES CWЦех (Номер_цеха) ON DELETE CASCADE);

ALTER TABLE CWГрузовые_автомобили
  ADD (CONSTRAINT O3 FOREIGN KEY (Код_вида) REFERENCES CWВид_изделия (Код_вида) ON DELETE CASCADE);

ALTER TABLE CWЖурнал
  ADD (CONSTRAINT R_64 FOREIGN KEY (Номер_экземпляра) REFERENCES CWЭкземпляр_изделия (Номер_экземпляра));

ALTER TABLE CWИТП
  ADD (CONSTRAINT O9 FOREIGN KEY (Код_сотрудника) REFERENCES CWСотрудник (Код_сотрудника));

ALTER TABLE CWИзготовительный_участок
  ADD (CONSTRAINT R_79 FOREIGN KEY (Код_участка) REFERENCES CWУчасток (Код_участка));

ALTER TABLE CWИзготовка
  ADD (CONSTRAINT R_75 FOREIGN KEY (Категорский_цех) REFERENCES CWКатегория_изделия (Категорский_цех));

ALTER TABLE CWИзготовка
  ADD (CONSTRAINT R_81 FOREIGN KEY (Код_участка) REFERENCES CWИзготовительный_участок (Код_участка));

ALTER TABLE CWИзготовка
  ADD (CONSTRAINT R_88 FOREIGN KEY (Номер_бригады) REFERENCES CWБригада (Номер_бригады));

ALTER TABLE CWИнженер
  ADD (CONSTRAINT O10 FOREIGN KEY (Код_сотрудника) REFERENCES CWИТП (Код_сотрудника) ON DELETE CASCADE);

ALTER TABLE CWКатегория_изделия
  ADD (CONSTRAINT R_74 FOREIGN KEY (Номер_цеха) REFERENCES CWПроизводственный_цех (Номер_цеха));

ALTER TABLE CWМотоциклы
  ADD (CONSTRAINT O6 FOREIGN KEY (Код_вида) REFERENCES CWВид_изделия (Код_вида) ON DELETE CASCADE);

ALTER TABLE CWПроизводственный_цех
  ADD (CONSTRAINT O1 FOREIGN KEY (Номер_цеха) REFERENCES CWЦех (Номер_цеха));

ALTER TABLE CWРабочий
  ADD (CONSTRAINT R_15 FOREIGN KEY (Номер_бригады) REFERENCES CWБригада (Номер_бригады));

ALTER TABLE CWРабочий
  ADD (CONSTRAINT O8 FOREIGN KEY (Код_сотрудника) REFERENCES CWСотрудник (Код_сотрудника));

ALTER TABLE CWРуководитель
  ADD (CONSTRAINT R_55 FOREIGN KEY (Код_сотрудника) REFERENCES CWИТП (Код_сотрудника));

ALTER TABLE CWСборочный_участок
  ADD (CONSTRAINT R_80 FOREIGN KEY (Код_участка) REFERENCES CWУчасток (Код_участка));

ALTER TABLE CWСборщик
  ADD (CONSTRAINT O13 FOREIGN KEY (Код_сотрудника) REFERENCES CWРабочий (Код_сотрудника) ON DELETE CASCADE);

ALTER TABLE CWСлесарь
  ADD (CONSTRAINT O15 FOREIGN KEY (Код_сотрудника) REFERENCES CWРабочий (Код_сотрудника) ON DELETE CASCADE);

ALTER TABLE CWТехник
  ADD (CONSTRAINT O11 FOREIGN KEY (Код_сотрудника) REFERENCES CWИТП (Код_сотрудника) ON DELETE CASCADE);

ALTER TABLE CWТокарь
  ADD (CONSTRAINT O14 FOREIGN KEY (Код_сотрудника) REFERENCES CWРабочий (Код_сотрудника) ON DELETE CASCADE);

ALTER TABLE CWУчасток
  ADD (CONSTRAINT R_57 FOREIGN KEY (Начальник_участка) REFERENCES CWРуководитель (Код_ответств));

ALTER TABLE CWУчасток
  ADD (CONSTRAINT R_87 FOREIGN KEY (Номер_цеха) REFERENCES CWПроизводственный_цех (Номер_цеха));

ALTER TABLE CWЦех
  ADD (CONSTRAINT R_58 FOREIGN KEY (Начальник_цеха) REFERENCES CWРуководитель (Код_ответств));

ALTER TABLE CWЭкземпляр_изделия
  ADD (CONSTRAINT R_78 FOREIGN KEY (Номер_вида_изделия) REFERENCES CWВид_изделия (Номер_вида_изделия));