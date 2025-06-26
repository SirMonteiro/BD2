-- Script de População do Banco de Dados - Sistema de Conflitos Bélicos
-- Universidade de São Paulo - ACH2025 Bancos de Dados 2

SET search_path TO public;

-- Limpar dados existentes (caso necessário)
TRUNCATE TABLE dialoga, historico_venda_armas, armas_estoque, tipo_arma, traficante,
               chefe_militar, lider, divisao, participacao_saida, participacao_entrada,
               grupo_armado, mediacao_saida, mediacao_entrada, organizacao,
               etnias_afetadas, materias_primas_afetadas, religioes_afetadas,
               regioes_afetadas, paises_afetados, conflito, pais RESTART IDENTITY CASCADE;

-- ========================================
-- POPULANDO TABELA PAIS
-- ========================================
INSERT INTO pais (codigo, nome) VALUES
(1, 'Brasil'),
(2, 'Estados Unidos'),
(3, 'Rússia'),
(4, 'China'),
(5, 'França'),
(6, 'Reino Unido'),
(7, 'Alemanha'),
(8, 'Israel'),
(9, 'Palestina'),
(10, 'Síria'),
(11, 'Iraque'),
(12, 'Irã'),
(13, 'Afeganistão'),
(14, 'Paquistão'),
(15, 'Índia'),
(16, 'Ucrânia'),
(17, 'Coreia do Norte'),
(18, 'Coreia do Sul'),
(19, 'Japão'),
(20, 'Turquia'),
(21, 'Egito'),
(22, 'Arábia Saudita'),
(23, 'Iêmen'),
(24, 'Líbia'),
(25, 'Sudão'),
(26, 'Etiópia'),
(27, 'Somália'),
(28, 'Congo'),
(29, 'Nigéria'),
(30, 'Mali'),
(31, 'Venezuela'),
(32, 'Colômbia'),
(33, 'México'),
(34, 'Argentina'),
(35, 'Chile'),
(36, 'Armênia'),
(37, 'Azerbaijão'),
(38, 'Filipinas'),
(39, 'Indonésia'),
(40, 'Ruanda');

-- ========================================
-- POPULANDO TABELA CONFLITO
-- ========================================
INSERT INTO conflito (nome, tipo_conf, nr_feridos, nr_mortos) VALUES
('Guerra do Golfo', 'Territorial', 150000, 45000),
('Conflito Israel-Palestina', 'Territorial', 85000, 25000),
('Guerra Civil Síria', 'Religioso', 500000, 350000),
('Invasão do Iraque', 'Economicos', 320000, 180000),
('Guerra do Afeganistão', 'Territorial', 280000, 170000),
('Conflito Russo-Ucraniano', 'Territorial', 750000, 400000),
('Guerra Civil do Iêmen', 'Religioso', 400000, 230000),
('Conflito na Somália', 'Raciais', 180000, 95000),
('Guerra Civil Líbia', 'Economicos', 120000, 65000),
('Conflito no Mali', 'Religioso', 95000, 45000),
('Guerra das Malvinas', 'Territorial', 3500, 900),
('Conflito Caxemira', 'Territorial', 200000, 85000),
('Guerra Civil Sudanesa', 'Raciais', 350000, 200000),
('Conflito Etíope', 'Raciais', 180000, 95000),
('Guerra Civil Congolesa', 'Economicos', 600000, 350000),
('Conflito Nigeriano', 'Religioso', 150000, 75000),
('Guerra Irã-Iraque', 'Territorial', 800000, 500000),
('Conflito das Coreias', 'Territorial', 450000, 250000),
('Guerra do Vietnã', 'Territorial', 1200000, 850000),
('Conflito na Venezuela', 'Economicos', 85000, 35000),
('Crise de Darfur', 'Raciais', 200000, 150000),
('Conflito em Nagorno-Karabakh', 'Territorial', 8000, 4000),
('Guerra do Tigray', 'Religioso', 300000, 180000),
('Guerra da Síria - Idlib', 'Territorial', 120000, 60000),
('Conflito em Mindanao', 'Religioso', 50000, 20000),
('Crise Rohingya', 'Raciais', 70000, 15000),
('Conflito na Ucrânia Oriental', 'Territorial', 250000, 100000);


-- ========================================
-- POPULANDO PAISES_AFETADOS
-- ========================================
INSERT INTO paises_afetados (codigo_pais, codigo_conflito) VALUES
(11, 1),
(2, 1),
(22, 1),
(8, 2),
(9, 2),
(10, 3),
(20, 3),
(12, 3),
(11, 4),
(2, 4),
(6, 4),
(13, 5),
(2, 5),
(14, 5),
(3, 6),
(16, 6),
(23, 7),
(22, 7),
(27, 8),
(26, 8),
(24, 9),
(21, 9),
(30, 10),
(5, 10),
(6, 11),
(34, 11),
(15, 12),
(14, 12),
(25, 13),
(26, 13),
(26, 14),
(27, 14),
(28, 15),
(40, 15),
(29, 16),
(12, 17),
(11, 17),
(17, 18),
(18, 18),
(2, 19),
(31, 20),
(32, 20),
(25, 21), (26, 21), -- Crise de Darfur
(36, 22), (37, 22), -- Nagorno-Karabakh
(26, 23), (27, 23), -- Tigray
(10, 24), (3, 24), -- Síria - Idlib
(38, 25), (39, 25), -- Mindanao
(14, 26), (40, 26), -- Rohingya
(16, 27), (3, 27); -- Ucrânia Oriental

