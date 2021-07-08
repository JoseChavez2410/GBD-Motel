/*==============================================================*/
/* Table: CARGO                                                 */
/*==============================================================*/
create table CARGO (
   ID_CARGO             SERIAL               not null,
   NOMBRE_CARGO         VARCHAR(20)          not null,
   constraint PK_CARGO primary key (ID_CARGO)
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   ID_CLIENTE           SERIAL               not null,
   CEDULA_CLIENTE       VARCHAR(10)          not null,
   NOMBRE_CLIENTE       VARCHAR(50)          not null,
   APELLIDO_CLIENTE     VARCHAR(50)          not null,
   constraint PK_CLIENTE primary key (ID_CLIENTE)
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   ID_EMPLEADO          SERIAL               not null,
   ID_CARGO             INT4                 not null,
   CEDULA_EMPLEADO      VARCHAR(10)          not null,
   NOMBRE_EMPLEADO      VARCHAR(50)          not null,
   APELLIDO_EMPLEADO    VARCHAR(50)          not null,
   TELEFONO_EMPLEADO    VARCHAR(15)          not null,
   DIRECCION_EMPLEADO   VARCHAR(60)          not null,
   CORREO_EMPLEADO      VARCHAR(30)          not null,
   SALARIO_EMPLEADO     MONEY                not null,
   constraint PK_EMPLEADO primary key (ID_EMPLEADO)
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   ID_FACTURA           SERIAL               not null,
   ID_HOSPEDAJE         INT4                 not null,
   FECHA_FACTURA        DATE                 not null,
   SUBTOTAL_FACTURA     MONEY                not null,
   TOTAL_FACTURA        MONEY                not null,
   constraint PK_FACTURA primary key (ID_FACTURA)
);

/*==============================================================*/
/* Table: HABITACION                                            */
/*==============================================================*/
create table HABITACION (
   ID_HABITACION        SERIAL               not null,
   ID_TIPO_HABITACION   INT4                 not null,
   NUMERO_HABITACION    NUMERIC              not null,
   DISPONIBLE_HABITACION BOOL                 not null,
   constraint PK_HABITACION primary key (ID_HABITACION)
);

/*==============================================================*/
/* Table: HOSPEDAJE                                             */
/*==============================================================*/
create table HOSPEDAJE (
   ID_HOSPEDAJE         SERIAL               not null,
   ID_EMPLEADO          INT4                 not null,
   ID_CLIENTE           INT4                 not null,
   ID_HABITACION        INT4                 not null,
   FECHA_HOSPEDAJE      DATE                 not null,
   PRECIO_HOSPEDAJE     MONEY                not null,
   constraint PK_HOSPEDAJE primary key (ID_HOSPEDAJE)
);

/*==============================================================*/
/* Table: MUEBLE                                                */
/*==============================================================*/
create table MUEBLE (
   ID_MUEBLE            SERIAL               not null,
   ID_TIPO_MUEBLE       INT4                 not null,
   ID_HABITACION        INT4                 not null,
   DETALLE_MUEBLE       VARCHAR(40)          not null,
   PRECIO_MUEBLE        MONEY                not null,
   constraint PK_MUEBLE primary key (ID_MUEBLE)
);

/*==============================================================*/
/* Table: RESERVA                                               */
/*==============================================================*/
create table RESERVA (
   ID_RESERVA           SERIAL               not null,
   ID_CLIENTE           INT4                 not null,
   ID_EMPLEADO          INT4                 not null,
   ID_HABITACION        INT4                 not null,
   FECHA_RESERVA        DATE                 not null,
   ESTADO_RESERVA_ASIST BOOL                 not null,
   constraint PK_RESERVA primary key (ID_RESERVA)
);

/*==============================================================*/
/* Table: SANCION                                               */
/*==============================================================*/
create table SANCION (
   ID_SANCION           SERIAL               not null,
   ID_MUEBLE            INT4                 not null,
   ID_CLIENTE           INT4                 not null,
   FECHA_SANCION        DATE                 not null,
   DETALLE_SANCION      VARCHAR(60)          not null,
   VALOR_SANCION        MONEY                null,
   constraint PK_SANCION primary key (ID_SANCION)
);

