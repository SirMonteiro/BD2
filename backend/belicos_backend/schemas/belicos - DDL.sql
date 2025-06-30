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

--REMOVER ESTA LINHA
--ALTER TABLE "grupo_armado" ADD FOREIGN KEY ("soma_baixas") REFERENCES "grupo_armado" ("codigo");

ALTER TABLE "chefe_militar" ADD FOREIGN KEY ("nome_lider", "codigo_lider") REFERENCES "lider" ("nome_lider", "codigo_grupo");

ALTER TABLE "chefe_militar" ADD FOREIGN KEY ("numero_divisao", "grupo_divisao") REFERENCES "divisao" ("numero_divisao", "codigo_grupo");

ALTER TABLE "dialoga" ADD FOREIGN KEY ("nomeL", "codigoG") REFERENCES "lider" ("nome_lider", "codigo_grupo");

-- ========================================
-- FUNÇÕES E TRIGGERS PARA REGRAS DE NEGÓCIO
-- ========================================

-- Trigger 1: Manter a consistência das baixas totais em cada grupo armado
-- Função para atualizar soma_baixas em grupo_armado
CREATE OR REPLACE FUNCTION update_soma_baixas_grupo_armado()
RETURNS TRIGGER AS $$
BEGIN
    -- Se a operação foi INSERT ou UPDATE na divisao
    IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
        UPDATE grupo_armado
        SET soma_baixas = (SELECT COALESCE(SUM(nr_baixas), 0) FROM divisao WHERE codigo_grupo = NEW.codigo_grupo)
        WHERE codigo = NEW.codigo_grupo;
    -- Se a operação foi DELETE na divisao
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE grupo_armado
        SET soma_baixas = (SELECT COALESCE(SUM(nr_baixas), 0) FROM divisao WHERE codigo_grupo = OLD.codigo_grupo)
        WHERE codigo = OLD.codigo_grupo;
    END IF;
    RETURN NULL; -- Retorna NULL para trigger AFTER
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função após INSERT, UPDATE ou DELETE em 'divisao'
CREATE TRIGGER trg_update_soma_baixas
AFTER INSERT OR UPDATE OF nr_baixas OR DELETE ON divisao
FOR EACH ROW
EXECUTE FUNCTION update_soma_baixas_grupo_armado();


-- Trigger 2: Gerar e assegurar a sequencialidade do número de divisão dentro do grupo armado
-- Função para definir o numero_divisao sequencialmente
CREATE OR REPLACE FUNCTION set_sequential_numero_divisao()
RETURNS TRIGGER AS $$
DECLARE
    next_numero INT;
BEGIN
    -- Verifica se o numero_divisao não foi fornecido (ou é NULL/0, indicando que deve ser gerado)
    -- Ou se ele já é o valor padrão serial, garantindo que a lógica só se aplique na primeira vez
    IF NEW.numero_divisao IS NULL OR NEW.numero_divisao = 0 THEN
        SELECT COALESCE(MAX(numero_divisao), 0) + 1
        INTO next_numero
        FROM divisao
        WHERE codigo_grupo = NEW.codigo_grupo;

        NEW.numero_divisao := next_numero;
    END IF;
    RETURN NEW; -- Retorna NEW para trigger BEFORE
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função antes de INSERT em 'divisao'
CREATE TRIGGER trg_set_sequential_divisao_nr
BEFORE INSERT ON divisao
FOR EACH ROW
EXECUTE FUNCTION set_sequential_numero_divisao();


-- Trigger 3: Limitar 3 chefes por divisão
-- Função para verificar o número máximo de chefes por divisão
CREATE OR REPLACE FUNCTION check_max_3_chefes()
RETURNS TRIGGER AS $$
DECLARE
  total_chefes INT;
BEGIN
  SELECT COUNT(*) INTO total_chefes
  FROM chefe_militar
  WHERE grupo_divisao = NEW.grupo_divisao AND numero_divisao = NEW.numero_divisao;

  -- Se já houver 3 chefes e estamos tentando inserir mais um
  IF total_chefes >= 3 THEN
    RAISE EXCEPTION 'Uma divisão não pode ter mais de 3 chefes militares.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função antes de INSERT em 'chefe_militar'
CREATE TRIGGER trg_max_chefes_por_divisao
BEFORE INSERT ON chefe_militar
FOR EACH ROW EXECUTE FUNCTION check_max_3_chefes();

CREATE OR REPLACE FUNCTION check_min_2_grupos_conflito()
RETURNS TRIGGER AS $$
DECLARE
  conflito_id INT;
  total INT;
BEGIN
  -- Para cada conflito, verifica se tem pelo menos 2 grupos
  FOR conflito_id IN SELECT DISTINCT codigo_conflito FROM participacao_entrada LOOP
    SELECT COUNT(*) INTO total FROM participacao_entrada WHERE codigo_conflito = conflito_id;
    IF total < 2 THEN
      RAISE EXCEPTION 'Conflito % possui menos de 2 grupos armados.', conflito_id;
    END IF;
  END LOOP;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_min_2_grupos_por_conflito
AFTER INSERT ON participacao_entrada
FOR EACH STATEMENT
EXECUTE FUNCTION check_min_2_grupos_conflito();