-- ========================================
-- POPULANDO REGIOES_AFETADAS
-- ========================================
INSERT INTO regioes_afetadas (codigo_conflito, regiao) VALUES
(1, 'Oriente Médio'),
(2, 'Cisjordânia'),
(2, 'Faixa de Gaza'),
(3, 'Alepo'),
(3, 'Damasco'),
(4, 'Bagdá'),
(4, 'Basra'),
(5, 'Cabul'),
(5, 'Kandahar'),
(6, 'Donbass'),
(6, 'Crimeia'),
(7, 'Saná'),
(7, 'Aden'),
(8, 'Mogadício'),
(9, 'Trípoli'),
(10, 'Timbuktu'),
(11, 'Ilhas Malvinas'),
(12, 'Vale da Caxemira'),
(13, 'Darfur'),
(14, 'Tigray'),
(15, 'Kivu'),
(16, 'Borno'),
(17, 'Khuzistão'),
(18, 'Zona Desmilitarizada'),
(19, 'Mekong Delta'),
(20, 'Caracas'),
(21, 'Darfur Central'),
(22, 'Artsakh'),
(23, 'Mekelle'),
(24, 'Idlib'),
(25, 'Maguindanao'),
(26, 'Estado de Rakhine'),
(27, 'Lugansk');

-- ========================================
-- POPULANDO RELIGIOES_AFETADAS
-- ========================================
INSERT INTO religioes_afetadas (codigo_conflito, religiao) VALUES
(3, 'Islamismo'),
(3, 'Cristianismo'),
(7, 'Islamismo Sunita'),
(7, 'Islamismo Xiita'),
(10, 'Islamismo'),
(16, 'Islamismo'),
(16, 'Cristianismo'),
(17, 'Islamismo Sunita'),
(17, 'Islamismo Xiita'),
(23, 'Cristianismo Ortodoxo'),
(25, 'Islamismo Sunita'),
(25, 'Cristianismo');


-- ========================================
-- POPULANDO MATERIAS_PRIMAS_AFETADAS
-- ========================================
INSERT INTO materias_primas_afetadas (codigo_conflito, materia_prima) VALUES
(1, 'Petróleo'),
(4, 'Petróleo'),
(6, 'Gás Natural'),
(9, 'Petróleo'),
(15, 'Diamantes'),
(15, 'Coltan'),
(17, 'Petróleo'),
(20, 'Petróleo'),
(22, 'Cobre'),
(27, 'Carvão');

-- ========================================
-- POPULANDO ETNIAS_AFETADAS
-- ========================================
INSERT INTO etnias_afetadas (codigo_conflito, etnia) VALUES
(8, 'Somalis'),
(8, 'Bantus'),
(13, 'Árabes'),
(13, 'Nubios'),
(14, 'Tigray'),
(14, 'Amhara'),
(15, 'Hutus'),
(15, 'Tutsis'),
(16, 'Hauçás'),
(16, 'Igbos'),
(21, 'Fur'),
(21, 'Zaghawa'),
(23, 'Amhara'),
(25, 'Moro'),
(26, 'Rohingya');


-- ========================================
-- POPULANDO ORGANIZACAO
-- Adicionando mais mediacoes para testar Top 5 organizações
-- ========================================
INSERT INTO organizacao (codigo, nome, tipo, tipo_ajuda, org_lider, nr_pessoas, dependente_de) VALUES
(1, 'ONU - Operações de Paz', 'Internacional', 'diplomatica', 'António Guterres', 15000, NULL),
(2, 'Cruz Vermelha Internacional', 'Internacional', 'medica', 'Peter Maurer', 25000, NULL),
(3, 'NATO', 'Internacional', 'presencial', 'Jens Stoltenberg', 8000, NULL),
(4, 'Médicos Sem Fronteiras', 'Nao_governamental', 'medica', 'Christos Christou', 45000, NULL),
(5, 'UNICEF', 'Internacional', 'medica', 'Catherine Russell', 17000, 1),
(6, 'ACNUR', 'Internacional', 'diplomatica', 'Filippo Grandi', 20000, 1),
(7, 'União Africana', 'Internacional', 'diplomatica', 'Moussa Faki', 5000, NULL),
(8, 'Liga Árabe', 'Internacional', 'diplomatica', 'Ahmed Aboul Gheit', 3000, NULL),
(9, 'OTAN Mediterrâneo', 'Internacional', 'presencial', 'Admiral Johnson', 2500, 3),
(10, 'Crescente Vermelho', 'Internacional', 'medica', 'Said Hassan', 12000, 2),
(11, 'Save the Children', 'Nao_governamental', 'medica', 'Inger Ashing', 25000, NULL),
(12, 'Human Rights Watch', 'Nao_governamental', 'diplomatica', 'Kenneth Roth', 450, NULL),
(13, 'Oxfam Internacional', 'Nao_governamental', 'medica', 'Gabriela Bucher', 21000, NULL),
(14, 'Anistia Internacional', 'Nao_governamental', 'diplomatica', 'Agnès Callamard', 7000, NULL),
(15, 'World Vision', 'Nao_governamental', 'medica', 'Andrew Morley', 37000, NULL),
(16, 'Comunidade Econômica dos Estados da África Ocidental (CEDEAO)', 'Internacional', 'diplomatica', 'Omar Touray', 1500, NULL);