/*==============================================================*/
/* Table: SERVICIO                                              */
/*==============================================================*/
create table SERVICIO (
   ID_SERVICIO          SERIAL               not null,
   ID_TIPO_SERVICIO     INT4                 not null,
   ID_EMPLEADO          INT4                 not null,
   ID_HOSPEDAJE         INT4                 not null,
   DETALLE_SERVICIO     VARCHAR(40)          not null,
   PRECIO_SERVICIO      MONEY                not null,
   ESTADO_SERVICIO_ATENDIDO BOOL                 not null,
   constraint PK_SERVICIO primary key (ID_SERVICIO)
);

/*==============================================================*/
/* Table: TIPO_HABITACION                                       */
/*==============================================================*/
create table TIPO_HABITACION (
   ID_TIPO_HABITACION   SERIAL               not null,
   DESCRIPCION_HABITACION VARCHAR(20)          not null,
   constraint PK_TIPO_HABITACION primary key (ID_TIPO_HABITACION)
);

/*==============================================================*/
/* Table: TIPO_MUEBLE                                           */
/*==============================================================*/
create table TIPO_MUEBLE (
   ID_TIPO_MUEBLE       SERIAL               not null,
   NOMBRE_TIPO_MUEBLE   VARCHAR(15)          not null,
   constraint PK_TIPO_MUEBLE primary key (ID_TIPO_MUEBLE)
);

/*==============================================================*/
/* Table: TIPO_SERVICIO                                         */
/*==============================================================*/
create table TIPO_SERVICIO (
   ID_TIPO_SERVICIO     SERIAL               not null,
   NOMBRE_TIPO_SERVICIO VARCHAR(15)          not null,
   constraint PK_TIPO_SERVICIO primary key (ID_TIPO_SERVICIO)
);

alter table EMPLEADO
   add constraint FK_EMPLEADO_RELATIONS_CARGO foreign key (ID_CARGO)
      references CARGO (ID_CARGO)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_RELATIONS_HOSPEDAJ foreign key (ID_HOSPEDAJE)
      references HOSPEDAJE (ID_HOSPEDAJE)
      on delete restrict on update restrict;

alter table HABITACION
   add constraint FK_HABITACI_RELATIONS_TIPO_HAB foreign key (ID_TIPO_HABITACION)
      references TIPO_HABITACION (ID_TIPO_HABITACION)
      on delete restrict on update restrict;

alter table HOSPEDAJE
   add constraint FK_HOSPEDAJ_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
      on delete restrict on update restrict;

alter table HOSPEDAJE
   add constraint FK_HOSPEDAJ_RELATIONS_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE)
      on delete restrict on update restrict;

alter table HOSPEDAJE
   add constraint FK_HOSPEDAJ_RELATIONS_HABITACI foreign key (ID_HABITACION)
      references HABITACION (ID_HABITACION)
      on delete restrict on update restrict;

alter table MUEBLE
   add constraint FK_MUEBLE_RELATIONS_TIPO_MUE foreign key (ID_TIPO_MUEBLE)
      references TIPO_MUEBLE (ID_TIPO_MUEBLE)
      on delete restrict on update restrict;

alter table MUEBLE
   add constraint FK_MUEBLE_RELATIONS_HABITACI foreign key (ID_HABITACION)
      references HABITACION (ID_HABITACION)
      on delete restrict on update restrict;

alter table RESERVA
   add constraint FK_RESERVA_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
      on delete restrict on update restrict;

alter table RESERVA
   add constraint FK_RESERVA_RELATIONS_HABITACI foreign key (ID_HABITACION)
      references HABITACION (ID_HABITACION)
      on delete restrict on update restrict;

alter table RESERVA
   add constraint FK_RESERVA_RELATIONS_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE)
      on delete restrict on update restrict;

alter table SANCION
   add constraint FK_SANCION_RELATIONS_MUEBLE foreign key (ID_MUEBLE)
      references MUEBLE (ID_MUEBLE)
      on delete restrict on update restrict;

alter table SANCION
   add constraint FK_SANCION_RELATIONS_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE)
      on delete restrict on update restrict;

alter table SERVICIO
   add constraint FK_SERVICIO_RELATIONS_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
      on delete restrict on update restrict;

alter table SERVICIO
   add constraint FK_SERVICIO_RELATIONS_HOSPEDAJ foreign key (ID_HOSPEDAJE)
      references HOSPEDAJE (ID_HOSPEDAJE)
      on delete restrict on update restrict;

alter table SERVICIO
   add constraint FK_SERVICIO_RELATIONS_TIPO_SER foreign key (ID_TIPO_SERVICIO)
      references TIPO_SERVICIO (ID_TIPO_SERVICIO)
      on delete restrict on update restrict;
