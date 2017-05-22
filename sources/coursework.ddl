
CREATE TABLE CWАтрибуты_ИТП
(
	Название_атрибута_ИТП VARCHAR2(15) NOT NULL ,
	ИД_категории_ИТП     NUMBER(2,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKАтрибуты_ИТП ON CWАтрибуты_ИТП
(Название_атрибута_ИТП   ASC);

ALTER TABLE CWАтрибуты_ИТП
	ADD  PRIMARY KEY (Название_атрибута_ИТП);

CREATE INDEX XIE1Атрибуты_ИТП ON CWАтрибуты_ИТП
(ИД_категории_ИТП   ASC);

CREATE TABLE CWАтрибуты_изделий
(
	Название_атрибута_изделия VARCHAR2(15) NOT NULL ,
	Название_категории_изделия VARCHAR2(15) NOT NULL 
);

CREATE UNIQUE INDEX XPKАтрибуты_изделий ON CWАтрибуты_изделий
(Название_атрибута_изделия   ASC);

ALTER TABLE CWАтрибуты_изделий
	ADD  PRIMARY KEY (Название_атрибута_изделия);

CREATE INDEX XIE1Атрибуты_изделий ON CWАтрибуты_изделий
(Название_категории_изделия   ASC);

CREATE TABLE CWАтрибуты_рабочего
(
	Название_атрибута_рабочего VARCHAR2(15) NOT NULL ,
	ИД_категории_рабочего NUMBER(2,0) NULL 
);

CREATE UNIQUE INDEX XPKАтрибуты_рабочего ON CWАтрибуты_рабочего
(Название_атрибута_рабочего   ASC);

ALTER TABLE CWАтрибуты_рабочего
	ADD  PRIMARY KEY (Название_атрибута_рабочего);

CREATE INDEX XIE1Атрибуты_рабочего ON CWАтрибуты_рабочего
(ИД_категории_рабочего   ASC);

CREATE TABLE CWБригада
(
	ИД_бригады           NUMBER(5,0) NOT NULL ,
	Номер_договора       NUMBER(6,0) NULL 
);

CREATE UNIQUE INDEX XPKБригада ON CWБригада
(ИД_бригады   ASC);

ALTER TABLE CWБригада
	ADD  PRIMARY KEY (ИД_бригады);

CREATE INDEX XIE1Бригада ON CWБригада
(Номер_договора   ASC);

CREATE TABLE CWВид_изделия
(
	Название_вида_изделия VARCHAR2(15) NOT NULL ,
	Название_категории_изделия VARCHAR2(15) NOT NULL 
);

CREATE UNIQUE INDEX XPKВид_изделия ON CWВид_изделия
(Название_вида_изделия   ASC);

ALTER TABLE CWВид_изделия
	ADD  PRIMARY KEY (Название_вида_изделия);

CREATE INDEX XIE1Вид_изделия ON CWВид_изделия
(Название_категории_изделия   ASC);

CREATE TABLE CWВспомогат_цех
(
	Номер_цеха           NUMBER(3,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKВспомогат_цех ON CWВспомогат_цех
(Номер_цеха   ASC);

ALTER TABLE CWВспомогат_цех
	ADD  PRIMARY KEY (Номер_цеха);

CREATE TABLE CWЖурнал
(
	Позиция_в_журнале    NUMBER(7,0) NOT NULL ,
	Начало               DATE NOT NULL ,
	Завершение           DATE NULL ,
	Номер_участка        NUMBER(3, 0) NULL ,
	Название_вида_изделия VARCHAR2(15) NOT NULL 
);

CREATE UNIQUE INDEX XPKЖурнал ON CWЖурнал
(Позиция_в_журнале   ASC);

ALTER TABLE CWЖурнал
	ADD  PRIMARY KEY (Позиция_в_журнале);

CREATE INDEX XIE1Журнал ON CWЖурнал
(Название_вида_изделия   ASC);

CREATE TABLE CWИТП
(
	ИД_категории_ИТП     NUMBER(2,0) NOT NULL ,
	Номер_договора       NUMBER(6,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKИТП ON CWИТП
(Номер_договора   ASC);

ALTER TABLE CWИТП
	ADD  PRIMARY KEY (Номер_договора);

CREATE INDEX XIE1ИТП ON CWИТП
(ИД_категории_ИТП   ASC);

CREATE TABLE CWКатегория_ИТП
(
	Название_категории_ИТП VARCHAR2(15) NOT NULL ,
	ИД_категории_ИТП     NUMBER(2,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKКатегория_ИТП ON CWКатегория_ИТП
(ИД_категории_ИТП   ASC);

ALTER TABLE CWКатегория_ИТП
	ADD  PRIMARY KEY (ИД_категории_ИТП);

CREATE UNIQUE INDEX XAK1Категория_ИТП ON CWКатегория_ИТП
(Название_категории_ИТП   ASC);

CREATE TABLE CWКатегория_изделия
(
	Название_категории_изделия VARCHAR2(15) NOT NULL ,
	Номер_цеха           NUMBER(3,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKКатегория_изделия ON CWКатегория_изделия
(Название_категории_изделия   ASC);

ALTER TABLE CWКатегория_изделия
	ADD  PRIMARY KEY (Название_категории_изделия);

CREATE INDEX XIE1Категория_изделия ON CWКатегория_изделия
(Номер_цеха   ASC);

CREATE TABLE CWКатегория_рабочего
(
	Название_категории_рабочего VARCHAR2(15) NOT NULL ,
	ИД_категории_рабочего NUMBER(2,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKКатегория_рабочего ON CWКатегория_рабочего
(ИД_категории_рабочего   ASC);

ALTER TABLE CWКатегория_рабочего
	ADD  PRIMARY KEY (ИД_категории_рабочего);

CREATE UNIQUE INDEX XAK1Категория_рабочего ON CWКатегория_рабочего
(Название_категории_рабочего   ASC);

CREATE TABLE CWМастер
(
	Номер_договора       NUMBER(6,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKМастер ON CWМастер
(Номер_договора   ASC);

ALTER TABLE CWМастер
	ADD  PRIMARY KEY (Номер_договора);

CREATE TABLE CWМастер_бригада
(
	ИД_бригады           NUMBER(5,0) NOT NULL ,
	Номер_договора       NUMBER(6,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKМастер_бригада ON CWМастер_бригада
(ИД_бригады   ASC,Номер_договора   ASC);

ALTER TABLE CWМастер_бригада
	ADD  PRIMARY KEY (ИД_бригады,Номер_договора);

CREATE INDEX XIE1Мастер_бригада ON CWМастер_бригада
(Номер_договора   ASC);

CREATE TABLE CWМастер_начальник
(
	Договор_мастер       NUMBER(6,0) NOT NULL ,
	Договор_нач_уч       NUMBER(6,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKМастер_начальник ON CWМастер_начальник
(Договор_мастер   ASC,Договор_нач_уч   ASC);

ALTER TABLE CWМастер_начальник
	ADD  PRIMARY KEY (Договор_мастер,Договор_нач_уч);

CREATE INDEX XIE1Мастер_начальник ON CWМастер_начальник
(Договор_нач_уч   ASC);

CREATE TABLE CWНачальник_участка
(
	Номер_договора       NUMBER(6,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKНачальник_участка ON CWНачальник_участка
(Номер_договора   ASC);

ALTER TABLE CWНачальник_участка
	ADD  PRIMARY KEY (Номер_договора);

CREATE TABLE CWНачальник_цеха
(
	Номер_договора       NUMBER(6,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKНачальник_цеха ON CWНачальник_цеха
(Номер_договора   ASC);

ALTER TABLE CWНачальник_цеха
	ADD  PRIMARY KEY (Номер_договора);

CREATE TABLE CWПроизводств_цех
(
	Номер_цеха           NUMBER(3,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKПроизводств_цех ON CWПроизводств_цех
(Номер_цеха   ASC);

ALTER TABLE CWПроизводств_цех
	ADD  PRIMARY KEY (Номер_цеха);

CREATE TABLE CWРаботы
(
	Номер_участка        NUMBER(3, 0) NOT NULL ,
	Название_категории_изделия VARCHAR2(15) NOT NULL 
);

CREATE UNIQUE INDEX XPKРаботы ON CWРаботы
(Номер_участка   ASC,Название_категории_изделия   ASC);

ALTER TABLE CWРаботы
	ADD  PRIMARY KEY (Номер_участка,Название_категории_изделия);

CREATE INDEX XIE1Работы ON CWРаботы
(Название_категории_изделия   ASC);

CREATE TABLE CWРабочий
(
	ИД_бригады           NUMBER(5,0) NULL ,
	ИД_категории_рабочего NUMBER(2,0) NOT NULL ,
	Номер_договора       NUMBER(6,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKРабочий ON CWРабочий
(Номер_договора   ASC);

ALTER TABLE CWРабочий
	ADD  PRIMARY KEY (Номер_договора);

CREATE INDEX XIE1Рабочий ON CWРабочий
(ИД_бригады   ASC);

CREATE INDEX XIE2Рабочий ON CWРабочий
(ИД_категории_рабочего   ASC);

CREATE TABLE CWСотрудник
(
	Номер_договора       NUMBER(6,0) NOT NULL ,
	Имя_сотрудника       VARCHAR2(12) NOT NULL ,
	Фамилия_сотрудника   VARCHAR2(12) NOT NULL ,
	Отчество_сотрудника  VARCHAR2(12) NULL 
);

CREATE UNIQUE INDEX XPKСотрудник ON CWСотрудник
(Номер_договора   ASC);

ALTER TABLE CWСотрудник
	ADD  PRIMARY KEY (Номер_договора);

CREATE TABLE CWУчасток
(
	Номер_участка        NUMBER(3,0) NOT NULL ,
	Тип_участка          VARCHAR2(9) NOT NULL  CHECK (Тип_участка IN ('Изготовка', 'Сборка')),
	Номер_цеха           NUMBER(3,0) NOT NULL ,
	Номер_договора       NUMBER(6,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKУчасток ON CWУчасток
(Номер_участка   ASC,Номер_цеха   ASC);

ALTER TABLE CWУчасток
	ADD  PRIMARY KEY (Номер_участка,Номер_цеха);

CREATE INDEX XIE2Участок ON CWУчасток
(Номер_цеха   ASC);

CREATE INDEX XIE3Участок ON CWУчасток
(Номер_договора   ASC);

CREATE TABLE CWЦех
(
	Номер_цеха           NUMBER(3,0) NOT NULL ,
	Номер_договора       NUMBER(6,0) NOT NULL 
);

CREATE UNIQUE INDEX XPKЦех ON CWЦех
(Номер_цеха   ASC);

ALTER TABLE CWЦех
	ADD  PRIMARY KEY (Номер_цеха);

CREATE INDEX XIE1Цех ON CWЦех
(Номер_договора   ASC);

CREATE VIEW Представление ( Имя_сотрудника,Фамилия_сотрудника,Отчество_сотрудника,Всего ) 
	 AS  SELECT CWСотрудник.Имя_сотрудника,CWСотрудник.Фамилия_сотрудника,CWСотрудник.Отчество_сотрудника,COUNT(CWУчасток2.Номер_участка)
		FROM CWЦех ,CWУчасток CWУчасток2,CWУчасток CWУчасток1,CWСотрудник 
		WHERE CWЦех.Номер_цеха = CWУчасток1.Номер_цеха AND
CWУчасток1.Номер_договора = CWСотрудник.Номер_договора
		GROUP BY CWУчасток1.Номер_участка, CWУчасток1.Номер_цеха, CWСотрудник.Фамилия_сотрудника, CWСотрудник.Имя_сотрудника, CWСотрудник.Отчество_сотрудника;

ALTER TABLE CWАтрибуты_ИТП
	ADD (FOREIGN KEY (ИД_категории_ИТП) REFERENCES CWКатегория_ИТП (ИД_категории_ИТП));

ALTER TABLE CWАтрибуты_изделий
	ADD (FOREIGN KEY (Название_категории_изделия) REFERENCES CWКатегория_изделия (Название_категории_изделия));

ALTER TABLE CWАтрибуты_рабочего
	ADD (FOREIGN KEY (ИД_категории_рабочего) REFERENCES CWКатегория_рабочего (ИД_категории_рабочего) ON DELETE SET NULL);

ALTER TABLE CWБригада
	ADD (FOREIGN KEY (Номер_договора) REFERENCES CWРабочий (Номер_договора) ON DELETE SET NULL);

ALTER TABLE CWВид_изделия
	ADD (FOREIGN KEY (Название_категории_изделия) REFERENCES CWКатегория_изделия (Название_категории_изделия));

ALTER TABLE CWВспомогат_цех
	ADD (FOREIGN KEY (Номер_цеха) REFERENCES CWЦех (Номер_цеха) ON DELETE CASCADE);

ALTER TABLE CWЖурнал
	ADD (FOREIGN KEY (Название_вида_изделия) REFERENCES CWВид_изделия (Название_вида_изделия));

ALTER TABLE CWИТП
	ADD (FOREIGN KEY (ИД_категории_ИТП) REFERENCES CWКатегория_ИТП (ИД_категории_ИТП));

ALTER TABLE CWИТП
	ADD (FOREIGN KEY (Номер_договора) REFERENCES CWСотрудник (Номер_договора));

ALTER TABLE CWКатегория_изделия
	ADD (FOREIGN KEY (Номер_цеха) REFERENCES CWПроизводств_цех (Номер_цеха));

ALTER TABLE CWМастер
	ADD (FOREIGN KEY (Номер_договора) REFERENCES CWИТП (Номер_договора));

ALTER TABLE CWМастер_бригада
	ADD (FOREIGN KEY (ИД_бригады) REFERENCES CWБригада (ИД_бригады));

ALTER TABLE CWМастер_бригада
	ADD (FOREIGN KEY (Номер_договора) REFERENCES CWМастер (Номер_договора));

ALTER TABLE CWМастер_начальник
	ADD (FOREIGN KEY (Договор_мастер) REFERENCES CWМастер (Номер_договора));

ALTER TABLE CWМастер_начальник
	ADD (FOREIGN KEY (Договор_нач_уч) REFERENCES CWНачальник_участка (Номер_договора));

ALTER TABLE CWНачальник_участка
	ADD (FOREIGN KEY (Номер_договора) REFERENCES CWИТП (Номер_договора));

ALTER TABLE CWНачальник_цеха
	ADD (FOREIGN KEY (Номер_договора) REFERENCES CWИТП (Номер_договора));

ALTER TABLE CWПроизводств_цех
	ADD (FOREIGN KEY (Номер_цеха) REFERENCES CWЦех (Номер_цеха) ON DELETE SET NULL);

ALTER TABLE CWРаботы
	ADD (FOREIGN KEY (Название_категории_изделия) REFERENCES CWКатегория_изделия (Название_категории_изделия) ON DELETE SET NULL);

ALTER TABLE CWРабочий
	ADD (FOREIGN KEY (ИД_категории_рабочего) REFERENCES CWКатегория_рабочего (ИД_категории_рабочего));

ALTER TABLE CWРабочий
	ADD (FOREIGN KEY (ИД_бригады) REFERENCES CWБригада (ИД_бригады));

ALTER TABLE CWРабочий
	ADD (FOREIGN KEY (Номер_договора) REFERENCES CWСотрудник (Номер_договора));

ALTER TABLE CWУчасток
	ADD (FOREIGN KEY (Номер_цеха) REFERENCES CWЦех (Номер_цеха));

ALTER TABLE CWУчасток
	ADD (FOREIGN KEY (Номер_договора) REFERENCES CWНачальник_участка (Номер_договора));

ALTER TABLE CWЦех
	ADD (FOREIGN KEY (Номер_договора) REFERENCES CWНачальник_цеха (Номер_договора));