-- ========================================
-- POPULANDO MEDIACAO_ENTRADA
-- Adicionando mais dados para Top 5 organizações por mediações
-- ========================================
INSERT INTO mediacao_entrada (codigo_conflito, codigo_organizacao, data_incorporacao) VALUES
(1, 1, '1991-01-15'),
(1, 2, '1991-02-01'),
(2, 1, '1948-05-15'),
(2, 4, '1967-06-10'),
(3, 1, '2011-03-15'),
(3, 2, '2011-04-01'),
(3, 4, '2011-05-15'),
(4, 1, '2003-03-20'),
(4, 2, '2003-04-01'),
(5, 1, '2001-10-07'),
(5, 3, '2001-10-07'),
(6, 1, '2014-04-15'),
(6, 3, '2014-04-20'),
(7, 1, '2014-09-21'),
(7, 8, '2015-03-26'),
(8, 1, '1992-04-24'),
(8, 7, '2007-01-01'),
(9, 1, '2011-02-26'),
(9, 8, '2011-03-15'),
(10, 1, '2013-04-25'),
(10, 7, '2013-01-11'),
(11, 1, '1982-04-05'),
(12, 1, '1949-01-01'),
(13, 1, '2005-01-09'),
(13, 7, '2004-07-15'),
(14, 1, '2020-11-04'),
(14, 7, '2020-12-01'),
(15, 1, '1999-08-30'),
(15, 7, '1998-07-17'),
(16, 1, '2009-06-11'),
(16, 7, '2012-04-01'),
(17, 1, '1980-09-22'),
(17, 8, '1982-05-15'),
(18, 1, '1950-06-27'),
(19, 1, '1964-08-07'),
(20, 1, '2019-01-23'),
(21, 7, '2004-09-01'),
(21, 12, '2004-10-10'), -- Human Rights Watch na Crise de Darfur
(22, 1, '1994-05-01'), -- Nagorno-Karabakh - ONU
(22, 14, '1994-06-01'), -- Anistia Internacional em Nagorno-Karabakh
(23, 1, '2020-11-05'), -- Tigray - ONU
(23, 2, '2020-11-10'), -- Tigray - Cruz Vermelha
(23, 7, '2020-11-15'), -- Tigray - União Africana
(24, 1, '2015-03-01'), -- Síria - Idlib - ONU
(24, 4, '2015-03-05'), -- Síria - Idlib - MSF
(25, 1, '2017-05-01'), -- Mindanao - ONU
(25, 11, '2017-06-01'), -- Mindanao - Save the Children
(26, 1, '2017-08-25'), -- Rohingya - ONU
(26, 2, '2017-09-01'), -- Rohingya - Cruz Vermelha
(26, 13, '2017-09-05'), -- Rohingya - Oxfam
(27, 1, '2022-02-24'), -- Ucrânia Oriental - ONU
(27, 3, '2022-02-25'), -- Ucrânia Oriental - NATO
(27, 6, '2022-03-01'), -- Ucrânia Oriental - ACNUR
(10, 16, '2013-05-01'); -- Mali - CEDEAO

-- ========================================
-- POPULANDO MEDIACAO_SAIDA
-- ========================================
INSERT INTO mediacao_saida (codigo_conflito, codigo_organizacao, data_saida) VALUES

(1, 2, '1991-04-15'),
(4, 2, '2011-12-18'),
(11, 1, '1982-06-14'),
(17, 8, '1988-08-20'),
(19, 1, '1975-04-30'),
(22, 14, '1994-07-01'),
(24, 4, '2020-01-01');

-- ========================================
-- POPULANDO GRUPO_ARMADO
-- Mantidos seus dados. soma_baixas será atualizado pelo trigger.
-- ========================================
INSERT INTO grupo_armado (nome, soma_baixas) VALUES
('Forças Armadas dos Estados Unidos ', 0), -- 1
('Forças Armadas do Iraque ', 0), -- 2
('Forças de Defesa de Israel', 0), -- 3
('Autoridade Nacional Palestina', 0), -- 4
('Exército Árabe Sírio', 0), -- 5
('Exército Russo', 0), -- 6
('Forças Armadas Ucranianas', 0), -- 7
('Coalizão Saudita', 0), -- 8
('Houthis', 0), -- 9
('Al-Shabaab', 0), -- 10
('Governo de Acordo Nacional', 0), -- 11 (Líbia)
('Forças Armadas da França', 0), -- 12
('Forças Armadas da Argentina', 0), -- 13
('Forças Armadas Britânicas', 0), -- 14
('Exército Indiano', 0), -- 15
('Exército Paquistanês', 0), -- 16
('Forças Governamentais Sudanesas', 0), -- 17
('Exército Etíope', 0), -- 18
('Forças Armadas Congolesas', 0), -- 19
('Exército Nigeriano', 0), -- 20
('Guarda Revolucionária Iraniana', 0), -- 21
('Exército Norte-Coreano', 0), -- 22
('Exército Sul-Coreano', 0), -- 23
('Forças Vietnamitas', 0), -- 24
('Milícias Venezuelanas', 0), -- 25
('Frente Nacional de Libertação Síria', 0), -- 26
('Talibã Afegão', 0), -- 27
('Exército de Libertação Popular', 0), -- 28 (China)
('Exército Nacional Líbio', 0), -- 29 (Líbia)
('Forças Armadas do Sudão do Sul', 0), -- 30 (Sudão do Sul)
('Forças Armadas do Mali', 0), -- 31 (Mali)
('Forças Armadas da Somália', 0), -- 32 (Somália)
('Forças Armadas da Somália', 0), -- 32
('Forças Armadas do Mali', 0), -- 31
('Forças Armadas do Sudão do Sul', 0), -- 30 (Referente ao SPLA na Guerra Civil Sudanesa inicial)
('Frente de Libertação do Povo Tigray', 0), -- 33
('Movimento de Libertação do Congo (MLC)', 0), -- 34
('Boko Haram', 0), -- 35
('Oposição Venezuelana', 0), -- 36 (Representa um lado no conflito, mesmo que não seja um grupo "armado" tradicional)
('Exército de Libertação do Sudão (SLA)', 0), -- 37
('Forças Armadas do Azerbaijão', 0), -- 38
('Forças Armadas da Armênia', 0), -- 39
('Exército Nacional das Filipinas', 0), -- 40
('Frente Moro de Libertação Islâmica (MILF)', 0), -- 41
('Exército de Salvação Arakan Rohingya (ARSA)', 0), -- 42
('Forças Armadas de Mianmar (Tatmadaw)', 0); -- 43

