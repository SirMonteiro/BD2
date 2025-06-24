CREATE SCHEMA IF NOT EXISTS public;

SET search_path TO public;

CREATE TYPE "ajuda" AS ENUM (
  'medica',
  'diplomatica',
  'presencial'
);

CREATE TYPE "tipo_conflito" AS ENUM (
  'Territorial',
  'Religioso',
  'Economicos',
  'Raciais'
);

CREATE TYPE "tipo_organização" AS ENUM (
  'Governamental',
  'Nao_governamental',
  'Internacional'
);

CREATE TABLE "pais" (
  "codigo" integer PRIMARY KEY,
  "nome" varchar(60)
);

CREATE TABLE "paises_afetados" (
  "codigo_pais" integer,
  "codigo_conflito" integer,
  PRIMARY KEY ("codigo_pais", "codigo_conflito")
);

CREATE TABLE "conflito" (
  "codigo" serial PRIMARY KEY,
  "nome" varchar(100),
  "tipo_conf" tipo_conflito,
  "nr_feridos" integer,
  "nr_mortos" integer
);

CREATE TABLE "regioes_afetadas" (
  "codigo_conflito" integer,
  "regiao" varchar(100),
  PRIMARY KEY ("codigo_conflito", "regiao")
);

CREATE TABLE "religioes_afetadas" (
  "codigo_conflito" integer,
  "religiao" varchar(50),
  PRIMARY KEY ("codigo_conflito", "religiao")
);

CREATE TABLE "materias_primas_afetadas" (
  "codigo_conflito" integer,
  "materia_prima" varchar(50),
  PRIMARY KEY ("codigo_conflito", "materia_prima")
);

CREATE TABLE "etnias_afetadas" (
  "codigo_conflito" integer,
  "etnia" varchar(20),
  PRIMARY KEY ("codigo_conflito", "etnia")
);

CREATE TABLE "mediacao_entrada" (
  "codigo_conflito" integer,
  "codigo_organizacao" integer,
  "data_incorporacao" date,
  PRIMARY KEY ("codigo_conflito", "codigo_organizacao")
);

CREATE TABLE "mediacao_saida" (
  "codigo_conflito" integer,
  "codigo_organizacao" integer,
  "data_saida" date,
  PRIMARY KEY ("codigo_conflito", "codigo_organizacao")
);

CREATE TABLE "organizacao" (
  "codigo" serial PRIMARY KEY,
  "nome" varchar(100),
  "tipo" tipo_organização,
  "tipo_ajuda" ajuda,
  "org_lider" varchar(100),
  "nr_pessoas" int,
  "dependente_de" integer
);

CREATE TABLE "grupo_armado" (
  "codigo" serial PRIMARY KEY,
  "nome" varchar(100),
  "soma_baixas" integer
);

CREATE TABLE "participacao_entrada" (
  "codigo_conflito" integer,
  "codigo_grupo" integer NOT NULL,
  "data_incorporacao" date,
  PRIMARY KEY ("codigo_conflito", "codigo_grupo")
);

CREATE TABLE "participacao_saida" (
  "codigo_conflito" integer,
  "codigo_grupo" integer NOT NULL,
  "data_saida" date,
  PRIMARY KEY ("codigo_conflito", "codigo_grupo")
);

CREATE TABLE "divisao" (
  "numero_divisao" serial,
  "codigo_grupo" integer NOT NULL,
  "nr_avioes" integer,
  "nr_tanques" integer,
  "nr_barcos" integer,
  "nr_membros" integer,
  "nr_baixas" integer,
  PRIMARY KEY ("numero_divisao", "codigo_grupo")
);

CREATE TABLE "lider" (
  "codigo_grupo" integer NOT NULL,
  "nome_lider" varchar(100),
  "apoios" text,
  PRIMARY KEY ("nome_lider", "codigo_grupo")
);

CREATE TABLE "chefe_militar" (
  "codigo_chefe" serial PRIMARY KEY,
  "faixa_hierarquica" varchar(50),
  "nome_lider" varchar(100),
  "codigo_lider" integer,
  "numero_divisao" integer,
  "grupo_divisao" integer
);

CREATE TABLE "traficante" (
  "codigo" serial PRIMARY KEY,
  "nome" varchar(50),
  "sobrenome" varchar(50)
);

CREATE TABLE "tipo_arma" (
  "nome_modelo" varchar(100) PRIMARY KEY,
  "capacidade_destrutiva" float
);

CREATE TABLE "armas_estoque" (
  "codigo_traficante" integer,
  "modelo_arma" varchar(100),
  "qtd_estoque" integer,
  PRIMARY KEY ("codigo_traficante", "modelo_arma")
);