-- ========================================
-- POPULANDO PARTICIPACAO_ENTRADA
-- ========================================
INSERT INTO participacao_entrada (codigo_conflito, codigo_grupo, data_incorporacao) VALUES
(1, 1, '1991-01-17'), -- Guerra do Golfo: Forças Armadas dos Estados Unidos
(1, 2, '1990-08-02'), -- Guerra do Golfo: Forças Armadas do Iraque
(2, 3, '1948-05-15'), -- Conflito Israel-Palestina: Forças de Defesa de Israel
(2, 4, '1948-05-15'), -- Conflito Israel-Palestina: Autoridade Nacional Palestina (como representante palestino geral, embora o Hamas seja mais proeminente hoje)
(3, 5, '2011-03-15'), -- Guerra Civil Síria: Exército Árabe Sírio
(3, 26, '2012-05-01'), -- Guerra Civil Síria: Frente Nacional de Libertação Síria (representando grupos rebeldes)
(4, 1, '2003-03-20'), -- Invasão do Iraque: Forças Armadas dos Estados Unidos
(4, 2, '2003-03-20'), -- Invasão do Iraque: Forças Armadas do Iraque
(5, 1, '2001-10-07'), -- Guerra do Afeganistão: Forças Armadas dos Estados Unidos
(5, 27, '2002-01-01'), -- Guerra do Afeganistão: Talibã Afegão
(6, 6, '2014-02-20'), -- Conflito Russo-Ucraniano: Exército Russo
(6, 7, '2014-02-20'), -- Conflito Russo-Ucraniano: Forças Armadas Ucranianas
(7, 8, '2015-03-26'), -- Guerra Civil do Iêmen: Coalizão Saudita
(7, 9, '2014-09-21'), -- Guerra Civil do Iêmen: Houthis
(8, 10, '2006-12-28'), -- Conflito na Somália: Al-Shabaab
(8, 32, '2006-12-28'), -- Conflito na Somália: Forças Armadas da Somália (adicionado como ID 32 em grupo_armado)
(9, 11, '2011-02-17'), -- Guerra Civil Líbia: Governo de Acordo Nacional
(9, 29, '2011-02-17'), -- Guerra Civil Líbia: Exército Nacional Líbio
(10, 12, '2013-01-11'), -- Conflito no Mali: Forças Armadas da França
(10, 31, '2013-01-11'), -- Conflito no Mali: Forças Armadas do Mali (adicionado como ID 31 em grupo_armado)
(11, 14, '1982-04-02'), -- Guerra das Malvinas: Forças Armadas Britânicas
(11, 13, '1982-04-02'), -- Guerra das Malvinas: Forças Armadas da Argentina
(12, 15, '1947-10-22'), -- Conflito Caxemira: Exército Indiano
(12, 16, '1947-10-22'), -- Conflito Caxemira: Exército Paquistanês
(13, 17, '1983-02-26'), -- Guerra Civil Sudanesa: Forças Governamentais Sudanesas
(13, 30, '1983-02-26'), -- Guerra Civil Sudanesa: Forças Armadas do Sudão do Sul (adicionado como ID 30 em grupo_armado - SPLA na época)
(14, 18, '2020-11-04'), -- Conflito Etíope: Exército Etíope
(14, 33, '2020-11-04'), -- Conflito Etíope: Frente de Libertação do Povo Tigray (TPLF) (adicionado como ID 33 em grupo_armado)
(15, 19, '1996-08-02'), -- Guerra Civil Congolesa: Forças Armadas Congolesas
(15, 34, '1996-08-02'), -- Guerra Civil Congolesa: Movimento de Libertação do Congo (MLC) (adicionado como ID 34 em grupo_armado, um dos principais grupos rebeldes)
(16, 20, '2009-07-26'), -- Conflito Nigeriano: Exército Nigeriano
(16, 35, '2009-07-26'), -- Conflito Nigeriano: Boko Haram (adicionado como ID 35 em grupo_armado)
(17, 21, '1980-09-22'), -- Guerra Irã-Iraque: Guarda Revolucionária Iraniana
(17, 2, '1980-09-22'), -- Guerra Irã-Iraque: Forças Armadas do Iraque
(18, 22, '1950-06-25'), -- Conflito das Coreias: Exército Norte-Coreano
(18, 23, '1950-06-25'), -- Conflito das Coreias: Exército Sul-Coreano
(19, 1, '1964-08-02'), -- Guerra do Vietnã: Forças Armadas dos Estados Unidos
(19, 24, '1964-08-02'), -- Guerra do Vietnã: Forças Vietnamitas (referindo-se ao Vietnã do Norte e Viet Cong)
(20, 25, '2019-01-23'), -- Conflito na Venezuela: Milícias Venezuelanas (pró-governo)
(20, 36, '2019-01-23'), -- Conflito na Venezuela: Oposição Venezuelana (considerando grupos de protesto e oposição organizada, embora não sejam "armados" no mesmo sentido, representam um lado no "conflito")
(21, 17, '2003-02-28'), -- Crise de Darfur: Forças Governamentais Sudanesas
(21, 37, '2003-03-01'), -- Crise de Darfur: Exército de Libertação do Sudão (SLA) (adicionado como ID 37 em grupo_armado)
(22, 38, '1990-09-01'), -- Conflito em Nagorno-Karabakh: Forças Armadas do Azerbaijão (adicionado como ID 38 em grupo_armado)
(22, 39, '1990-09-01'), -- Conflito em Nagorno-Karabakh: Forças Armadas da Armênia (adicionado como ID 39 em grupo_armado)
(23, 18, '2020-11-04'), -- Guerra do Tigray: Exército Etíope
(23, 33, '2020-11-05'), -- Guerra do Tigray: Frente de Libertação do Povo Tigray (TPLF)
(24, 5, '2016-01-01'), -- Guerra da Síria - Idlib: Exército Árabe Sírio
(24, 26, '2016-01-05'), -- Guerra da Síria - Idlib: Frente Nacional de Libertação Síria (ou grupos rebeldes associados)
(25, 40, '1970-01-01'), -- Conflito em Mindanao: Exército Nacional das Filipinas (adicionado como ID 40 em grupo_armado)
(25, 41, '1970-01-05'), -- Conflito em Mindanao: Frente Moro de Libertação Islâmica (MILF) (adicionado como ID 41 em grupo_armado)
(26, 42, '2017-08-25'), -- Crise Rohingya: Exército de Salvação Arakan Rohingya (ARSA) (adicionado como ID 42 em grupo_armado)
(26, 43, '2017-08-26'), -- Crise Rohingya: Forças Armadas de Mianmar (Tatmadaw) (adicionado como ID 43 em grupo_armado)
(27, 6, '2022-02-24'), -- Conflito na Ucrânia Oriental: Exército Russo
(27, 7, '2022-02-24'); -- Conflito na Ucrânia Oriental: Forças Armadas Ucranianas


-- ========================================
-- POPULANDO PARTICIPACAO_SAIDA
-- ========================================
INSERT INTO participacao_saida (codigo_conflito, codigo_grupo, data_saida) VALUES
(1, 1, '1991-02-28'),
(4, 1, '2011-12-18'),
(5, 1, '2021-08-30'),
(11, 12, '1982-06-14'),
(11, 13, '1982-06-14'),
(17, 21, '1988-08-20'),
(17, 2, '1988-08-20'),
(19, 1, '1975-04-30'),
(22, 12, '1994-05-12'),
(24, 26, '2020-03-01');


-- ========================================
-- POPULANDO DIVISAO
-- Adicionado a coluna numero_divisao para FK em chefe_militar e testar sequencialidade
-- E mais dados para top grupos por armas fornecidas.
-- ========================================
INSERT INTO divisao (codigo_grupo, numero_divisao, nr_avioes, nr_tanques, nr_barcos, nr_membros, nr_baixas) VALUES

(1, 1, 120, 150, 25, 15000, 8500),
(1, 2, 85, 200, 15, 18000, 9200),
(1, 3, 95, 180, 20, 16500, 7300),
(2, 1, 45, 85, 5, 25000, 18000),
(2, 2, 25, 120, 8, 22000, 15000),
(2, 3, 35, 95, 3, 20000, 12000),
(3, 1, 180, 220, 12, 12000, 4500),
(3, 2, 150, 185, 8, 11000, 4000),
(4, 1, 0, 15, 0, 8000, 6500),
(4, 2, 0, 25, 0, 9500, 5500),
(5, 1, 85, 450, 2, 35000, 42000),
(5, 2, 65, 380, 1, 32000, 43000),
(6, 1, 250, 850, 45, 45000, 18000),
(6, 2, 180, 650, 35, 38000, 17000),
(7, 1, 45, 180, 8, 28000, 15000),
(7, 2, 35, 150, 5, 25000, 13000),
(8, 1, 125, 85, 15, 18000, 8500),
(8, 2, 95, 65, 12, 15000, 6500),
(9, 1, 5, 45, 2, 25000, 12000),
(9, 2, 3, 35, 1, 22000, 10000),
(10, 1, 0, 25, 0, 15000, 9500),
(10, 2, 0, 18, 0, 12000, 8500),
(11, 1, 35, 85, 5, 18000, 4500),
(11, 2, 25, 65, 3, 15000, 4000),
(12, 1, 65, 45, 8, 5500, 250),
(12, 2, 45, 35, 5, 4500, 200),
(13, 1, 45, 25, 12, 8500, 350),
(13, 2, 35, 18, 8, 7500, 300),
(14, 1, 85, 45, 25, 9500, 155),
(14, 2, 65, 35, 18, 8500, 100),
(15, 1, 185, 450, 15, 65000, 18500),
(15, 2, 165, 385, 12, 58000, 16500),
(16, 1, 125, 285, 8, 45000, 15000),
(16, 2, 95, 225, 5, 38000, 13000),
(17, 1, 65, 185, 2, 35000, 28000),
(17, 2, 45, 155, 1, 32000, 27000),
(18, 1, 45, 125, 0, 28000, 13500),
(18, 2, 35, 95, 0, 25000, 11500),
(19, 1, 25, 85, 3, 45000, 38000),
(19, 2, 18, 65, 2, 42000, 37000),
(20, 1, 35, 65, 0, 25000, 6500),
(20, 2, 25, 45, 0, 22000, 5500),
(21, 1, 185, 485, 25, 55000, 48000),
(21, 2, 165, 425, 18, 52000, 47000),
(22, 1, 125, 385, 12, 48000, 23000),
(22, 2, 95, 325, 8, 45000, 22000),
(23, 1, 165, 285, 15, 45000, 19000),
(23, 2, 145, 245, 12, 42000, 19000),
(24, 1, 85, 185, 5, 85000, 95000),
(24, 2, 65, 155, 3, 82000, 90000),
(25, 1, 15, 35, 2, 12000, 4500),
(25, 2, 12, 28, 1, 11000, 4000),
-- Novas Divisões para novos grupos
(26, 1, 20, 30, 0, 8000, 3000), -- Frente Nacional de Libertação Síria
(26, 2, 15, 25, 0, 7000, 2500),
(27, 1, 0, 50, 0, 25000, 10000), -- Talibã Afegão
(27, 2, 0, 40, 0, 22000, 8000),
(28, 1, 500, 1200, 80, 500000, 20000); -- Exército de Libertação Popular