CREATE TABLE "historico_venda_armas" (
  "codigo_traficante" integer,
  "modelo_arma" varchar(100),
  "codigo_grupo_armado" integer,
  "qtd_vendida" integer,
  PRIMARY KEY ("codigo_traficante", "codigo_grupo_armado", "modelo_arma")
);

CREATE TABLE "dialoga" (
  "nomeL" varchar(100),
  "codigoG" integer,
  "codigoOrg" integer
);

ALTER TABLE "paises_afetados" ADD FOREIGN KEY ("codigo_pais") REFERENCES "pais" ("codigo");

ALTER TABLE "paises_afetados" ADD FOREIGN KEY ("codigo_conflito") REFERENCES "conflito" ("codigo");

ALTER TABLE "regioes_afetadas" ADD FOREIGN KEY ("codigo_conflito") REFERENCES "conflito" ("codigo");

ALTER TABLE "religioes_afetadas" ADD FOREIGN KEY ("codigo_conflito") REFERENCES "conflito" ("codigo");

ALTER TABLE "materias_primas_afetadas" ADD FOREIGN KEY ("codigo_conflito") REFERENCES "conflito" ("codigo");

ALTER TABLE "etnias_afetadas" ADD FOREIGN KEY ("codigo_conflito") REFERENCES "conflito" ("codigo");

ALTER TABLE "mediacao_entrada" ADD FOREIGN KEY ("codigo_conflito") REFERENCES "conflito" ("codigo");

ALTER TABLE "mediacao_entrada" ADD FOREIGN KEY ("codigo_organizacao") REFERENCES "organizacao" ("codigo");

ALTER TABLE "mediacao_saida" ADD FOREIGN KEY ("codigo_conflito") REFERENCES "conflito" ("codigo");

ALTER TABLE "mediacao_saida" ADD FOREIGN KEY ("codigo_organizacao") REFERENCES "organizacao" ("codigo");

ALTER TABLE "organizacao" ADD FOREIGN KEY ("dependente_de") REFERENCES "organizacao" ("codigo");

ALTER TABLE "participacao_entrada" ADD FOREIGN KEY ("codigo_conflito") REFERENCES "conflito" ("codigo");

ALTER TABLE "participacao_entrada" ADD FOREIGN KEY ("codigo_grupo") REFERENCES "grupo_armado" ("codigo");

ALTER TABLE "participacao_saida" ADD FOREIGN KEY ("codigo_conflito") REFERENCES "conflito" ("codigo");

ALTER TABLE "participacao_saida" ADD FOREIGN KEY ("codigo_grupo") REFERENCES "grupo_armado" ("codigo");

ALTER TABLE "divisao" ADD FOREIGN KEY ("codigo_grupo") REFERENCES "grupo_armado" ("codigo");

ALTER TABLE "lider" ADD FOREIGN KEY ("codigo_grupo") REFERENCES "grupo_armado" ("codigo");

ALTER TABLE "armas_estoque" ADD FOREIGN KEY ("codigo_traficante") REFERENCES "traficante" ("codigo");

ALTER TABLE "armas_estoque" ADD FOREIGN KEY ("modelo_arma") REFERENCES "tipo_arma" ("nome_modelo");

ALTER TABLE "historico_venda_armas" ADD FOREIGN KEY ("codigo_traficante") REFERENCES "traficante" ("codigo");

ALTER TABLE "historico_venda_armas" ADD FOREIGN KEY ("modelo_arma") REFERENCES "tipo_arma" ("nome_modelo");

ALTER TABLE "historico_venda_armas" ADD FOREIGN KEY ("codigo_grupo_armado") REFERENCES "grupo_armado" ("codigo");

ALTER TABLE "dialoga" ADD FOREIGN KEY ("codigoOrg") REFERENCES "organizacao" ("codigo");

ALTER TABLE "grupo_armado" ADD FOREIGN KEY ("soma_baixas") REFERENCES "grupo_armado" ("codigo");

ALTER TABLE "chefe_militar" ADD FOREIGN KEY ("nome_lider", "codigo_lider") REFERENCES "lider" ("nome_lider", "codigo_grupo");

ALTER TABLE "chefe_militar" ADD FOREIGN KEY ("numero_divisao", "grupo_divisao") REFERENCES "divisao" ("numero_divisao", "codigo_grupo");

ALTER TABLE "dialoga" ADD FOREIGN KEY ("nomeL", "codigoG") REFERENCES "lider" ("nome_lider", "codigo_grupo");