-- Atualizando soma_baixas nos grupos armados (este update deve ser executado *após* a inserção das divisões,
-- e idealmente seria um trigger, como já visto no arquivo de triggers)
UPDATE grupo_armado
SET soma_baixas = (
    SELECT COALESCE(SUM(nr_baixas), 0)
    FROM divisao
    WHERE divisao.codigo_grupo = grupo_armado.codigo
)
WHERE codigo IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28);


-- ========================================
-- POPULANDO LIDER
-- ========================================
INSERT INTO lider (codigo_grupo, nome_lider, apoios) VALUES

(1, 'General Norman Schwarzkopf', 'Congresso dos EUA, NATO'),
(2, 'General Qasim Suleimani', 'Governo Iraquiano, Milícias Xiitas'),
(3, 'General Benny Gantz', 'Knesset, IDF'),
(4, 'Yasser Arafat', 'OLP, Liga Árabe'),
(5, 'General Maher al-Assad', 'Governo Sírio, Rússia'),
(6, 'General Valery Gerasimov', 'Kremlin, Duma'),
(7, 'General Valerii Zaluzhnyi', 'Parlamento Ucraniano, NATO'),
(8, 'Príncipe Mohammed bin Salman', 'Casa de Saud, Conselho de Cooperação do Golfo'),
(9, 'Abdul-Malik al-Houthi', 'Irã, Hezbollah'),
(10, 'Ahmed Abdi Godane', 'Al-Qaeda, Células Terroristas'),
(11, 'General Khalifa Haftar', 'Parlamento de Tobruk, Egito'),
(12, 'General François Lecointre', 'Assembleia Nacional Francesa, União Europeia'),
(13, 'General Mario Menéndez', 'Junta Militar Argentina'),
(14, 'Admiral Sandy Woodward', 'Parlamento Britânico, Commonwealth'),
(15, 'General Bipin Rawat', 'Parlamento Indiano, BJP'),
(16, 'General Qamar Javed Bajwa', 'Assembleia Nacional Paquistanesa'),
(17, 'General Abdel Fattah al-Burhan', 'Conselho Militar de Transição'),
(18, 'General Berhanu Jula', 'Governo Etíope, Partido da Prosperidade'),
(19, 'General Gabriel Amisi', 'Governo Congolês'),
(20, 'General Lucky Irabor', 'Governo Nigeriano, ECOWAS'),
(21, 'General Hossein Salami', 'Conselho Supremo do Irã, Aiatolá'),
(22, 'Marechal Ri Pyong-chol', 'Partido dos Trabalhadores da Coreia'),
(23, 'General Park Han-ki', 'Assembleia Nacional Sul-Coreana'),
(24, 'General Vo Nguyen Giap', 'Partido Comunista Vietnamita'),
(25, 'General Vladimir Padrino', 'PSUV, Governo Venezuelano'),
-- Novos Líderes para novos grupos
(26, 'Abu Mohammed al-Julani', 'Hayat Tahrir al-Sham, Turquia'),
(27, 'Mullah Hibatullah Akhundzada', 'Shura do Talibã'),
(28, 'Xi Jinping', 'Partido Comunista Chinês');

-- ========================================
-- POPULANDO CHEFE_MILITAR
-- Usando o campo 'codigo' para a PK serial
-- ========================================
INSERT INTO chefe_militar (codigo_chefe, faixa_hierarquica, nome_lider, codigo_lider, numero_divisao, grupo_divisao) VALUES
-- Divisão 1 do Grupo 1 (3 chefes)
(1, 'General', 'General Norman Schwarzkopf', 1, 1, 1),
(2, 'Coronel', 'General Norman Schwarzkopf', 1, 1, 1), -- Assumindo que o nome do líder pode ser o mesmo, mas o chefe militar é diferente
(3, 'Major-General', 'General Norman Schwarzkopf', 1, 1, 1),
-- Divisão 2 do Grupo 1 (2 chefes)
(4, 'General', 'General Norman Schwarzkopf', 1, 2, 1),
(5, 'Brigadeiro', 'General Norman Schwarzkopf', 1, 2, 1),
-- Divisão 1 do Grupo 2 (3 chefes)
(6, 'General', 'General Qasim Suleimani', 2, 1, 2),
(7, 'Coronel', 'General Qasim Suleimani', 2, 1, 2),
(8, 'Major', 'General Qasim Suleimani', 2, 1, 2),
-- Divisão 2 do Grupo 2 (1 chefe)
(9, 'General', 'General Qasim Suleimani', 2, 2, 2),
-- Divisão 1 do Grupo 3 (3 chefes)
(10, 'General', 'General Benny Gantz', 3, 1, 3),
(11, 'Coronel', 'General Benny Gantz', 3, 1, 3),
(12, 'Major-General', 'General Benny Gantz', 3, 1, 3),
-- Divisão 1 do Grupo 4 (2 chefes)
(13, 'Líder', 'Yasser Arafat', 4, 1, 4),
(14, 'Comandante', 'Yasser Arafat', 4, 1, 4),
-- Divisão 1 do Grupo 5 (3 chefes)
(15, 'General', 'General Maher al-Assad', 5, 1, 5),
(16, 'Coronel', 'General Maher al-Assad', 5, 1, 5),
(17, 'Major', 'General Maher al-Assad', 5, 1, 5),
-- Divisão 1 do Grupo 6 (2 chefes)
(18, 'General', 'General Valery Gerasimov', 6, 1, 6),
(19, 'Coronel', 'General Valery Gerasimov', 6, 1, 6),
-- Divisão 1 do Grupo 7 (3 chefes)
(20, 'General', 'General Valerii Zaluzhnyi', 7, 1, 7),
(21, 'Coronel', 'General Valerii Zaluzhnyi', 7, 1, 7),
(22, 'Major', 'General Valerii Zaluzhnyi', 7, 1, 7),
-- Divisão 1 do Grupo 8 (1 chefe)
(23, 'Príncipe', 'Príncipe Mohammed bin Salman', 8, 1, 8),
-- Divisão 1 do Grupo 9 (2 chefes)
(24, 'Líder', 'Abdul-Malik al-Houthi', 9, 1, 9),
(25, 'Comandante', 'Abdul-Malik al-Houthi', 9, 1, 9),
-- Divisão 1 do Grupo 10 (3 chefes)
(26, 'Emir', 'Ahmed Abdi Godane', 10, 1, 10),
(27, 'Comandante', 'Ahmed Abdi Godane', 10, 1, 10),
(28, 'Sheikh', 'Ahmed Abdi Godane', 10, 1, 10),
-- Adicionando mais chefes para testar o limite de 3 por divisão
(29, 'General', 'Abu Mohammed al-Julani', 26, 1, 26),
(30, 'Coronel', 'Abu Mohammed al-Julani', 26, 1, 26),
(31, 'Major', 'Abu Mohammed al-Julani', 26, 1, 26);
-- Tentativa de inserir um 4º chefe na divisão (1,1) do grupo 1 (Divisão com codigo=1)
-- INSERT INTO chefe_militar (codigo, faixa_hierarquica, nome_lider, codigo_lider, numero_divisao, grupo_divisao) VALUES (32, 'Tenente', 'General Norman Schwarzkopf', 1, 1, 1);
-- Isso deve falhar se houver um trigger ou regra de negócio implementada que limita a 3 chefes por divisão.

-- ========================================
-- POPULANDO TRAFICANTE
-- ========================================
INSERT INTO traficante (nome, sobrenome) VALUES
('Viktor', 'Bout'), -- 1
('Leonid', 'Minin'), -- 2
('Monzer', 'al-Kassar'), -- 3
('Sarkis', 'Soghanalian'), -- 4
('Adnan', 'Khashoggi'), -- 5
('Jacques', 'Monsieur'), -- 6
('Heinrich', 'Thomet'), -- 7
('Efraim', 'Diveroli'), -- 8
('David', 'Packouz'), -- 9
('Samuel', 'Cummings'), -- 10
('Gerhard', 'Mertins'); -- 11

-- ========================================
-- POPULANDO TIPO_ARMA
-- Adicionando as armas específicas "Barret M82" e "M200 Intervention"
-- ========================================
INSERT INTO tipo_arma (nome_modelo, capacidade_destrutiva) VALUES
('AK-47', 6.5), -- Capacidade destrutiva arbitrária
('AR-15', 5.8),
('Glock 17', 2.1),
('RPG-7', 7.5),
('FIM-92 Stinger', 9.2),
('T-72', 9.8),
('Javelin', 9.5),
('Barret M82', 8.0),
('M200 intervention', 8.5),
('M4 Carbine', 5.5),
('FN SCAR', 6.0),
('Desert Eagle', 2.5),
('MP5', 3.0),
('M2 Browning', 7.0),
('SVD Dragunov', 7.2),
('AT-4', 6.8),
('C4 Explosivo', 10.0),
('M1 Abrams', 9.9),
('Leopard 2', 9.7),
('M16', 5.7),
('FN FAL', 6.2),
('P-90', 3.5),
('F-16 Fighting Falcon', 9.0),
('MiG-29 Fulcrum', 8.8),
('Tornado IDS', 8.6),
('Boeing AH-64 Apache', 9.1),
('Eurofighter Typhoon', 9.3),
('Granada de Mão M67', 4.0),
('Mina Terrestre PMN-2', 7.0),
('Drone Shahed-136', 6.0),
('M200 Intervention', 8.5);


-- ========================================
-- POPULANDO ARMAS_ESTOQUE
-- Populando estoque inicial para alguns traficantes
-- ========================================
INSERT INTO armas_estoque (codigo_traficante, modelo_arma, qtd_estoque) VALUES
(1, 'AK-47', 1500),
(1, 'Barret M82', 50),
(1, 'RPG-7', 200),
(2, 'AR-15', 1200),
(2, 'Glock 17', 800),
(3, 'M16', 1000),
(3, 'MP5', 600),
(4, 'FN FAL', 900),
(4, 'M200 Intervention', 30),
(5, 'AK-47', 2000),
(5, 'RPG-7', 300),
(6, 'P-90', 400),
(7, 'FIM-92 Stinger', 10),
(8, 'Javelin', 5);

-- ========================================
-- POPULANDO HISTORICO_VENDA_ARMAS
-- Foco nas armas "Barret M82" e "M200 Intervention"
-- E dados diversos para Top 5 Grupos por armas fornecidas
-- ========================================
INSERT INTO historico_venda_armas (codigo_traficante, modelo_arma, codigo_grupo_armado, qtd_vendida) VALUES
-- Vendas para testar armas específicas (Barret M82, M200 Intervention)
(1, 'Barret M82', 1, 5), -- EUA
(1, 'Barret M82', 7, 3), -- Ucrânia
(4, 'M200 Intervention', 5, 2), -- Síria
(4, 'M200 Intervention', 17, 1), -- Sudão
(2, 'AR-15', 1, 50),
(3, 'M16', 5, 80),
(5, 'AK-47', 9, 120),
(5, 'RPG-7', 9, 30),
(1, 'AK-47', 2, 200),
(3, 'MP5', 10, 70),
(4, 'FN FAL', 11, 60),
(5, 'AK-47', 21, 150),
(1, 'RPG-7', 24, 40),
(2, 'Glock 17', 25, 25),
(6, 'P-90', 26, 30),
(7, 'FIM-92 Stinger', 7, 2),
(8, 'Javelin', 7, 1),
(1, 'AK-47', 13, 75),
(2, 'AR-15', 14, 40),
(3, 'M16', 15, 90),
(5, 'AK-47', 16, 110),
(1, 'Barret M82', 6, 7),
(4, 'M200 Intervention', 27, 4),
(10, 'Granada de Mão M67', 19, 500),
(9, 'Mina Terrestre PMN-2', 20, 300),
(8, 'Drone Shahed-136', 7, 10);

-- ========================================
-- POPULANDO DIALOGA
-- IMPORTANTE: Apenas tuplas para líderes que existem na tabela 'lider'
--             (com seus respectivos 'codigo_grupo') foram incluídas para evitar erros de FK.
-- ========================================
INSERT INTO dialoga ("nomeL", "codigoG", "codigoOrg") VALUES
-- Dados baseados nos líderes presentes no DML da tabela 'lider'
('General Benny Gantz', 3, 1),        -- Corrigido: 'Benjamin Gantz' -> 'General Benny Gantz'
('General Maher al-Assad', 5, 1),     -- Corrigido: 'Sergei Shoigu' -> 'General Maher al-Assad' (Líder do Grupo 5)
('General Hossein Salami', 21, 8),    -- Corrigido: codigoG de 6 para 21
('General Qasim Suleimani', 2, 1),    -- Corrigido: 'Mahmoud Abbas' -> 'General Qasim Suleimani' (Líder do Grupo 2)
('General Qasim Suleimani', 2, 8),    -- Corrigido: 'Mahmoud Abbas' -> 'General Qasim Suleimani' (Líder do Grupo 2)
('General Valerii Zaluzhnyi', 7, 1),  -- Corrigido: 'Valerii Zaluzhnyi' -> 'General Valerii Zaluzhnyi'
('General Valerii Zaluzhnyi', 7, 3),  -- Corrigido: 'Valerii Zaluzhnyi' -> 'General Valerii Zaluzhnyi'
('Yasser Arafat', 4, 1),              -- Corrigido: 'Lloyd Austin' -> 'Yasser Arafat' (Líder do Grupo 4)
('Príncipe Mohammed bin Salman', 8, 7);-- Corrigido: 'Ayman al-Zawahiri' -> 'Príncipe Mohammed bin Salman' (Líder do Grupo 8)
