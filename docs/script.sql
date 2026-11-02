/* VACA NA FACA DB */

DROP DATABASE IF EXISTS vaca_na_faca_db;
CREATE DATABASE vaca_na_faca_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;
USE vaca_na_faca_db; 

CREATE TABLE PRODUTO (
    id_produto INT PRIMARY KEY,
    nm_produto VARCHAR(60) NOT NULL,
    ds_produto VARCHAR(200),
    vl_preco DECIMAL(8,2) NOT NULL,
    in_disponivel BOOLEAN NOT NULL,
    tp_categoria VARCHAR(30) NOT NULL
);

CREATE TABLE FORNECEDOR (
    id_fornecedor INT PRIMARY KEY,
    nm_fornecedor VARCHAR(60) NOT NULL,
    qt_prazo_pedido INT NOT NULL,
    tp_vinculo VARCHAR(20) NOT NULL
);

CREATE TABLE FUNCIONARIO (
    id_funcionario INT PRIMARY KEY,
    nm_funcionario VARCHAR(120) NOT NULL,
    tp_cargo VARCHAR(30) NOT NULL,
    dt_admissao DATE NOT NULL,
    tp_perfil_acesso VARCHAR(20) NOT NULL,
    cd_dia_folga CHAR(3) NOT NULL
);

CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY,
    nm_cliente VARCHAR(120) NOT NULL,
    nm_rua VARCHAR(120),
    nu_numero VARCHAR(10),
    nm_bairro VARCHAR(60),
    dt_nascimento DATE,
    dt_cadastro DATE NOT NULL
);

CREATE TABLE INGREDIENTE (
    id_ingrediente INT PRIMARY KEY,
    nm_ingrediente VARCHAR(60) NOT NULL,
    cd_unidade_medida VARCHAR(10) NOT NULL,
    tp_conservacao VARCHAR(20) NOT NULL,
    qt_estoque_minimo DECIMAL(10,3) NOT NULL,
    dt_validade DATE NOT NULL,
    qt_estoque_atual DECIMAL(10,3) NOT NULL
);

CREATE TABLE PEDIDO (
    id_pedido INT PRIMARY KEY,
    dt_hora_pedido DATETIME NOT NULL,
    vl_total DECIMAL(8,2) NOT NULL,
    tp_status_pedido VARCHAR(20) NOT NULL,
    tp_entrega VARCHAR(20) NOT NULL,
    ds_observacao_pedido VARCHAR(200),
    tp_canal_venda VARCHAR(20) NOT NULL,
    id_cliente INT NOT NULL
);

CREATE TABLE COMPRA (
    id_compra INT PRIMARY KEY,
    dt_emissao DATE NOT NULL,
    dt_recebimento DATE,
    id_fornecedor INT NOT NULL
);

CREATE TABLE NF_SAIDA (
    id_nf_saida INT PRIMARY KEY,
    nu_nota VARCHAR(9) NOT NULL,
    nu_serie VARCHAR(3) NOT NULL,
    nu_chave_acesso CHAR(44) NOT NULL UNIQUE,
    dt_emissao_nota DATE NOT NULL,
    id_pedido INT NOT NULL UNIQUE
);

CREATE TABLE CONTA_PAGAR (
    id_conta_pagar INT PRIMARY KEY,
    ds_conta_pagar VARCHAR(100) NOT NULL,
    tp_despesa VARCHAR(20) NOT NULL,
    vl_titulo DECIMAL(8,2) NOT NULL,
    dt_vencimento DATE NOT NULL,
    dt_pagamento DATE,
    id_nf_entrada INT
);

CREATE TABLE NF_ENTRADA (
    id_nf_entrada INT PRIMARY KEY,
    nu_nota VARCHAR(9) NOT NULL,
    nu_serie VARCHAR(3) NOT NULL,
    nu_chave_acesso CHAR(44) NOT NULL UNIQUE,
    dt_emissao_nota DATE NOT NULL,
    id_compra INT NOT NULL UNIQUE
);

CREATE TABLE CONTA_RECEBER (
    id_conta_receber INT PRIMARY KEY,
    tp_forma_pagamento VARCHAR(20) NOT NULL,
    vl_titulo DECIMAL(8,2) NOT NULL,
    dt_vencimento DATE NOT NULL,
    dt_pagamento DATE,
    id_nf_saida INT NOT NULL
);

CREATE TABLE TELEFONE_FORNECEDOR (
    nu_telefone VARCHAR(15),
    id_fornecedor INT,
    PRIMARY KEY (id_fornecedor, nu_telefone)
);

CREATE TABLE DIA_ENTREGA (
    cd_dia_entrega CHAR(3),
    id_fornecedor INT,
    PRIMARY KEY (cd_dia_entrega, id_fornecedor)
);

CREATE TABLE TELEFONE_CLIENTE (
    nu_telefone VARCHAR(15),
    id_cliente INT,
    PRIMARY KEY (nu_telefone, id_cliente)
);

CREATE TABLE ITEM_PEDIDO (
    id_produto INT,
    id_pedido INT,
    qt_item INT NOT NULL,
    vl_unitario DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id_produto, id_pedido)
);

CREATE TABLE UTILIZA (
    id_produto INT,
    id_ingrediente INT,
    qt_utilizada DECIMAL(10,3) NOT NULL,
    PRIMARY KEY (id_produto, id_ingrediente)
);

CREATE TABLE INCLUI (
    id_ingrediente INT,
    id_compra INT,
    qt_comprada DECIMAL(10,3) NOT NULL,
    PRIMARY KEY (id_compra, id_ingrediente)
);

CREATE TABLE TAREFA (
    id_tarefa INT PRIMARY KEY,
    nm_tarefa VARCHAR(60) NOT NULL
);

CREATE TABLE EXECUCAO_TAREFA (
    id_execucao INT PRIMARY KEY,
    dt_hora_inicio DATETIME NOT NULL,
    dt_hora_conclusao DATETIME,
    id_tarefa INT NOT NULL,
    id_funcionario INT NOT NULL
);

CREATE TABLE TREINA (
    id_funcionario INT,
    id_praca INT,
    dt_inicio_treino DATE NOT NULL,
    dt_habilitacao DATE,
    PRIMARY KEY (id_funcionario, id_praca)
);

CREATE TABLE PRACA (
    id_praca INT PRIMARY KEY,
    nm_praca VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE ETAPA_PEDIDO (
    id_etapa INT PRIMARY KEY,
    in_erro BOOLEAN NOT NULL DEFAULT FALSE,
    id_pedido INT NOT NULL,
    id_funcionario INT NOT NULL,
    id_praca INT NOT NULL
);

ALTER TABLE PEDIDO ADD CONSTRAINT FK_PEDIDO_2
    FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE (id_cliente);
 
ALTER TABLE COMPRA ADD CONSTRAINT FK_COMPRA_2
    FOREIGN KEY (id_fornecedor)
    REFERENCES FORNECEDOR (id_fornecedor);
 
ALTER TABLE NF_SAIDA ADD CONSTRAINT FK_NF_SAIDA_2
    FOREIGN KEY (id_pedido)
    REFERENCES PEDIDO (id_pedido);
 
ALTER TABLE CONTA_PAGAR ADD CONSTRAINT FK_CONTA_PAGAR_2
    FOREIGN KEY (id_nf_entrada)
    REFERENCES NF_ENTRADA (id_nf_entrada);
 
ALTER TABLE NF_ENTRADA ADD CONSTRAINT FK_NF_ENTRADA_2
    FOREIGN KEY (id_compra)
    REFERENCES COMPRA (id_compra);
 
ALTER TABLE CONTA_RECEBER ADD CONSTRAINT FK_CONTA_RECEBER_2
    FOREIGN KEY (id_nf_saida)
    REFERENCES NF_SAIDA (id_nf_saida);
 
ALTER TABLE TELEFONE_FORNECEDOR ADD CONSTRAINT FK_TELEFONE_FORNECEDOR_1
    FOREIGN KEY (id_fornecedor)
    REFERENCES FORNECEDOR (id_fornecedor);
 
ALTER TABLE DIA_ENTREGA ADD CONSTRAINT FK_DIA_ENTREGA_2
    FOREIGN KEY (id_fornecedor)
    REFERENCES FORNECEDOR (id_fornecedor);
 
ALTER TABLE TELEFONE_CLIENTE ADD CONSTRAINT FK_TELEFONE_CLIENTE_2
    FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE (id_cliente);
 
ALTER TABLE ITEM_PEDIDO ADD CONSTRAINT FK_ITEM_PEDIDO_2
    FOREIGN KEY (id_produto)
    REFERENCES PRODUTO (id_produto);
 
ALTER TABLE ITEM_PEDIDO ADD CONSTRAINT FK_ITEM_PEDIDO_3
    FOREIGN KEY (id_pedido)
    REFERENCES PEDIDO (id_pedido);
 
ALTER TABLE UTILIZA ADD CONSTRAINT FK_UTILIZA_1
    FOREIGN KEY (id_produto)
    REFERENCES PRODUTO (id_produto);
 
ALTER TABLE UTILIZA ADD CONSTRAINT FK_UTILIZA_2
    FOREIGN KEY (id_ingrediente)
    REFERENCES INGREDIENTE (id_ingrediente);
 
ALTER TABLE INCLUI ADD CONSTRAINT FK_INCLUI_1
    FOREIGN KEY (id_ingrediente)
    REFERENCES INGREDIENTE (id_ingrediente);
 
ALTER TABLE INCLUI ADD CONSTRAINT FK_INCLUI_2
    FOREIGN KEY (id_compra)
    REFERENCES COMPRA (id_compra);
 
ALTER TABLE EXECUCAO_TAREFA ADD CONSTRAINT FK_EXECUCAO_TAREFA_2
    FOREIGN KEY (id_tarefa)
    REFERENCES TAREFA (id_tarefa);
 
ALTER TABLE EXECUCAO_TAREFA ADD CONSTRAINT FK_EXECUCAO_TAREFA_3
    FOREIGN KEY (id_funcionario)
    REFERENCES FUNCIONARIO (id_funcionario);
 
ALTER TABLE TREINA ADD CONSTRAINT FK_TREINA_2
    FOREIGN KEY (id_funcionario)
    REFERENCES FUNCIONARIO (id_funcionario);
 
ALTER TABLE TREINA ADD CONSTRAINT FK_TREINA_3
    FOREIGN KEY (id_praca)
    REFERENCES PRACA (id_praca);
 
ALTER TABLE ETAPA_PEDIDO ADD CONSTRAINT FK_ETAPA_PEDIDO_2
    FOREIGN KEY (id_funcionario)
    REFERENCES FUNCIONARIO (id_funcionario);
 
ALTER TABLE ETAPA_PEDIDO ADD CONSTRAINT FK_ETAPA_PEDIDO_3
    FOREIGN KEY (id_pedido)
    REFERENCES PEDIDO (id_pedido);
 
ALTER TABLE ETAPA_PEDIDO ADD CONSTRAINT FK_ETAPA_PEDIDO_4
    FOREIGN KEY (id_praca)
    REFERENCES PRACA (id_praca);

    /* check de validacao */

ALTER TABLE TREINA ADD CONSTRAINT CHK_TREINA_DATAS
    CHECK (dt_habilitacao >= dt_inicio_treino);

ALTER TABLE EXECUCAO_TAREFA ADD CONSTRAINT CHK_EXECUCAO_HORAS
    CHECK (dt_hora_conclusao >= dt_hora_inicio);

ALTER TABLE PEDIDO ADD CONSTRAINT CHK_PEDIDO_STATUS
    CHECK (tp_status_pedido IN ('RECEBIDO', 'EM_PREPARO', 'EM_ROTA', 'ENTREGUE', 'CANCELADO'));

ALTER TABLE PEDIDO ADD CONSTRAINT CHK_PEDIDO_CANAL
    CHECK (tp_canal_venda IN ('MARKETPLACE', 'SITE', 'PRESENCIAL'));

ALTER TABLE FUNCIONARIO ADD CONSTRAINT CHK_FUNCIONARIO_PERFIL
    CHECK (tp_perfil_acesso IN ('ADMIN_MASTER', 'GERENTE', 'COLABORADOR'));

ALTER TABLE CONTA_RECEBER ADD CONSTRAINT CHK_RECEBER_FORMA
    CHECK (tp_forma_pagamento IN ('REPASSE_MARKETPLACE', 'PIX_ONLINE', 'MAQUININHA'));

ALTER TABLE CONTA_PAGAR ADD CONSTRAINT CHK_PAGAR_DESPESA
    CHECK (tp_despesa IN ('MATERIA_PRIMA', 'CUSTO_FIXO'));

ALTER TABLE CONTA_PAGAR ADD CONSTRAINT CHK_PAGAR_NF_MATERIA
    CHECK (id_nf_entrada IS NULL OR tp_despesa = 'MATERIA_PRIMA');


/* massa de dados */

INSERT INTO PRACA(id_praca, nm_praca) VALUES
    (1, 'CHAPA'),
    (2, 'MONTAGEM'),
    (3, 'FRITADEIRA'),
    (4, 'DESPACHO');


INSERT INTO FUNCIONARIO (id_funcionario, nm_funcionario, tp_cargo, dt_admissao, tp_perfil_acesso, cd_dia_folga) VALUES
(1,  'Carlos Menezes',   'SOCIEDADE', '2019-03-01', 'ADMIN_MASTER', 'SEG'),
(2,  'Fernanda Lopes',   'GERENCIA',  '2020-02-10', 'GERENTE',      'TER'),
(3,  'Rafael Teixeira',  'COZINHA',   '2021-06-14', 'COLABORADOR',  'QUA'),
(4,  'Juliana Prado',    'COZINHA',   '2022-09-05', 'COLABORADOR',  'QUI'),
(5,  'Bruno Carvalho',   'COZINHA',   '2024-01-15', 'COLABORADOR',  'SEG'),
(6,  'Camila Nogueira',  'COZINHA',   '2026-08-17', 'COLABORADOR',  'TER'),
(7,  'Diego Ramos',      'COZINHA',   '2026-10-05', 'COLABORADOR',  'QUA'),
(8,  'Patricia Alves',   'BALCAO',    '2023-05-22', 'COLABORADOR',  'QUI'),
(9,  'Lucas Ferraz',     'DESPACHO',  '2025-03-03', 'COLABORADOR',  'SEG'),
(10, 'Aline Moura',      'EXPEDICAO', '2025-08-11', 'COLABORADOR',  'TER'),
(11, 'Tiago Barbosa',    'MOTOBOY',   '2023-11-06', 'COLABORADOR',  'QUA'),
(12, 'Wesley Cunha',     'MOTOBOY',   '2026-04-20', 'COLABORADOR',  'QUI');


INSERT INTO TAREFA (id_tarefa, nm_tarefa) VALUES
(1,  'Abrir a loja e acender a chapa'),
(2,  'Limpar a chapa e a coifa'),
(3,  'Repor molhos e bisnagas'),
(4,  'Fatiar tomate e cebola'),
(5,  'Higienizar as bancadas'),
(6,  'Conferir validade dos insumos'),
(7,  'Receber mercadoria do fornecedor'),
(8,  'Contagem de estoque (checklist)'),
(9,  'Limpar a fritadeira e trocar o oleo'),
(10, 'Fechar o caixa do dia');

INSERT INTO TREINA (id_funcionario, id_praca, dt_inicio_treino, dt_habilitacao) VALUES
(3, 1, '2021-06-14', '2021-07-20'),
(3, 2, '2021-07-21', '2021-07-30'),
(3, 3, '2021-07-31', '2021-08-10'),
(3, 4, '2021-08-11', '2021-08-20'),
(4, 1, '2022-09-05', '2022-10-10'),
(4, 2, '2022-10-11', '2022-10-20'),
(4, 3, '2022-10-21', '2022-11-02'),
(4, 4, '2022-11-03', '2022-11-10'),
(5, 2, '2024-01-15', '2024-01-16'),
(5, 3, '2024-01-17', '2024-01-18'),
(5, 4, '2024-01-19', '2024-01-20'),
(5, 1, '2024-01-21', '2024-03-05'),
(6, 2, '2026-08-17', '2026-08-19'),
(6, 3, '2026-08-20', '2026-08-25'),
(6, 4, '2026-08-26', '2026-09-01'),
(6, 1, '2026-09-02', NULL),
(7, 2, '2026-10-05', '2026-10-08'),
(7, 3, '2026-10-09', NULL),
(9, 4, '2025-03-03', '2025-03-07');

INSERT INTO FORNECEDOR (id_fornecedor, nm_fornecedor, qt_prazo_pedido, tp_vinculo) VALUES
(1, 'Distribuidora Boi Forte',      2, 'FIXO'),
(2, 'Laticinios Vale Verde',        2, 'FIXO'),
(3, 'Hortifruti Sao Jorge',         1, 'FIXO'),
(4, 'Padaria Industrial Pao Dourado', 1, 'FIXO'),
(5, 'Bebidas Central',              2, 'FIXO'),
(6, 'Embalagens Rapido',            3, 'EVENTUAL');

INSERT INTO TELEFONE_FORNECEDOR (id_fornecedor, nu_telefone) VALUES
(1, '(11) 90000-0101'),
(1, '(11) 90000-0102'),
(2, '(11) 90000-0201'),
(3, '(11) 90000-0301'),
(4, '(11) 90000-0401'),
(5, '(11) 90000-0501'),
(5, '(11) 90000-0502'),
(6, '(11) 90000-0601');

INSERT INTO DIA_ENTREGA (id_fornecedor, cd_dia_entrega) VALUES
(1, 'QUI'),
(2, 'QUI'),
(3, 'TER'), (3, 'SEX'),
(4, 'SEG'), (4, 'TER'), (4, 'QUA'), (4, 'QUI'), (4, 'SEX'), (4, 'SAB'),
(5, 'TER'), (5, 'QUI'),
(6, 'QUA');

INSERT INTO CLIENTE (id_cliente, nm_cliente, nm_rua, nu_numero, nm_bairro, dt_nascimento, dt_cadastro) VALUES
(1,  'Ana Beatriz Souza',    'Rua das Acacias',     '120', 'Vila Curuca',    '1994-03-12', '2023-02-14'),
(2,  'Marcelo Pinto',        'Rua Santa Rita',      '45',  'Vila Curuca',    '1988-07-30', '2023-04-02'),
(3,  'Larissa Gomes',        'Avenida do Leste',    '980', 'Jardim Helena',  '2000-11-05', '2023-06-18'),
(4,  'Renato Duarte',        'Rua dos Ipes',        '33A', 'Itaim Paulista', '1991-01-22', '2023-09-09'),
(5,  'Vanessa Cardoso',      'Rua Sao Pedro',       '300', 'Vila Curuca',    '1996-09-14', '2023-11-21'),
(6,  'Gustavo Lima',         'Rua Bela Vista',      '210', 'Vila Curuca',    NULL,         '2024-01-10'),
(7,  'Priscila Andrade',     'Rua do Comercio',     '77',  'Jardim Helena',  '1985-05-27', '2024-02-19'),
(8,  'Otavio Ferreira',      'Rua Esperanca',       '18',  'Itaim Paulista', '1999-12-02', '2024-03-30'),
(9,  'Michele Araujo',       'Avenida do Leste',    '1500','Jardim Helena',  '1992-08-08', '2024-05-06'),
(10, 'Fabio Martins',        'Rua Primavera',       '66',  'Vila Curuca',    '1980-04-19', '2024-06-17'),
(11, 'Debora Campos',        'Rua das Flores',      '402', 'Vila Curuca',    '2001-02-25', '2024-08-01'),
(12, 'Leandro Batista',      'Rua Sao Jose',        '95',  'Itaim Paulista', '1987-10-11', '2024-09-12'),
(13, 'Isabela Rocha',        'Rua Boa Vista',       '12',  'Vila Curuca',    '1998-06-03', '2024-10-28'),
(14, 'Thiago Medeiros',      'Rua Paraiso',         '540', 'Jardim Helena',  NULL,         '2024-12-05'),
(15, 'Natalia Freitas',      'Rua Rio Branco',      '233', 'Vila Curuca',    '1993-01-17', '2025-01-20'),
(16, 'Eduardo Santana',      'Rua Alegria',         '8',   'Itaim Paulista', '1990-03-09', '2025-02-27'),
(17, 'Renata Siqueira',      'Avenida do Leste',    '2210','Jardim Helena',  '1997-07-21', '2025-04-15'),
(18, 'Caio Vasconcelos',     'Rua das Palmeiras',   '151', 'Vila Curuca',    '2002-09-30', '2025-05-23'),
(19, 'Bianca Moreira',       'Rua Nova',            '60',  'Vila Curuca',    '1995-12-14', '2025-07-08'),
(20, 'Alexandre Pires',      'Rua Sete de Setembro','375', 'Itaim Paulista', '1983-02-06', '2025-08-19'),
(21, 'Tatiane Nunes',        'Rua Dom Pedro',       '29',  'Jardim Helena',  '1989-11-28', '2025-09-30'),
(22, 'Rodrigo Azevedo',      'Rua Ceara',           '184', 'Vila Curuca',    '1994-08-16', '2025-11-11'),
(23, 'Sabrina Teixeira',     'Rua Minas Gerais',    '97',  'Vila Curuca',    NULL,         '2026-01-14'),
(24, 'Henrique Barros',      'Rua Bahia',           '412', 'Itaim Paulista', '1986-05-05', '2026-03-03'),
(25, 'Lais Cavalcante',      'Rua Goias',           '50',  'Jardim Helena',  '2003-01-31', '2026-05-26'),
(26, 'Murilo Antunes',       'Rua Parana',          '700', 'Vila Curuca',    '1991-10-23', '2026-08-04'),
(27, 'Jessica Domingues',    NULL,                  NULL,  NULL,             '1999-04-04', '2026-10-23'),
(28, 'Pedro Henrique Lacerda','Rua Pernambuco',     '15',  'Vila Curuca',    '1992-06-20', '2026-10-24'),
(29, 'Cintia Albuquerque',   'Rua Santa Clara',     '321', 'Jardim Helena',  '1988-09-09', '2026-10-23'),
(30, 'Vitor Hugo Prado',     NULL,                  NULL,  NULL,             NULL,         '2026-10-24'),
(31, 'Joana Mendes',         'Rua Maranhao',        '88',  'Itaim Paulista', '1996-03-18', '2026-10-25'),
(32, 'Anderson Leal',        'Rua das Mangueiras',  '640', 'Vila Curuca',    '2000-07-07', '2026-10-25');

INSERT INTO TELEFONE_CLIENTE (id_cliente, nu_telefone) VALUES
(1, '(11) 91000-0001'), (1, '(11) 91000-1001'),
(2, '(11) 91000-0002'),
(3, '(11) 91000-0003'), (3, '(11) 91000-1003'),
(4, '(11) 91000-0004'),
(5, '(11) 91000-0005'),
(6, '(11) 91000-0006'),
(7, '(11) 91000-0007'), (7, '(11) 91000-1007'),
(8, '(11) 91000-0008'),
(9, '(11) 91000-0009'),
(10, '(11) 91000-0010'), (10, '(11) 91000-1010'),
(11, '(11) 91000-0011'),
(12, '(11) 91000-0012'),
(13, '(11) 91000-0013'),
(14, '(11) 91000-0014'),
(15, '(11) 91000-0015'), (15, '(11) 91000-1015'),
(16, '(11) 91000-0016'),
(17, '(11) 91000-0017'),
(18, '(11) 91000-0018'),
(19, '(11) 91000-0019'),
(20, '(11) 91000-0020'),
(21, '(11) 91000-0021'),
(22, '(11) 91000-0022'),
(23, '(11) 91000-0023'),
(24, '(11) 91000-0024'),
(25, '(11) 91000-0025'),
(26, '(11) 91000-0026'),
(27, '(11) 91000-0027'),
(28, '(11) 91000-0028'),
(29, '(11) 91000-0029'),
(30, '(11) 91000-0030'),
(31, '(11) 91000-0031'),
(32, '(11) 91000-0032');

INSERT INTO PRODUTO (id_produto, nm_produto, ds_produto, vl_preco, in_disponivel, tp_categoria) VALUES
(1,  'Vaca na Faca',          'Pao brioche, carne 180 g, queijo prato, alface, tomate, cebola e maionese', 34.90, TRUE,  'HAMBURGUER'),
(2,  'Cheese Burger Classico','Pao brioche, carne 180 g e queijo prato',                                  29.90, TRUE,  'HAMBURGUER'),
(3,  'Bacon Burger',          'Pao brioche, carne 180 g, queijo prato e bacon crocante',                  36.90, TRUE,  'HAMBURGUER'),
(4,  'Duplo da Fazenda',      'Duas carnes de 180 g, queijo prato, alface, tomate e molho especial',      42.90, TRUE,  'HAMBURGUER'),
(5,  'Frango Crocante',       'Pao brioche, frango empanado, alface, tomate e maionese',                  31.90, TRUE,  'HAMBURGUER'),
(6,  'Veggie Burger',         'Pao brioche, hamburguer vegetal, alface, tomate e maionese',               33.90, TRUE,  'HAMBURGUER'),
(7,  'Combo Individual',      'Um hamburguer da casa, batata frita e refrigerante lata',                  49.90, TRUE,  'COMBO'),
(8,  'Combo Casal',           'Dois hamburgueres, batata frita grande e duas bebidas',                    89.90, TRUE,  'COMBO'),
(9,  'Combo Familia',         'Quatro hamburgueres, duas batatas, nuggets e refrigerante 2 litros',      139.90, TRUE,  'COMBO'),
(10, 'Batata Frita',          'Porcao de batata frita crocante',                                          18.90, TRUE,  'APERITIVO'),
(11, 'Onion Rings',           'Porcao de aneis de cebola empanados',                                      21.90, FALSE, 'APERITIVO'),
(12, 'Nuggets (10 un)',       'Dez nuggets de frango com molho',                                          22.90, TRUE,  'APERITIVO'),
(13, 'Refrigerante Lata',     NULL,                                                                        7.00, TRUE,  'BEBIDA'),
(14, 'Agua Mineral',          NULL,                                                                        4.50, TRUE,  'BEBIDA'),
(15, 'Suco de Laranja',       'Suco natural de laranja 300 ml',                                            9.90, TRUE,  'BEBIDA'),
(16, 'Cerveja Long Neck',     NULL,                                                                       12.90, TRUE,  'BEBIDA'),
(17, 'Energetico Lata',       NULL,                                                                       11.90, TRUE,  'BEBIDA'),
(18, 'Refrigerante 2 Litros', NULL,                                                                       14.90, TRUE,  'BEBIDA');

INSERT INTO INGREDIENTE (id_ingrediente, nm_ingrediente, cd_unidade_medida, tp_conservacao, qt_estoque_minimo, dt_validade, qt_estoque_atual) VALUES
(1,  'Pao brioche',               'UN', 'AMBIENTE',   60.000, '2026-10-29', 150.000),
(2,  'Carne bovina 180 g',        'UN', 'CONGELADO', 120.000, '2026-11-20', 310.000),
(3,  'Queijo prato fatiado',      'KG', 'REFRIGERADO', 12.000, '2026-11-06',  14.500),
(4,  'Alface',                    'KG', 'REFRIGERADO',  6.000, '2026-10-28',   4.200),
(5,  'Tomate',                    'KG', 'REFRIGERADO',  8.000, '2026-10-30',  11.000),
(6,  'Cebola',                    'KG', 'AMBIENTE',     6.000, '2026-11-15',   9.000),
(7,  'Maionese em bisnaga',       'KG', 'REFRIGERADO',  5.000, '2026-12-01',   6.500),
(8,  'Bacon fatiado',             'KG', 'REFRIGERADO',  8.000, '2026-11-10',   7.500),
(9,  'Batata congelada',          'KG', 'CONGELADO',   40.000, '2027-02-01',  55.000),
(10, 'Frango empanado',           'UN', 'CONGELADO',   40.000, '2027-01-10',  80.000),
(11, 'Hamburguer vegetal',        'UN', 'CONGELADO',   20.000, '2027-01-20',  35.000),
(12, 'Aneis de cebola congelados','KG', 'CONGELADO',    8.000, '2027-01-05',   2.000),
(13, 'Nuggets congelados',        'KG', 'CONGELADO',   10.000, '2027-01-15',  16.000),
(14, 'Molho especial',            'KG', 'REFRIGERADO',  3.000, '2026-11-30',   4.000),
(15, 'Oleo de fritura',           'L',  'AMBIENTE',    30.000, '2027-08-01',  90.000),
(16, 'Refrigerante lata',         'UN', 'AMBIENTE',   120.000, '2027-03-01', 260.000),
(17, 'Agua mineral',              'UN', 'AMBIENTE',    60.000, '2027-06-01', 140.000),
(18, 'Polpa de laranja',          'L',  'CONGELADO',   10.000, '2026-12-20',  14.000),
(19, 'Cerveja long neck',         'UN', 'AMBIENTE',    48.000, '2027-02-01',  96.000),
(20, 'Energetico lata',           'UN', 'AMBIENTE',    36.000, '2027-04-01',  40.000),
(21, 'Refrigerante 2 litros',     'UN', 'AMBIENTE',    24.000, '2027-03-01',  20.000),
(22, 'Caixa de embalagem',        'UN', 'AMBIENTE',   200.000, '2028-01-01', 450.000);

INSERT INTO UTILIZA (id_produto, id_ingrediente, qt_utilizada) VALUES
/* 1 Vaca na Faca */
(1, 1, 1.000), (1, 2, 1.000), (1, 3, 0.030), (1, 4, 0.020), (1, 5, 0.030), (1, 6, 0.015), (1, 7, 0.030), (1, 22, 1.000),
/* 2 Cheese Burger Classico */
(2, 1, 1.000), (2, 2, 1.000), (2, 3, 0.030), (2, 22, 1.000),
/* 3 Bacon Burger */
(3, 1, 1.000), (3, 2, 1.000), (3, 3, 0.030), (3, 8, 0.025), (3, 22, 1.000),
/* 4 Duplo da Fazenda */
(4, 1, 1.000), (4, 2, 2.000), (4, 3, 0.060), (4, 4, 0.020), (4, 5, 0.030), (4, 14, 0.030), (4, 22, 1.000),
/* 5 Frango Crocante */
(5, 1, 1.000), (5, 10, 1.000), (5, 4, 0.020), (5, 5, 0.030), (5, 7, 0.030), (5, 22, 1.000),
/* 6 Veggie Burger */
(6, 1, 1.000), (6, 11, 1.000), (6, 4, 0.020), (6, 5, 0.030), (6, 7, 0.030), (6, 22, 1.000),
/* 7 Combo Individual */
(7, 1, 1.000), (7, 2, 1.000), (7, 3, 0.030), (7, 9, 0.200), (7, 16, 1.000), (7, 22, 1.000),
/* 8 Combo Casal */
(8, 1, 2.000), (8, 2, 2.000), (8, 3, 0.060), (8, 9, 0.400), (8, 16, 2.000), (8, 22, 2.000),
/* 9 Combo Familia */
(9, 1, 4.000), (9, 2, 4.000), (9, 3, 0.120), (9, 9, 0.600), (9, 13, 0.300), (9, 21, 1.000), (9, 22, 4.000),
/* 10 Batata Frita */
(10, 9, 0.250), (10, 15, 0.100), (10, 22, 1.000),
/* 11 Onion Rings */
(11, 12, 0.200), (11, 15, 0.100), (11, 22, 1.000),
/* 12 Nuggets */
(12, 13, 0.200), (12, 14, 0.030), (12, 15, 0.100), (12, 22, 1.000),
/* 13 a 18: bebidas revendidas, ligadas 1 a 1 ao proprio estoque */
(13, 16, 1.000), (14, 17, 1.000), (15, 18, 0.100), (16, 19, 1.000), (17, 20, 1.000), (18, 21, 1.000);

INSERT INTO COMPRA (id_compra, dt_emissao, dt_recebimento, id_fornecedor) VALUES
(1, '2026-10-14', '2026-10-21', 6),
(2, '2026-10-19', '2026-10-22', 1),
(3, '2026-10-19', '2026-10-22', 2),
(4, '2026-10-20', '2026-10-22', 5),
(5, '2026-10-20', '2026-10-23', 3),
(6, '2026-10-22', '2026-10-23', 4),
(7, '2026-10-26', NULL,         1),
(8, '2026-10-26', NULL,         3),
(9, '2026-10-26', NULL,         5);

INSERT INTO INCLUI (id_ingrediente, id_compra, qt_comprada) VALUES
(22, 1, 500.000),
(8, 2, 15.000), (2, 2, 200.000), (9, 2, 60.000), (10, 2, 60.000),
(3, 3, 30.000),
(16, 4, 240.000), (17, 4, 120.000), (19, 4, 96.000), (20, 4, 48.000),
(4, 5, 10.000), (5, 5, 15.000), (6, 5, 10.000),
(1, 6, 300.000),
(8, 7, 20.000), (12, 7, 20.000), (9, 7, 60.000),
(4, 8, 10.000),
(21, 9, 48.000);

INSERT INTO NF_ENTRADA (id_nf_entrada, nu_nota, nu_serie, nu_chave_acesso, dt_emissao_nota, id_compra) VALUES
(1, '000003187', '001', '35261090000000000601550010000031871418302765', '2026-10-21', 1),
(2, '000025410', '001', '35261090000000000101550010000254101681253908', '2026-10-22', 2),
(3, '000008832', '001', '35261090000000000201550010000088321177405638', '2026-10-22', 3),
(4, '000060215', '002', '35261090000000000501550020000602151309584178', '2026-10-22', 4),
(5, '000001904', '001', '35261090000000000301550010000019041522068145', '2026-10-23', 5),
(6, '000077356', '001', '35261090000000000401550010000773561844190724', '2026-10-23', 6);

INSERT INTO CONTA_PAGAR (id_conta_pagar, ds_conta_pagar, tp_despesa, vl_titulo, dt_vencimento, dt_pagamento, id_nf_entrada) VALUES
(1,  'Boleto embalagens',                    'MATERIA_PRIMA', 450.00,  '2026-10-28', '2026-10-27', 1),
(2,  'Boleto proteinas e batata (1/2)',      'MATERIA_PRIMA', 1080.00, '2026-11-05', NULL,         2),
(3,  'Boleto proteinas e batata (2/2)',      'MATERIA_PRIMA', 1080.00, '2026-11-20', NULL,         2),
(4,  'Boleto queijo',                        'MATERIA_PRIMA', 1080.00, '2026-11-05', NULL,         3),
(5,  'Boleto bebidas',                       'MATERIA_PRIMA', 1548.00, '2026-10-29', NULL,         4),
(6,  'Boleto hortifruti',                    'MATERIA_PRIMA', 235.00,  '2026-10-30', '2026-10-30', 5),
(7,  'Boleto paes',                          'MATERIA_PRIMA', 330.00,  '2026-11-02', NULL,         6),
(8,  'Aluguel de outubro',                   'CUSTO_FIXO',    4800.00, '2026-10-10', '2026-10-09', NULL),
(9,  'Gas de outubro',                       'CUSTO_FIXO',    650.00,  '2026-10-15', '2026-10-15', NULL),
(10, 'Energia eletrica de outubro',          'CUSTO_FIXO',    1480.00, '2026-10-20', '2026-10-19', NULL),
(11, 'Internet de outubro',                  'CUSTO_FIXO',    189.90,  '2026-10-25', NULL,         NULL),
(12, 'Honorarios do contador',               'CUSTO_FIXO',    900.00,  '2026-10-30', '2026-10-29', NULL),
(13, 'Nutricionista',                        'CUSTO_FIXO',    600.00,  '2026-11-05', NULL,         NULL),
(14, 'Marketing e redes sociais',            'CUSTO_FIXO',    1200.00, '2026-11-05', NULL,         NULL);

/* pedidos 1 a 25 */
INSERT INTO PEDIDO (id_pedido, dt_hora_pedido, vl_total, tp_status_pedido, tp_entrega, ds_observacao_pedido, tp_canal_venda, id_cliente) VALUES
(1, '2026-10-23 11:32:00', 150.50, 'ENTREGUE', 'RETIRADA', NULL, 'MARKETPLACE', 5),
(2, '2026-10-23 12:17:00', 61.80, 'ENTREGUE', 'LOCAL', NULL, 'PRESENCIAL', 9),
(3, '2026-10-23 12:28:00', 7.00, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 1),
(4, '2026-10-23 12:51:00', 279.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 23),
(5, '2026-10-23 12:55:00', 44.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 18),
(6, '2026-10-23 13:00:00', 47.52, 'ENTREGUE', 'DELIVERY', 'Sem tomate', 'MARKETPLACE', 1),
(7, '2026-10-23 13:04:00', 66.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 1),
(8, '2026-10-23 13:24:00', 88.83, 'ENTREGUE', 'DELIVERY', 'Capricha no bacon', 'MARKETPLACE', 3),
(9, '2026-10-23 13:26:00', 438.50, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 4),
(10, '2026-10-23 13:35:00', 76.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 3),
(11, '2026-10-23 13:48:00', 7.00, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 23),
(12, '2026-10-23 14:13:00', 65.43, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 2),
(13, '2026-10-23 14:47:00', 77.13, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 9),
(14, '2026-10-23 15:03:00', 110.70, 'CANCELADO', 'DELIVERY', NULL, 'MARKETPLACE', 9),
(15, '2026-10-23 15:06:00', 26.40, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 18),
(16, '2026-10-23 15:06:00', 94.20, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 6),
(17, '2026-10-23 15:15:00', 105.70, 'ENTREGUE', 'LOCAL', NULL, 'PRESENCIAL', 18),
(18, '2026-10-23 15:40:00', 44.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 16),
(19, '2026-10-23 15:47:00', 265.05, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 1),
(20, '2026-10-23 15:48:00', 139.60, 'ENTREGUE', 'LOCAL', 'Entregar na portaria', 'PRESENCIAL', 8),
(21, '2026-10-23 15:58:00', 113.00, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 6),
(22, '2026-10-23 16:01:00', 47.80, 'ENTREGUE', 'DELIVERY', 'Capricha no bacon', 'MARKETPLACE', 7),
(23, '2026-10-23 16:02:00', 53.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 7),
(24, '2026-10-23 16:22:00', 75.70, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 12),
(25, '2026-10-23 16:36:00', 52.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 4);

INSERT INTO ITEM_PEDIDO (id_produto, id_pedido, qt_item, vl_unitario) VALUES
(1, 1, 1, 34.90),
(3, 1, 2, 36.90),
(5, 1, 1, 31.90),
(15, 1, 1, 9.90),
(4, 2, 1, 42.90),
(10, 2, 1, 18.90),
(13, 3, 1, 7.00),
(9, 4, 2, 139.90),
(5, 5, 1, 31.90),
(16, 5, 1, 12.90),
(2, 6, 1, 26.91),
(12, 6, 1, 20.61),
(1, 7, 1, 34.90),
(12, 7, 1, 22.90),
(14, 7, 2, 4.50),
(1, 8, 1, 31.41),
(4, 8, 1, 38.61),
(14, 8, 2, 4.05),
(17, 8, 1, 10.71),
(1, 9, 1, 34.90),
(6, 9, 1, 33.90),
(8, 9, 1, 89.90),
(9, 9, 2, 139.90),
(1, 10, 2, 34.90),
(13, 10, 1, 7.00),
(13, 11, 1, 7.00),
(7, 12, 1, 44.91),
(15, 12, 1, 8.91),
(16, 12, 1, 11.61),
(3, 13, 2, 33.21),
(17, 13, 1, 10.71),
(2, 14, 3, 29.90),
(13, 14, 3, 7.00),
(11, 15, 1, 21.90),
(14, 15, 1, 4.50),
(1, 16, 1, 34.90),
(4, 16, 1, 42.90),
(14, 16, 1, 4.50),
(17, 16, 1, 11.90),
(3, 17, 1, 36.90),
(7, 17, 1, 49.90),
(10, 17, 1, 18.90),
(2, 18, 1, 29.90),
(18, 18, 1, 14.90),
(1, 19, 1, 31.41),
(2, 19, 1, 26.91),
(7, 19, 1, 44.91),
(8, 19, 2, 80.91),
(1, 20, 1, 34.90),
(3, 20, 1, 36.90),
(6, 20, 2, 33.90),
(10, 21, 1, 18.90),
(11, 21, 2, 21.90),
(12, 21, 2, 22.90),
(14, 21, 1, 4.50),
(1, 22, 1, 34.90),
(16, 22, 1, 12.90),
(1, 23, 1, 34.90),
(10, 23, 1, 18.90),
(5, 24, 2, 31.90),
(17, 24, 1, 11.90),
(4, 25, 1, 42.90),
(15, 25, 1, 9.90);

INSERT INTO ETAPA_PEDIDO (id_etapa, in_erro, id_pedido, id_funcionario, id_praca) VALUES
(1, FALSE, 1, 3, 1),
(2, FALSE, 1, 7, 2),
(3, FALSE, 1, 9, 4),
(4, FALSE, 2, 4, 1),
(5, FALSE, 2, 6, 2),
(6, FALSE, 2, 4, 3),
(7, FALSE, 2, 9, 4),
(8, FALSE, 3, 5, 1),
(9, FALSE, 3, 5, 2),
(10, FALSE, 3, 9, 4),
(11, FALSE, 4, 3, 1),
(12, FALSE, 4, 4, 2),
(13, FALSE, 4, 4, 3),
(14, FALSE, 4, 9, 4),
(15, FALSE, 5, 3, 1),
(16, FALSE, 5, 5, 2),
(17, FALSE, 5, 9, 4),
(18, FALSE, 6, 5, 1),
(19, FALSE, 6, 7, 2),
(20, TRUE, 6, 7, 3),
(21, FALSE, 6, 9, 4),
(22, FALSE, 7, 4, 1),
(23, FALSE, 7, 4, 2),
(24, FALSE, 7, 3, 3),
(25, FALSE, 7, 9, 4),
(26, FALSE, 8, 5, 1),
(27, FALSE, 8, 5, 2),
(28, FALSE, 8, 9, 4),
(29, FALSE, 9, 5, 1),
(30, FALSE, 9, 5, 2),
(31, FALSE, 9, 3, 3),
(32, FALSE, 9, 9, 4),
(33, FALSE, 10, 3, 1),
(34, FALSE, 10, 5, 1),
(35, FALSE, 10, 6, 2),
(36, FALSE, 10, 9, 4),
(37, FALSE, 11, 5, 1),
(38, TRUE, 11, 6, 2),
(39, FALSE, 11, 6, 4),
(40, FALSE, 12, 5, 1),
(41, FALSE, 12, 3, 2),
(42, FALSE, 12, 4, 3),
(43, FALSE, 12, 9, 4),
(44, FALSE, 13, 5, 1),
(45, FALSE, 13, 3, 2),
(46, FALSE, 13, 3, 4),
(47, FALSE, 14, 3, 1),
(48, FALSE, 14, 6, 2),
(49, FALSE, 15, 3, 1),
(50, FALSE, 15, 5, 2),
(51, FALSE, 15, 7, 3),
(52, FALSE, 15, 6, 4),
(53, FALSE, 16, 5, 1),
(54, FALSE, 16, 5, 2),
(55, FALSE, 16, 6, 4),
(56, FALSE, 17, 4, 1),
(57, FALSE, 17, 5, 2),
(58, FALSE, 17, 4, 3),
(59, FALSE, 17, 3, 4),
(60, FALSE, 18, 6, 1),
(61, FALSE, 18, 3, 2),
(62, FALSE, 18, 9, 4),
(63, FALSE, 19, 5, 1),
(64, FALSE, 19, 7, 2),
(65, FALSE, 19, 7, 3),
(66, FALSE, 19, 9, 4),
(67, FALSE, 20, 3, 1),
(68, FALSE, 20, 5, 2),
(69, FALSE, 20, 9, 4),
(70, FALSE, 21, 4, 1),
(71, FALSE, 21, 6, 2),
(72, FALSE, 21, 3, 3),
(73, FALSE, 21, 5, 4),
(74, FALSE, 22, 5, 1),
(75, FALSE, 22, 5, 2),
(76, FALSE, 22, 9, 4),
(77, FALSE, 23, 5, 1),
(78, FALSE, 23, 7, 2),
(79, FALSE, 23, 7, 3),
(80, FALSE, 23, 3, 4),
(81, FALSE, 24, 5, 1),
(82, FALSE, 24, 7, 2),
(83, FALSE, 24, 9, 4),
(84, FALSE, 25, 5, 1),
(85, FALSE, 25, 5, 2),
(86, FALSE, 25, 4, 4);

INSERT INTO NF_SAIDA (id_nf_saida, nu_nota, nu_serie, nu_chave_acesso, dt_emissao_nota, id_pedido) VALUES
(1, '000001501', '001', '35261090000000009001650010000015011137215650', '2026-10-23', 1),
(2, '000001502', '001', '35261090000000009001650010000015021880343371', '2026-10-23', 2),
(3, '000001503', '001', '35261090000000009001650010000015031605431378', '2026-10-23', 3),
(4, '000001504', '001', '35261090000000009001650010000015041309992031', '2026-10-23', 4),
(5, '000001505', '001', '35261090000000009001650010000015051776792884', '2026-10-23', 5),
(6, '000001506', '001', '35261090000000009001650010000015061757898610', '2026-10-23', 6),
(7, '000001507', '001', '35261090000000009001650010000015071573253495', '2026-10-23', 7),
(8, '000001508', '001', '35261090000000009001650010000015081380084834', '2026-10-23', 8),
(9, '000001509', '001', '35261090000000009001650010000015091691303446', '2026-10-23', 9),
(10, '000001510', '001', '35261090000000009001650010000015101841573304', '2026-10-23', 10),
(11, '000001511', '001', '35261090000000009001650010000015111570409977', '2026-10-23', 11),
(12, '000001512', '001', '35261090000000009001650010000015121248037673', '2026-10-23', 12),
(13, '000001513', '001', '35261090000000009001650010000015131684773710', '2026-10-23', 13),
(14, '000001514', '001', '35261090000000009001650010000015141953945687', '2026-10-23', 15),
(15, '000001515', '001', '35261090000000009001650010000015151467287910', '2026-10-23', 16),
(16, '000001516', '001', '35261090000000009001650010000015161137767222', '2026-10-23', 17),
(17, '000001517', '001', '35261090000000009001650010000015171315709638', '2026-10-23', 18),
(18, '000001518', '001', '35261090000000009001650010000015181978603797', '2026-10-23', 19),
(19, '000001519', '001', '35261090000000009001650010000015191879435435', '2026-10-23', 20),
(20, '000001520', '001', '35261090000000009001650010000015201442686454', '2026-10-23', 21),
(21, '000001521', '001', '35261090000000009001650010000015211353231629', '2026-10-23', 22),
(22, '000001522', '001', '35261090000000009001650010000015221436955974', '2026-10-23', 23),
(23, '000001523', '001', '35261090000000009001650010000015231747646709', '2026-10-23', 24),
(24, '000001524', '001', '35261090000000009001650010000015241909496747', '2026-10-23', 25);

INSERT INTO CONTA_RECEBER (id_conta_receber, tp_forma_pagamento, vl_titulo, dt_vencimento, dt_pagamento, id_nf_saida) VALUES
(1, 'REPASSE_MARKETPLACE', 132.44, '2026-10-30', '2026-10-30', 1),
(2, 'PIX_ONLINE', 61.80, '2026-10-23', '2026-10-23', 2),
(3, 'REPASSE_MARKETPLACE', 6.16, '2026-10-30', '2026-10-30', 3),
(4, 'REPASSE_MARKETPLACE', 246.22, '2026-10-30', '2026-10-30', 4),
(5, 'REPASSE_MARKETPLACE', 39.42, '2026-10-30', '2026-10-30', 5),
(6, 'REPASSE_MARKETPLACE', 41.82, '2026-10-30', '2026-10-30', 6),
(7, 'REPASSE_MARKETPLACE', 58.78, '2026-10-30', '2026-10-30', 7),
(8, 'REPASSE_MARKETPLACE', 78.17, '2026-10-30', '2026-10-30', 8),
(9, 'REPASSE_MARKETPLACE', 385.88, '2026-10-30', '2026-10-30', 9),
(10, 'REPASSE_MARKETPLACE', 67.58, '2026-10-30', '2026-10-30', 10),
(11, 'REPASSE_MARKETPLACE', 6.16, '2026-10-30', '2026-10-30', 11),
(12, 'REPASSE_MARKETPLACE', 57.58, '2026-10-30', '2026-10-30', 12),
(13, 'REPASSE_MARKETPLACE', 67.87, '2026-10-30', '2026-10-30', 13),
(14, 'REPASSE_MARKETPLACE', 23.23, '2026-10-30', '2026-10-30', 14),
(15, 'REPASSE_MARKETPLACE', 82.90, '2026-10-30', '2026-10-30', 15),
(16, 'MAQUININHA', 105.70, '2026-10-23', '2026-10-23', 16),
(17, 'REPASSE_MARKETPLACE', 39.42, '2026-10-30', '2026-10-30', 17),
(18, 'REPASSE_MARKETPLACE', 233.24, '2026-10-30', '2026-10-30', 18),
(19, 'MAQUININHA', 139.60, '2026-10-23', '2026-10-23', 19),
(20, 'REPASSE_MARKETPLACE', 99.44, '2026-10-30', '2026-10-30', 20),
(21, 'REPASSE_MARKETPLACE', 42.06, '2026-10-30', '2026-10-30', 21),
(22, 'REPASSE_MARKETPLACE', 47.34, '2026-10-30', '2026-10-30', 22),
(23, 'REPASSE_MARKETPLACE', 66.62, '2026-10-30', '2026-10-30', 23),
(24, 'REPASSE_MARKETPLACE', 46.46, '2026-10-30', '2026-10-30', 24);

/* pedidos 51 a 100 (sabado e domingo) */
INSERT INTO PEDIDO (id_pedido, dt_hora_pedido, vl_total, tp_status_pedido, tp_entrega, ds_observacao_pedido, tp_canal_venda, id_cliente) VALUES
(26, '2026-10-23 17:00:00', 37.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 26),
(27, '2026-10-23 17:58:00', 33.90, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 14),
(28, '2026-10-23 18:07:00', 322.50, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 3),
(29, '2026-10-23 18:15:00', 87.21, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 4),
(30, '2026-10-23 18:17:00', 95.94, 'ENTREGUE', 'DELIVERY', 'Sem tomate', 'MARKETPLACE', 10),
(31, '2026-10-23 18:28:00', 85.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 11),
(32, '2026-10-23 18:44:00', 62.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 23),
(33, '2026-10-23 19:01:00', 93.70, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 8),
(34, '2026-10-23 19:02:00', 127.60, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 14),
(35, '2026-10-23 19:13:00', 4.50, 'ENTREGUE', 'LOCAL', NULL, 'PRESENCIAL', 9),
(36, '2026-10-23 19:14:00', 80.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 20),
(37, '2026-10-23 19:21:00', 89.50, 'ENTREGUE', 'RETIRADA', NULL, 'MARKETPLACE', 27),
(38, '2026-10-23 19:26:00', 34.90, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 9),
(39, '2026-10-23 19:30:00', 37.80, 'ENTREGUE', 'RETIRADA', NULL, 'MARKETPLACE', 27),
(40, '2026-10-23 19:34:00', 143.70, 'ENTREGUE', 'DELIVERY', 'Sem tomate', 'MARKETPLACE', 17),
(41, '2026-10-23 19:40:00', 32.76, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 16),
(42, '2026-10-23 19:43:00', 253.60, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 2),
(43, '2026-10-23 19:44:00', 66.42, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 21),
(44, '2026-10-23 19:47:00', 56.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 5),
(45, '2026-10-23 19:48:00', 241.60, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 4),
(46, '2026-10-23 19:49:00', 124.60, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 7),
(47, '2026-10-23 19:50:00', 96.90, 'ENTREGUE', 'DELIVERY', 'Sem maionese', 'MARKETPLACE', 13),
(48, '2026-10-23 19:51:00', 115.70, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 2),
(49, '2026-10-23 19:52:00', 45.81, 'ENTREGUE', 'DELIVERY', 'Cortar o lanche ao meio', 'MARKETPLACE', 1),
(50, '2026-10-23 19:55:00', 133.60, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 24);

INSERT INTO ITEM_PEDIDO (id_produto, id_pedido, qt_item, vl_unitario) VALUES
(10, 26, 2, 18.90),
(6, 27, 1, 33.90),
(4, 28, 1, 42.90),
(8, 28, 3, 89.90),
(15, 28, 1, 9.90),
(8, 29, 1, 80.91),
(13, 29, 1, 6.30),
(6, 30, 1, 30.51),
(7, 30, 1, 44.91),
(15, 30, 1, 8.91),
(16, 30, 1, 11.61),
(4, 31, 2, 42.90),
(7, 32, 1, 49.90),
(16, 32, 1, 12.90),
(1, 33, 1, 34.90),
(3, 33, 1, 36.90),
(11, 33, 1, 21.90),
(1, 34, 1, 34.90),
(3, 34, 1, 36.90),
(4, 34, 1, 42.90),
(16, 34, 1, 12.90),
(14, 35, 1, 4.50),
(3, 36, 2, 36.90),
(13, 36, 1, 7.00),
(11, 37, 3, 21.90),
(17, 37, 2, 11.90),
(1, 38, 1, 34.90),
(10, 39, 2, 18.90),
(3, 40, 1, 36.90),
(7, 40, 2, 49.90),
(13, 40, 1, 7.00),
(5, 41, 1, 28.71),
(14, 41, 1, 4.05),
(3, 42, 2, 36.90),
(8, 42, 2, 89.90),
(3, 43, 1, 33.21),
(12, 43, 1, 20.61),
(13, 43, 2, 6.30),
(1, 44, 1, 34.90),
(11, 44, 1, 21.90),
(2, 45, 1, 29.90),
(7, 45, 1, 49.90),
(9, 45, 1, 139.90),
(11, 45, 1, 21.90),
(2, 46, 1, 29.90),
(4, 46, 1, 42.90),
(10, 46, 2, 18.90),
(13, 46, 2, 7.00),
(8, 47, 1, 89.90),
(13, 47, 1, 7.00),
(5, 48, 1, 31.90),
(6, 48, 1, 33.90),
(7, 48, 1, 49.90),
(3, 49, 1, 33.21),
(13, 49, 2, 6.30),
(7, 50, 2, 49.90),
(10, 50, 1, 18.90),
(18, 50, 1, 14.90);

INSERT INTO ETAPA_PEDIDO (id_etapa, in_erro, id_pedido, id_funcionario, id_praca) VALUES
(87, FALSE, 26, 5, 1),
(88, FALSE, 26, 5, 2),
(89, FALSE, 26, 3, 3),
(90, FALSE, 26, 5, 4),
(91, FALSE, 27, 5, 1),
(92, FALSE, 27, 3, 2),
(93, FALSE, 27, 9, 4),
(94, FALSE, 28, 3, 1),
(95, FALSE, 28, 4, 2),
(96, FALSE, 28, 4, 3),
(97, FALSE, 28, 9, 4),
(98, FALSE, 29, 5, 1),
(99, TRUE, 29, 6, 1),
(100, TRUE, 29, 6, 2),
(101, FALSE, 29, 6, 3),
(102, FALSE, 29, 9, 4),
(103, FALSE, 30, 4, 1),
(104, FALSE, 30, 6, 2),
(105, FALSE, 30, 6, 3),
(106, FALSE, 30, 9, 4),
(107, FALSE, 31, 3, 1),
(108, FALSE, 31, 6, 2),
(109, FALSE, 31, 6, 4),
(110, FALSE, 32, 4, 1),
(111, FALSE, 32, 4, 2),
(112, FALSE, 32, 7, 3),
(113, FALSE, 32, 9, 4),
(114, TRUE, 33, 6, 1),
(115, FALSE, 33, 5, 2),
(116, FALSE, 33, 7, 3),
(117, FALSE, 33, 9, 4),
(118, FALSE, 34, 5, 1),
(119, FALSE, 34, 6, 1),
(120, FALSE, 34, 4, 2),
(121, FALSE, 34, 5, 4),
(122, FALSE, 35, 3, 1),
(123, FALSE, 35, 3, 2),
(124, FALSE, 35, 9, 4),
(125, FALSE, 36, 3, 1),
(126, FALSE, 36, 7, 2),
(127, FALSE, 36, 9, 4),
(128, FALSE, 37, 5, 1),
(129, FALSE, 37, 3, 2),
(130, FALSE, 37, 7, 3),
(131, FALSE, 37, 5, 4),
(132, FALSE, 38, 4, 1),
(133, FALSE, 38, 6, 2),
(134, FALSE, 38, 9, 4),
(135, FALSE, 39, 4, 1),
(136, FALSE, 39, 7, 2),
(137, FALSE, 39, 6, 3),
(138, FALSE, 39, 9, 4),
(139, FALSE, 40, 5, 1),
(140, FALSE, 40, 7, 2),
(141, FALSE, 40, 4, 3),
(142, FALSE, 40, 4, 4),
(143, FALSE, 41, 3, 1),
(144, FALSE, 41, 5, 2),
(145, FALSE, 41, 3, 4),
(146, FALSE, 42, 6, 1),
(147, FALSE, 42, 5, 2),
(148, FALSE, 42, 4, 3),
(149, FALSE, 42, 9, 4),
(150, FALSE, 43, 5, 1),
(151, FALSE, 43, 3, 2),
(152, FALSE, 43, 6, 3),
(153, FALSE, 43, 6, 4),
(154, FALSE, 44, 5, 1),
(155, FALSE, 44, 5, 2),
(156, FALSE, 44, 5, 3),
(157, FALSE, 44, 9, 4),
(158, FALSE, 45, 6, 1),
(159, TRUE, 45, 3, 1),
(160, FALSE, 45, 7, 2),
(161, FALSE, 45, 3, 3),
(162, FALSE, 45, 9, 4),
(163, FALSE, 46, 4, 1),
(164, FALSE, 46, 7, 2),
(165, FALSE, 46, 7, 3),
(166, FALSE, 46, 9, 4),
(167, FALSE, 47, 3, 1),
(168, FALSE, 47, 4, 2),
(169, FALSE, 47, 7, 3),
(170, FALSE, 47, 9, 4),
(171, FALSE, 48, 5, 1),
(172, FALSE, 48, 7, 2),
(173, FALSE, 48, 3, 3),
(174, FALSE, 48, 9, 4),
(175, FALSE, 49, 3, 1),
(176, FALSE, 49, 6, 2),
(177, FALSE, 49, 3, 4),
(178, FALSE, 50, 5, 1),
(179, FALSE, 50, 3, 2),
(180, TRUE, 50, 5, 3),
(181, FALSE, 50, 6, 4);

INSERT INTO NF_SAIDA (id_nf_saida, nu_nota, nu_serie, nu_chave_acesso, dt_emissao_nota, id_pedido) VALUES
(25, '000001525', '001', '35261090000000009001650010000015251988078886', '2026-10-23', 26),
(26, '000001526', '001', '35261090000000009001650010000015261668439087', '2026-10-23', 27),
(27, '000001527', '001', '35261090000000009001650010000015271648612899', '2026-10-23', 28),
(28, '000001528', '001', '35261090000000009001650010000015281211471868', '2026-10-23', 29),
(29, '000001529', '001', '35261090000000009001650010000015291877098756', '2026-10-23', 30),
(30, '000001530', '001', '35261090000000009001650010000015301426656194', '2026-10-23', 31),
(31, '000001531', '001', '35261090000000009001650010000015311958171966', '2026-10-23', 32),
(32, '000001532', '001', '35261090000000009001650010000015321180732030', '2026-10-23', 33),
(33, '000001533', '001', '35261090000000009001650010000015331632540122', '2026-10-23', 34),
(34, '000001534', '001', '35261090000000009001650010000015341617887530', '2026-10-23', 35),
(35, '000001535', '001', '35261090000000009001650010000015351707361836', '2026-10-23', 36),
(36, '000001536', '001', '35261090000000009001650010000015361947051634', '2026-10-23', 37),
(37, '000001537', '001', '35261090000000009001650010000015371735093730', '2026-10-23', 38),
(38, '000001538', '001', '35261090000000009001650010000015381190673323', '2026-10-23', 39),
(39, '000001539', '001', '35261090000000009001650010000015391734673940', '2026-10-23', 40),
(40, '000001540', '001', '35261090000000009001650010000015401213988110', '2026-10-23', 41),
(41, '000001541', '001', '35261090000000009001650010000015411495285306', '2026-10-23', 42),
(42, '000001542', '001', '35261090000000009001650010000015421934642610', '2026-10-23', 43),
(43, '000001543', '001', '35261090000000009001650010000015431733702744', '2026-10-23', 44),
(44, '000001544', '001', '35261090000000009001650010000015441758211873', '2026-10-23', 45),
(45, '000001545', '001', '35261090000000009001650010000015451491927183', '2026-10-23', 46),
(46, '000001546', '001', '35261090000000009001650010000015461310875523', '2026-10-23', 47),
(47, '000001547', '001', '35261090000000009001650010000015471780871858', '2026-10-23', 48),
(48, '000001548', '001', '35261090000000009001650010000015481614421896', '2026-10-23', 49),
(49, '000001549', '001', '35261090000000009001650010000015491553236722', '2026-10-23', 50);

INSERT INTO CONTA_RECEBER (id_conta_receber, tp_forma_pagamento, vl_titulo, dt_vencimento, dt_pagamento, id_nf_saida) VALUES
(25, 'REPASSE_MARKETPLACE', 33.26, '2026-10-30', '2026-10-30', 25),
(26, 'REPASSE_MARKETPLACE', 29.83, '2026-10-30', '2026-10-30', 26),
(27, 'REPASSE_MARKETPLACE', 283.80, '2026-10-30', '2026-10-30', 27),
(28, 'REPASSE_MARKETPLACE', 76.74, '2026-10-30', '2026-10-30', 28),
(29, 'REPASSE_MARKETPLACE', 84.43, '2026-10-30', '2026-10-30', 29),
(30, 'REPASSE_MARKETPLACE', 75.50, '2026-10-30', '2026-10-30', 30),
(31, 'REPASSE_MARKETPLACE', 55.26, '2026-10-30', '2026-10-30', 31),
(32, 'REPASSE_MARKETPLACE', 82.46, '2026-10-30', '2026-10-30', 32),
(33, 'REPASSE_MARKETPLACE', 112.29, '2026-10-30', '2026-10-30', 33),
(34, 'PIX_ONLINE', 4.50, '2026-10-23', '2026-10-23', 34),
(35, 'REPASSE_MARKETPLACE', 71.10, '2026-10-30', '2026-10-30', 35),
(36, 'REPASSE_MARKETPLACE', 78.76, '2026-10-30', '2026-10-30', 36),
(37, 'REPASSE_MARKETPLACE', 30.71, '2026-10-30', '2026-10-30', 37),
(38, 'REPASSE_MARKETPLACE', 33.26, '2026-10-30', '2026-10-30', 38),
(39, 'REPASSE_MARKETPLACE', 126.46, '2026-10-30', '2026-10-30', 39),
(40, 'REPASSE_MARKETPLACE', 28.83, '2026-10-30', '2026-10-30', 40),
(41, 'REPASSE_MARKETPLACE', 223.17, '2026-10-30', '2026-10-30', 41),
(42, 'REPASSE_MARKETPLACE', 58.45, '2026-10-30', '2026-10-30', 42),
(43, 'REPASSE_MARKETPLACE', 49.98, '2026-10-30', '2026-10-30', 43),
(44, 'REPASSE_MARKETPLACE', 212.61, '2026-10-30', '2026-10-30', 44),
(45, 'REPASSE_MARKETPLACE', 109.65, '2026-10-30', '2026-10-30', 45),
(46, 'REPASSE_MARKETPLACE', 85.27, '2026-10-30', '2026-10-30', 46),
(47, 'REPASSE_MARKETPLACE', 101.82, '2026-10-30', '2026-10-30', 47),
(48, 'REPASSE_MARKETPLACE', 40.31, '2026-10-30', '2026-10-30', 48),
(49, 'REPASSE_MARKETPLACE', 117.57, '2026-10-30', '2026-10-30', 49);

/* lote 11: pedidos 51 a 100 (sabado e domingo) */
INSERT INTO PEDIDO (id_pedido, dt_hora_pedido, vl_total, tp_status_pedido, tp_entrega, ds_observacao_pedido, tp_canal_venda, id_cliente) VALUES
(51, '2026-10-24 11:31:00', 160.50, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 3),
(52, '2026-10-24 11:58:00', 73.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 2),
(53, '2026-10-24 12:24:00', 120.50, 'ENTREGUE', 'DELIVERY', 'Capricha no bacon', 'MARKETPLACE', 2),
(54, '2026-10-24 13:08:00', 75.33, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 10),
(55, '2026-10-24 13:27:00', 85.80, 'ENTREGUE', 'LOCAL', NULL, 'PRESENCIAL', 16),
(56, '2026-10-24 13:35:00', 163.60, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 8),
(57, '2026-10-24 14:03:00', 36.90, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 1),
(58, '2026-10-24 14:47:00', 6.30, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 19),
(59, '2026-10-24 15:26:00', 7.00, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 12),
(60, '2026-10-24 17:21:00', 191.60, 'CANCELADO', 'DELIVERY', NULL, 'MARKETPLACE', 1),
(61, '2026-10-24 17:25:00', 33.90, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 11),
(62, '2026-10-24 17:26:00', 23.31, 'ENTREGUE', 'RETIRADA', 'Entregar na portaria', 'MARKETPLACE', 9),
(63, '2026-10-24 18:29:00', 126.70, 'ENTREGUE', 'RETIRADA', NULL, 'MARKETPLACE', 28),
(64, '2026-10-24 18:35:00', 81.80, 'ENTREGUE', 'LOCAL', NULL, 'PRESENCIAL', 3),
(65, '2026-10-24 19:28:00', 169.65, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 15),
(66, '2026-10-24 20:36:00', 209.70, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 1),
(67, '2026-10-24 20:40:00', 48.80, 'ENTREGUE', 'LOCAL', NULL, 'PRESENCIAL', 16),
(68, '2026-10-24 20:55:00', 74.07, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 8),
(69, '2026-10-24 21:29:00', 119.70, 'ENTREGUE', 'DELIVERY', 'Sem maionese', 'MARKETPLACE', 19),
(70, '2026-10-24 21:31:00', 73.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 18),
(71, '2026-10-24 21:38:00', 62.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 24),
(72, '2026-10-24 21:45:00', 68.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 17),
(73, '2026-10-24 21:57:00', 61.70, 'ENTREGUE', 'DELIVERY', 'Cortar o lanche ao meio', 'MARKETPLACE', 6),
(74, '2026-10-24 22:10:00', 4.50, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 13),
(75, '2026-10-24 22:51:00', 112.32, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 12),
(76, '2026-10-25 11:34:00', 38.52, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 19),
(77, '2026-10-25 12:01:00', 32.76, 'ENTREGUE', 'RETIRADA', 'Sem cebola', 'MARKETPLACE', 27),
(78, '2026-10-25 13:33:00', 22.90, 'ENTREGUE', 'RETIRADA', NULL, 'MARKETPLACE', 24),
(79, '2026-10-25 14:04:00', 69.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 9),
(80, '2026-10-25 14:11:00', 49.90, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 13),
(81, '2026-10-25 14:22:00', 41.40, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 6),
(82, '2026-10-25 17:38:00', 52.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 10),
(83, '2026-10-25 18:16:00', 76.32, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 4),
(84, '2026-10-25 18:55:00', 7.00, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 2),
(85, '2026-10-25 19:10:00', 65.60, 'CANCELADO', 'RETIRADA', NULL, 'MARKETPLACE', 21),
(86, '2026-10-25 19:14:00', 25.90, 'ENTREGUE', 'DELIVERY', 'Sem cebola', 'MARKETPLACE', 19),
(87, '2026-10-25 19:15:00', 104.60, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 16),
(88, '2026-10-25 19:27:00', 22.90, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 3),
(89, '2026-10-25 19:28:00', 68.80, 'ENTREGUE', 'RETIRADA', NULL, 'MARKETPLACE', 10),
(90, '2026-10-25 19:35:00', 79.74, 'ENTREGUE', 'DELIVERY', 'Entregar na portaria', 'MARKETPLACE', 19),
(91, '2026-10-25 19:49:00', 61.92, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 1),
(92, '2026-10-25 20:06:00', 91.53, 'ENTREGUE', 'RETIRADA', NULL, 'MARKETPLACE', 4),
(93, '2026-10-25 20:19:00', 39.51, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 7),
(94, '2026-10-25 20:23:00', 135.50, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 22),
(95, '2026-10-25 20:45:00', 44.80, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 9),
(96, '2026-10-25 21:05:00', 74.43, 'ENTREGUE', 'DELIVERY', NULL, 'MARKETPLACE', 1),
(97, '2026-10-25 21:15:00', 44.80, 'EM_ROTA', 'LOCAL', NULL, 'PRESENCIAL', 14),
(98, '2026-10-25 21:17:00', 14.90, 'EM_PREPARO', 'DELIVERY', NULL, 'MARKETPLACE', 18),
(99, '2026-10-25 21:41:00', 71.80, 'EM_PREPARO', 'LOCAL', NULL, 'PRESENCIAL', 11),
(100, '2026-10-25 21:48:00', 7.00, 'RECEBIDO', 'DELIVERY', NULL, 'MARKETPLACE', 14);

INSERT INTO ITEM_PEDIDO (id_produto, id_pedido, qt_item, vl_unitario) VALUES
(1, 51, 3, 34.90),
(3, 51, 1, 36.90),
(10, 51, 1, 18.90),
(3, 52, 2, 36.90),
(1, 53, 1, 34.90),
(7, 53, 1, 49.90),
(17, 53, 3, 11.90),
(7, 54, 1, 44.91),
(10, 54, 1, 17.01),
(18, 54, 1, 13.41),
(1, 55, 1, 34.90),
(3, 55, 1, 36.90),
(13, 55, 2, 7.00),
(2, 56, 1, 29.90),
(6, 56, 1, 33.90),
(7, 56, 2, 49.90),
(2, 57, 1, 29.90),
(13, 57, 1, 7.00),
(13, 58, 1, 6.30),
(13, 59, 1, 7.00),
(1, 60, 1, 34.90),
(7, 60, 3, 49.90),
(13, 60, 1, 7.00),
(6, 61, 1, 33.90),
(10, 62, 1, 17.01),
(13, 62, 1, 6.30),
(7, 63, 2, 49.90),
(13, 63, 2, 7.00),
(16, 63, 1, 12.90),
(5, 64, 1, 31.90),
(7, 64, 1, 49.90),
(1, 65, 1, 31.41),
(3, 65, 3, 33.21),
(4, 65, 1, 38.61),
(8, 66, 2, 89.90),
(12, 66, 1, 22.90),
(13, 66, 1, 7.00),
(5, 67, 1, 31.90),
(13, 67, 1, 7.00),
(15, 67, 1, 9.90),
(1, 68, 1, 31.41),
(4, 68, 1, 38.61),
(14, 68, 1, 4.05),
(1, 69, 2, 34.90),
(7, 69, 1, 49.90),
(3, 70, 2, 36.90),
(3, 71, 1, 36.90),
(13, 71, 1, 7.00),
(14, 71, 2, 4.50),
(15, 71, 1, 9.90),
(1, 72, 1, 34.90),
(6, 72, 1, 33.90),
(5, 73, 1, 31.90),
(18, 73, 2, 14.90),
(14, 74, 1, 4.50),
(1, 75, 1, 31.41),
(8, 75, 1, 80.91),
(2, 76, 1, 26.91),
(16, 76, 1, 11.61),
(5, 77, 1, 28.71),
(14, 77, 1, 4.05),
(12, 78, 1, 22.90),
(1, 79, 2, 34.90),
(4, 80, 1, 42.90),
(13, 80, 1, 7.00),
(3, 81, 1, 36.90),
(14, 81, 1, 4.50),
(4, 82, 1, 42.90),
(15, 82, 1, 9.90),
(1, 83, 1, 31.41),
(4, 83, 1, 38.61),
(13, 83, 1, 6.30),
(13, 84, 1, 7.00),
(6, 85, 1, 33.90),
(15, 85, 2, 9.90),
(17, 85, 1, 11.90),
(10, 86, 1, 18.90),
(13, 86, 1, 7.00),
(1, 87, 1, 34.90),
(3, 87, 1, 36.90),
(12, 87, 1, 22.90),
(15, 87, 1, 9.90),
(12, 88, 1, 22.90),
(4, 89, 1, 42.90),
(10, 89, 1, 18.90),
(13, 89, 1, 7.00),
(5, 90, 1, 28.71),
(10, 90, 3, 17.01),
(2, 91, 2, 26.91),
(14, 91, 2, 4.05),
(1, 92, 2, 31.41),
(5, 92, 1, 28.71),
(2, 93, 1, 26.91),
(13, 93, 2, 6.30),
(1, 94, 2, 34.90),
(3, 94, 1, 36.90),
(10, 94, 1, 18.90),
(15, 94, 1, 9.90),
(1, 95, 1, 34.90),
(15, 95, 1, 9.90),
(3, 96, 1, 33.21),
(12, 96, 2, 20.61),
(10, 97, 2, 18.90),
(13, 97, 1, 7.00),
(18, 98, 1, 14.90),
(1, 99, 1, 34.90),
(3, 99, 1, 36.90),
(13, 100, 1, 7.00);

INSERT INTO ETAPA_PEDIDO (id_etapa, in_erro, id_pedido, id_funcionario, id_praca) VALUES
(182, FALSE, 51, 3, 1),
(183, FALSE, 51, 5, 2),
(184, FALSE, 51, 5, 3),
(185, FALSE, 51, 5, 4),
(186, FALSE, 52, 5, 1),
(187, FALSE, 52, 3, 2),
(188, FALSE, 52, 5, 4),
(189, FALSE, 53, 4, 1),
(190, FALSE, 53, 5, 2),
(191, FALSE, 53, 3, 3),
(192, FALSE, 53, 9, 4),
(193, FALSE, 54, 3, 1),
(194, FALSE, 54, 3, 2),
(195, TRUE, 54, 7, 3),
(196, FALSE, 54, 9, 4),
(197, FALSE, 55, 4, 1),
(198, FALSE, 55, 3, 1),
(199, FALSE, 55, 4, 2),
(200, FALSE, 55, 9, 4),
(201, FALSE, 56, 4, 1),
(202, FALSE, 56, 5, 2),
(203, FALSE, 56, 7, 3),
(204, FALSE, 56, 5, 4),
(205, FALSE, 57, 4, 1),
(206, FALSE, 57, 5, 2),
(207, FALSE, 57, 4, 4),
(208, FALSE, 58, 5, 1),
(209, FALSE, 58, 3, 2),
(210, FALSE, 58, 9, 4),
(211, FALSE, 59, 3, 1),
(212, FALSE, 59, 5, 2),
(213, FALSE, 59, 9, 4),
(214, TRUE, 60, 3, 1),
(215, FALSE, 60, 5, 1),
(216, FALSE, 60, 5, 2),
(217, FALSE, 61, 3, 1),
(218, FALSE, 61, 6, 2),
(219, FALSE, 61, 9, 4),
(220, FALSE, 62, 5, 1),
(221, FALSE, 62, 5, 2),
(222, FALSE, 62, 3, 3),
(223, FALSE, 62, 4, 4),
(224, FALSE, 63, 5, 1),
(225, FALSE, 63, 6, 2),
(226, FALSE, 63, 7, 3),
(227, FALSE, 63, 9, 4),
(228, FALSE, 64, 4, 1),
(229, FALSE, 64, 6, 2),
(230, FALSE, 64, 4, 3),
(231, FALSE, 64, 9, 4),
(232, FALSE, 65, 4, 1),
(233, FALSE, 65, 6, 2),
(234, FALSE, 65, 4, 4),
(235, FALSE, 66, 3, 1),
(236, FALSE, 66, 6, 2),
(237, FALSE, 66, 4, 3),
(238, FALSE, 66, 6, 4),
(239, FALSE, 67, 3, 1),
(240, FALSE, 67, 4, 2),
(241, FALSE, 67, 9, 4),
(242, FALSE, 68, 6, 1),
(243, FALSE, 68, 5, 1),
(244, FALSE, 68, 5, 2),
(245, FALSE, 68, 9, 4),
(246, FALSE, 69, 3, 1),
(247, FALSE, 69, 5, 2),
(248, FALSE, 69, 4, 3),
(249, FALSE, 69, 9, 4),
(250, FALSE, 70, 4, 1),
(251, FALSE, 70, 6, 2),
(252, FALSE, 70, 4, 4),
(253, FALSE, 71, 4, 1),
(254, FALSE, 71, 3, 2),
(255, FALSE, 71, 9, 4),
(256, FALSE, 72, 4, 1),
(257, FALSE, 72, 6, 2),
(258, FALSE, 72, 9, 4),
(259, FALSE, 73, 3, 1),
(260, FALSE, 73, 7, 2),
(261, FALSE, 73, 5, 4),
(262, FALSE, 74, 5, 1),
(263, FALSE, 74, 7, 2),
(264, FALSE, 74, 9, 4),
(265, FALSE, 75, 4, 1),
(266, FALSE, 75, 6, 2),
(267, FALSE, 75, 3, 3),
(268, FALSE, 75, 3, 4),
(269, FALSE, 76, 6, 1),
(270, FALSE, 76, 5, 2),
(271, FALSE, 76, 3, 4),
(272, FALSE, 77, 5, 1),
(273, FALSE, 77, 5, 2),
(274, FALSE, 77, 6, 4),
(275, FALSE, 78, 6, 1),
(276, FALSE, 78, 6, 2),
(277, TRUE, 78, 7, 3),
(278, FALSE, 78, 4, 4),
(279, FALSE, 79, 4, 1),
(280, FALSE, 79, 4, 2),
(281, FALSE, 79, 9, 4),
(282, FALSE, 80, 6, 1),
(283, FALSE, 80, 3, 2),
(284, FALSE, 80, 5, 4),
(285, FALSE, 81, 4, 1),
(286, FALSE, 81, 6, 2),
(287, FALSE, 81, 6, 4),
(288, FALSE, 82, 4, 1),
(289, FALSE, 82, 6, 2),
(290, FALSE, 82, 5, 4),
(291, FALSE, 83, 4, 1),
(292, FALSE, 83, 5, 1),
(293, FALSE, 83, 4, 2),
(294, FALSE, 83, 5, 4),
(295, FALSE, 84, 3, 1),
(296, FALSE, 84, 6, 2),
(297, FALSE, 84, 5, 4),
(298, FALSE, 86, 6, 1),
(299, FALSE, 86, 4, 2),
(300, FALSE, 86, 5, 3),
(301, FALSE, 86, 9, 4),
(302, FALSE, 87, 3, 1),
(303, FALSE, 87, 7, 2),
(304, FALSE, 87, 3, 3),
(305, FALSE, 87, 6, 4),
(306, FALSE, 88, 5, 1),
(307, FALSE, 88, 5, 2),
(308, FALSE, 88, 4, 3),
(309, FALSE, 88, 9, 4),
(310, FALSE, 89, 3, 1),
(311, FALSE, 89, 4, 1),
(312, FALSE, 89, 3, 2),
(313, FALSE, 89, 7, 3),
(314, FALSE, 89, 5, 4),
(315, FALSE, 90, 3, 1),
(316, FALSE, 90, 3, 2),
(317, FALSE, 90, 6, 3),
(318, FALSE, 90, 9, 4),
(319, FALSE, 91, 5, 1),
(320, FALSE, 91, 6, 1),
(321, FALSE, 91, 5, 2),
(322, FALSE, 91, 3, 4),
(323, FALSE, 92, 5, 1),
(324, FALSE, 92, 5, 2),
(325, FALSE, 92, 9, 4),
(326, FALSE, 93, 4, 1),
(327, TRUE, 93, 4, 2),
(328, FALSE, 93, 9, 4),
(329, FALSE, 94, 4, 1),
(330, FALSE, 94, 7, 2),
(331, FALSE, 94, 4, 3),
(332, FALSE, 94, 3, 4),
(333, FALSE, 95, 4, 1),
(334, FALSE, 95, 3, 2),
(335, FALSE, 95, 9, 4),
(336, FALSE, 96, 3, 1),
(337, FALSE, 96, 3, 2),
(338, FALSE, 96, 4, 3),
(339, FALSE, 96, 6, 4),
(340, FALSE, 97, 4, 1),
(341, FALSE, 97, 5, 2),
(342, FALSE, 97, 4, 3),
(343, FALSE, 97, 5, 4),
(344, FALSE, 98, 5, 1),
(345, FALSE, 98, 5, 2),
(346, FALSE, 99, 3, 1),
(347, FALSE, 99, 5, 2);

INSERT INTO NF_SAIDA (id_nf_saida, nu_nota, nu_serie, nu_chave_acesso, dt_emissao_nota, id_pedido) VALUES
(50, '000001550', '001', '35261090000000009001650010000015501410948860', '2026-10-24', 51),
(51, '000001551', '001', '35261090000000009001650010000015511815443094', '2026-10-24', 52),
(52, '000001552', '001', '35261090000000009001650010000015521275672550', '2026-10-24', 53),
(53, '000001553', '001', '35261090000000009001650010000015531910719691', '2026-10-24', 54),
(54, '000001554', '001', '35261090000000009001650010000015541159927398', '2026-10-24', 55),
(55, '000001555', '001', '35261090000000009001650010000015551385998923', '2026-10-24', 56),
(56, '000001556', '001', '35261090000000009001650010000015561890487741', '2026-10-24', 57),
(57, '000001557', '001', '35261090000000009001650010000015571559524136', '2026-10-24', 58),
(58, '000001558', '001', '35261090000000009001650010000015581760276095', '2026-10-24', 59),
(59, '000001559', '001', '35261090000000009001650010000015591881481240', '2026-10-24', 61),
(60, '000001560', '001', '35261090000000009001650010000015601173078820', '2026-10-24', 62),
(61, '000001561', '001', '35261090000000009001650010000015611621517870', '2026-10-24', 63),
(62, '000001562', '001', '35261090000000009001650010000015621172636115', '2026-10-24', 64),
(63, '000001563', '001', '35261090000000009001650010000015631802718040', '2026-10-24', 65),
(64, '000001564', '001', '35261090000000009001650010000015641208001607', '2026-10-24', 66),
(65, '000001565', '001', '35261090000000009001650010000015651916199194', '2026-10-24', 67),
(66, '000001566', '001', '35261090000000009001650010000015661112755583', '2026-10-24', 68),
(67, '000001567', '001', '35261090000000009001650010000015671730979771', '2026-10-24', 69),
(68, '000001568', '001', '35261090000000009001650010000015681623726923', '2026-10-24', 70),
(69, '000001569', '001', '35261090000000009001650010000015691136513751', '2026-10-24', 71),
(70, '000001570', '001', '35261090000000009001650010000015701344390005', '2026-10-24', 72),
(71, '000001571', '001', '35261090000000009001650010000015711786803574', '2026-10-24', 73),
(72, '000001572', '001', '35261090000000009001650010000015721163617916', '2026-10-24', 74),
(73, '000001573', '001', '35261090000000009001650010000015731953673424', '2026-10-24', 75),
(74, '000001574', '001', '35261090000000009001650010000015741665834020', '2026-10-25', 76),
(75, '000001575', '001', '35261090000000009001650010000015751356449588', '2026-10-25', 77),
(76, '000001576', '001', '35261090000000009001650010000015761892128768', '2026-10-25', 78),
(77, '000001577', '001', '35261090000000009001650010000015771189673534', '2026-10-25', 79),
(78, '000001578', '001', '35261090000000009001650010000015781175534313', '2026-10-25', 80),
(79, '000001579', '001', '35261090000000009001650010000015791836521931', '2026-10-25', 81),
(80, '000001580', '001', '35261090000000009001650010000015801463909930', '2026-10-25', 82),
(81, '000001581', '001', '35261090000000009001650010000015811269573652', '2026-10-25', 83),
(82, '000001582', '001', '35261090000000009001650010000015821232901084', '2026-10-25', 84),
(83, '000001583', '001', '35261090000000009001650010000015831472531890', '2026-10-25', 86),
(84, '000001584', '001', '35261090000000009001650010000015841145415097', '2026-10-25', 87),
(85, '000001585', '001', '35261090000000009001650010000015851394693586', '2026-10-25', 88),
(86, '000001586', '001', '35261090000000009001650010000015861689284412', '2026-10-25', 89),
(87, '000001587', '001', '35261090000000009001650010000015871253003065', '2026-10-25', 90),
(88, '000001588', '001', '35261090000000009001650010000015881825703803', '2026-10-25', 91),
(89, '000001589', '001', '35261090000000009001650010000015891924973555', '2026-10-25', 92),
(90, '000001590', '001', '35261090000000009001650010000015901289609090', '2026-10-25', 93),
(91, '000001591', '001', '35261090000000009001650010000015911496796314', '2026-10-25', 94),
(92, '000001592', '001', '35261090000000009001650010000015921994360973', '2026-10-25', 95),
(93, '000001593', '001', '35261090000000009001650010000015931624404264', '2026-10-25', 96);

INSERT INTO CONTA_RECEBER (id_conta_receber, tp_forma_pagamento, vl_titulo, dt_vencimento, dt_pagamento, id_nf_saida) VALUES
(50, 'REPASSE_MARKETPLACE', 141.24, '2026-10-31', '2026-10-31', 50),
(51, 'REPASSE_MARKETPLACE', 64.94, '2026-10-31', '2026-10-31', 51),
(52, 'REPASSE_MARKETPLACE', 106.04, '2026-10-31', '2026-10-31', 52),
(53, 'REPASSE_MARKETPLACE', 66.29, '2026-10-31', '2026-10-31', 53),
(54, 'MAQUININHA', 85.80, '2026-10-24', '2026-10-24', 54),
(55, 'REPASSE_MARKETPLACE', 143.97, '2026-10-31', '2026-10-31', 55),
(56, 'REPASSE_MARKETPLACE', 32.47, '2026-10-31', '2026-10-31', 56),
(57, 'REPASSE_MARKETPLACE', 5.54, '2026-10-31', '2026-10-31', 57),
(58, 'REPASSE_MARKETPLACE', 6.16, '2026-10-31', '2026-10-31', 58),
(59, 'REPASSE_MARKETPLACE', 29.83, '2026-10-31', '2026-10-31', 59),
(60, 'REPASSE_MARKETPLACE', 20.51, '2026-10-31', '2026-10-31', 60),
(61, 'REPASSE_MARKETPLACE', 111.50, '2026-10-31', '2026-10-31', 61),
(62, 'MAQUININHA', 81.80, '2026-10-24', '2026-10-24', 62),
(63, 'REPASSE_MARKETPLACE', 149.29, '2026-10-31', '2026-10-31', 63),
(64, 'REPASSE_MARKETPLACE', 184.54, '2026-10-31', '2026-10-31', 64),
(65, 'PIX_ONLINE', 48.80, '2026-10-24', '2026-10-24', 65),
(66, 'REPASSE_MARKETPLACE', 65.18, '2026-10-31', '2026-10-31', 66),
(67, 'REPASSE_MARKETPLACE', 105.34, '2026-10-31', '2026-10-31', 67),
(68, 'REPASSE_MARKETPLACE', 64.94, '2026-10-31', '2026-10-31', 68),
(69, 'REPASSE_MARKETPLACE', 55.26, '2026-10-31', '2026-10-31', 69),
(70, 'REPASSE_MARKETPLACE', 60.54, '2026-10-31', '2026-10-31', 70),
(71, 'REPASSE_MARKETPLACE', 54.30, '2026-10-31', '2026-10-31', 71),
(72, 'REPASSE_MARKETPLACE', 3.96, '2026-10-31', '2026-10-31', 72),
(73, 'REPASSE_MARKETPLACE', 98.84, '2026-10-31', '2026-10-31', 73),
(74, 'REPASSE_MARKETPLACE', 33.90, '2026-11-01', NULL, 74),
(75, 'REPASSE_MARKETPLACE', 28.83, '2026-11-01', NULL, 75),
(76, 'REPASSE_MARKETPLACE', 20.15, '2026-11-01', NULL, 76),
(77, 'REPASSE_MARKETPLACE', 61.42, '2026-11-01', NULL, 77),
(78, 'REPASSE_MARKETPLACE', 43.91, '2026-11-01', NULL, 78),
(79, 'REPASSE_MARKETPLACE', 36.43, '2026-11-01', NULL, 79),
(80, 'REPASSE_MARKETPLACE', 46.46, '2026-11-01', NULL, 80),
(81, 'REPASSE_MARKETPLACE', 67.16, '2026-11-01', NULL, 81),
(82, 'REPASSE_MARKETPLACE', 6.16, '2026-11-01', NULL, 82),
(83, 'REPASSE_MARKETPLACE', 22.79, '2026-11-01', NULL, 83),
(84, 'REPASSE_MARKETPLACE', 92.05, '2026-11-01', NULL, 84),
(85, 'REPASSE_MARKETPLACE', 20.15, '2026-11-01', NULL, 85),
(86, 'REPASSE_MARKETPLACE', 60.54, '2026-11-01', NULL, 86),
(87, 'REPASSE_MARKETPLACE', 70.17, '2026-11-01', NULL, 87),
(88, 'REPASSE_MARKETPLACE', 54.49, '2026-11-01', NULL, 88),
(89, 'REPASSE_MARKETPLACE', 80.55, '2026-11-01', NULL, 89),
(90, 'REPASSE_MARKETPLACE', 34.77, '2026-11-01', NULL, 90),
(91, 'REPASSE_MARKETPLACE', 119.24, '2026-11-01', NULL, 91),
(92, 'REPASSE_MARKETPLACE', 39.42, '2026-11-01', NULL, 92),
(93, 'REPASSE_MARKETPLACE', 65.50, '2026-11-01', NULL, 93);

INSERT INTO EXECUCAO_TAREFA (id_execucao, dt_hora_inicio, dt_hora_conclusao, id_tarefa, id_funcionario) VALUES
(1,  '2026-10-23 10:30:00', '2026-10-23 10:50:00', 1, 3),
(2,  '2026-10-23 10:55:00', '2026-10-23 11:15:00', 4, 6),
(3,  '2026-10-23 11:00:00', '2026-10-23 11:10:00', 3, 7),
(4,  '2026-10-23 11:00:00', '2026-10-23 11:35:00', 7, 4),
(5,  '2026-10-23 15:00:00', '2026-10-23 15:45:00', 6, 5),
(6,  '2026-10-23 20:30:00', '2026-10-23 20:55:00', 2, 3),
(7,  '2026-10-23 20:35:00', NULL,                  9, 7),
(8,  '2026-10-23 20:45:00', '2026-10-23 21:10:00', 10, 2),
(9,  '2026-10-24 10:30:00', '2026-10-24 10:50:00', 1, 4),
(10, '2026-10-24 10:50:00', '2026-10-24 11:20:00', 4, 7),
(11, '2026-10-24 11:00:00', '2026-10-24 11:12:00', 3, 6),
(12, '2026-10-24 10:40:00', '2026-10-24 11:15:00', 7, 5),
(13, '2026-10-24 23:40:00', '2026-10-25 00:05:00', 2, 3),
(14, '2026-10-24 23:40:00', NULL,                  5, 8),
(15, '2026-10-24 23:45:00', '2026-10-25 00:15:00', 10, 2),
(16, '2026-10-25 10:30:00', '2026-10-25 10:48:00', 1, 3),
(17, '2026-10-25 10:50:00', '2026-10-25 11:10:00', 4, 6),
(18, '2026-10-25 11:00:00', '2026-10-25 11:25:00', 3, 7),
(19, '2026-10-25 10:45:00', '2026-10-25 11:20:00', 7, 4),
(20, '2026-10-25 12:00:00', '2026-10-25 12:20:00', 6, 5),
(21, '2026-10-25 16:00:00', '2026-10-25 16:45:00', 8, 2),
(22, '2026-10-25 23:20:00', NULL,                  3, 7);

/* lote 13: dados inconsistentes de propósito, para as consultas de auditoria terem o que mostrar
   pedido 101: total gravado (69.80) diferente da soma dos itens (34.90) -> A01 (RN01)
   pedido 102: ENTREGUE sem nota fiscal de saída nem conta a receber    -> A02 (RN02)
   insumo 23: cadastrado sem fazer parte de nenhum produto              -> A04 (RN04) */
INSERT INTO PEDIDO (id_pedido, dt_hora_pedido, vl_total, tp_status_pedido, tp_entrega, ds_observacao_pedido, tp_canal_venda, id_cliente) VALUES
(101, '2026-10-25 21:10:00', 69.80, 'CANCELADO', 'DELIVERY', NULL, 'MARKETPLACE', 5),
(102, '2026-10-25 21:40:00', 29.90, 'ENTREGUE',  'LOCAL',    NULL, 'PRESENCIAL',  8);

INSERT INTO ITEM_PEDIDO (id_produto, id_pedido, qt_item, vl_unitario) VALUES
(1, 101, 1, 34.90),
(2, 102, 1, 29.90);

INSERT INTO INGREDIENTE (id_ingrediente, nm_ingrediente, cd_unidade_medida, tp_conservacao, qt_estoque_minimo, dt_validade, qt_estoque_atual) VALUES
(23, 'Molho barbecue', 'KG', 'REFRIGERADO', 2.000, '2026-12-15', 3.000);

-- CORRESPONDENCIAS ENTRE TABELAS

/* quais pedidos cada cliente fez, com o nome do cliente*/

SELECT c.nm_cliente, p.id_pedido, p.dt_hora_pedido, p.vl_total, p.tp_entrega, p.tp_status_pedido
FROM PEDIDO p
JOIN CLIENTE c ON p.id_cliente = c.id_cliente
ORDER BY c.nm_cliente, p.dt_hora_pedido;

/* quais produtos tem pedido 1, com quantidade e um subtotal?*/

SELECT p.id_pedido, pr.nm_produto, i.qt_item, i.vl_unitario,
       i.qt_item * i.vl_unitario AS subtotal
FROM PEDIDO p
JOIN ITEM_PEDIDO i ON i.id_pedido = p.id_pedido
JOIN PRODUTO pr ON pr.id_produto = i.id_produto
WHERE p.id_pedido = 1
ORDER BY pr.nm_produto;

/*quais ingredientes entram no Vaca na Faca, e em que quantidade?*/

SELECT pr.nm_produto, ing.nm_ingrediente, u.qt_utilizada, ing.cd_unidade_medida
FROM PRODUTO pr
JOIN UTILIZA u ON pr.id_produto = u.id_produto
JOIN INGREDIENTE ing ON u.id_ingrediente = ing.id_ingrediente
WHERE pr.nm_produto = 'Vaca na Faca'
ORDER BY ing.nm_ingrediente;

/* o que cada fornecedor entregou, e em quantos dias? */

SELECT f.nm_fornecedor, c.id_compra, c.dt_emissao, c.dt_recebimento,
       DATEDIFF(c.dt_recebimento, c.dt_emissao) AS dias_entrega,
       ing.nm_ingrediente, inc.qt_comprada, ing.cd_unidade_medida
FROM FORNECEDOR f
JOIN COMPRA c ON f.id_fornecedor = c.id_fornecedor
JOIN INCLUI inc ON c.id_compra = inc.id_compra
JOIN INGREDIENTE ing ON inc.id_ingrediente = ing.id_ingrediente
ORDER BY f.nm_fornecedor, c.dt_emissao, ing.nm_ingrediente;

/* IMPORTANTE quem fez cada etapa dos pedidos 1 a 3, e houve erro?*/

SELECT p.id_pedido, p.dt_hora_pedido, e.id_etapa,
pc.nm_praca, fu.nm_funcionario, e.in_erro
FROM PEDIDO p
JOIN ETAPA_PEDIDO e ON p.id_pedido = e.id_pedido
JOIN PRACA pc ON e.id_praca = pc.id_praca
JOIN FUNCIONARIO fu ON e.id_funcionario = fu.id_funcionario
WHERE p.id_pedido BETWEEN 1 AND 3
ORDER BY p.id_pedido, e.id_etapa;

/*  IMPORTANTE quais etapas tiveram erro, em que praça e quem executou?*/

SELECT p.id_pedido, p.dt_hora_pedido, e.id_etapa,
       pc.nm_praca, fu.nm_funcionario, e.in_erro
FROM PEDIDO p
JOIN ETAPA_PEDIDO e ON p.id_pedido = e.id_pedido
JOIN PRACA pc ON e.id_praca = pc.id_praca
JOIN FUNCIONARIO fu ON e.id_funcionario = fu.id_funcionario
WHERE e.in_erro = TRUE
ORDER BY p.id_pedido, e.id_etapa
LIMIT 10;

/*Podemos saber mais sobre a Camila e extrair mais dados dela. 
em quais praças a Camila já foi habilitada e em quais ainda está em treino?*/

SELECT fu.nm_funcionario, pc.nm_praca, t.dt_inicio_treino, t.dt_habilitacao,
       CASE WHEN t.dt_habilitacao IS NULL THEN 'EM TREINO'
            ELSE 'HABILITADA' END AS situacao
FROM FUNCIONARIO fu
JOIN TREINA t ON fu.id_funcionario = t.id_funcionario
JOIN PRACA pc ON t.id_praca = pc.id_praca
WHERE fu.nm_funcionario = 'Camila Nogueira'
ORDER BY t.dt_inicio_treino;

-- Em cada dia e praça, quantas etapas a Camila fez e em quantas errou?

SELECT DATE(p.dt_hora_pedido) AS dia, pc.nm_praca,
       COUNT(*) AS qt_etapas, SUM(e.in_erro) AS qt_erros
FROM ETAPA_PEDIDO e
JOIN PEDIDO p ON e.id_pedido = p.id_pedido
JOIN PRACA pc ON e.id_praca = pc.id_praca
WHERE e.id_funcionario = 6
GROUP BY DATE(p.dt_hora_pedido), pc.nm_praca
ORDER BY dia, pc.nm_praca;

-- Quais clientes cadastrados nunca fizeram um pedido?

SELECT c.id_cliente, c.nm_cliente
FROM CLIENTE c
LEFT JOIN PEDIDO p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL
ORDER BY c.id_cliente;

-- ALTERANDO DADOS QUE JA EXISTEM
/*compras em aberto, vamos cadastrar todas */

SELECT id_compra, dt_emissao, dt_recebimento, id_fornecedor
FROM COMPRA
WHERE dt_recebimento IS NULL;

-- Registrar a chegada da compra 7 no dia 01/11/2026
UPDATE COMPRA
SET dt_recebimento = '2026-11-01'
WHERE id_compra = 7;
-- Registrar a chegada da compra 8 no dia 01/11/2026
UPDATE COMPRA
SET dt_recebimento = '2026-11-01'
WHERE id_compra = 8;
-- Registrar a chegada da compra 9 no dia 01/11/2026
UPDATE COMPRA
SET dt_recebimento = '2026-11-01'
WHERE id_compra = 9;

/*As compras 7, 8 e 9 trouxeram 5 ingredientes: Bacon, Anéis de cebola, Batata, 
Alface e Refrigerante 2 L. Vamos somar a quantidade comprada ao estoque atual.*/

SELECT id_ingrediente, nm_ingrediente, qt_estoque_atual, qt_estoque_minimo, cd_unidade_medida
FROM INGREDIENTE
WHERE qt_estoque_atual < qt_estoque_minimo
ORDER BY nm_ingrediente;

-- Dar entrada no estoque dos ingredientes das compras 7, 8 e 9
UPDATE INGREDIENTE ing
JOIN INCLUI inc ON inc.id_ingrediente = ing.id_ingrediente
SET ing.qt_estoque_atual = ing.qt_estoque_atual + inc.qt_comprada
WHERE inc.id_compra IN (7, 8, 9);

SELECT id_ingrediente, nm_ingrediente, qt_estoque_atual
FROM INGREDIENTE WHERE id_ingrediente IN (4, 8, 9, 12, 21);

-- APAGANDO LINHAS

SELECT c.id_cliente, c.nm_cliente, t.nu_telefone
FROM CLIENTE c
LEFT JOIN TELEFONE_CLIENTE t ON c.id_cliente = t.id_cliente
WHERE c.id_cliente = 32;

-- Primeiro o filho (o telefone), depois o pai (o cliente)
DELETE FROM TELEFONE_CLIENTE
WHERE id_cliente = 32;

DELETE FROM CLIENTE
WHERE id_cliente = 32;

SELECT COUNT(*) FROM CLIENTE;
SELECT COUNT(*) FROM TELEFONE_CLIENTE;


/* CONSULTAS GERENCIAIS E DE AUDITORIA */

-- G01: quem mais erra, e em qual praça? (praças com pelo menos 5 etapas)
-- Atende: P1 (responsável pelo pedido errado) e KPI taxa de erro por praça e por pessoa

SELECT pc.nm_praca, fu.nm_funcionario,
       COUNT(*) AS qt_etapas,
       SUM(e.in_erro) AS qt_erros,
       ROUND(100 * SUM(e.in_erro) / COUNT(*), 1) AS pct_erro
FROM ETAPA_PEDIDO e
JOIN PRACA pc ON e.id_praca = pc.id_praca
JOIN FUNCIONARIO fu ON e.id_funcionario = fu.id_funcionario
GROUP BY pc.nm_praca, fu.nm_funcionario
HAVING COUNT(*) >= 5
ORDER BY pct_erro DESC, qt_erros DESC;

-- G02: tempo médio e % de conclusão de cada tarefa
-- Atende: P2 (medição das tarefas) e KPI tempo médio e % de conclusão por tarefa
SELECT t.nm_tarefa,
       COUNT(*) AS qt_execucoes,
       COUNT(x.dt_hora_conclusao) AS qt_concluidas,
       ROUND(100 * COUNT(x.dt_hora_conclusao) / COUNT(*), 0) AS pct_concluidas,
       ROUND(AVG(TIMESTAMPDIFF(MINUTE, x.dt_hora_inicio, x.dt_hora_conclusao)), 1) AS media_min
FROM TAREFA t
JOIN EXECUCAO_TAREFA x ON t.id_tarefa= x.id_tarefa
GROUP BY t.id_tarefa, t.nm_tarefa
ORDER BY media_min DESC;

-- G03 (P3): dias de treino até a habilitação, por praça
-- Atende: P3 (curva de aprendizado) e KPI média de dias de treino até a habilitação
SELECT pc.nm_praca,
       COUNT(*) AS qt_pessoas,
       COUNT(t.dt_habilitacao) AS qt_habilitadas,
       COUNT(*) - COUNT(t.dt_habilitacao) AS qt_em_treino,
       ROUND(AVG(DATEDIFF(t.dt_habilitacao, t.dt_inicio_treino)), 1) AS media_dias_treino
FROM TREINA t
JOIN PRACA pc ON t.id_praca = pc.id_praca
GROUP BY pc.id_praca, pc.nm_praca
ORDER BY media_dias_treino DESC;

-- G03b: quem ainda não foi habilitado e há quantos dias treina
-- Atende: P3 (curva de aprendizado)
SELECT fu.nm_funcionario, pc.nm_praca, t.dt_inicio_treino,
       DATEDIFF(CURDATE(), t.dt_inicio_treino) AS dias_em_treino
FROM TREINA t
JOIN FUNCIONARIO fu ON t.id_funcionario = fu.id_funcionario
JOIN PRACA pc ON t.id_praca = pc.id_praca
WHERE t.dt_habilitacao IS NULL
ORDER BY dias_em_treino DESC;

-- G04: consumo dos 3 dias e quantos dias o estoque atual cobre
-- Atende: P4 (checklist manual do estoque) e KPI cobertura do estoque em dias
SELECT ing.nm_ingrediente, ing.cd_unidade_medida, ing.qt_estoque_atual,
       SUM(i.qt_item * u.qt_utilizada) AS consumo_3_dias,
       ROUND(ing.qt_estoque_atual / (SUM(i.qt_item * u.qt_utilizada) / 3), 1) AS dias_de_estoque
FROM INGREDIENTE ing
JOIN UTILIZA u ON u.id_ingrediente = ing.id_ingrediente
JOIN ITEM_PEDIDO i ON i.id_produto = u.id_produto
JOIN PEDIDO p ON p.id_pedido = i.id_pedido
WHERE p.tp_status_pedido <> 'CANCELADO'
GROUP BY ing.id_ingrediente, ing.nm_ingrediente, ing.cd_unidade_medida, ing.qt_estoque_atual
ORDER BY dias_de_estoque;

-- G05: faturamento, ticket médio e valor retido por canal (só pedidos entregues)
-- Atende: KPI faturamento e ticket médio por canal de venda
SELECT p.tp_canal_venda,
       COUNT(*) AS qt_pedidos,
       SUM(p.vl_total) AS faturamento,
       ROUND(AVG(p.vl_total), 2) AS ticket_medio,
       SUM(cr.vl_titulo) AS valor_a_receber,
       SUM(p.vl_total) - SUM(cr.vl_titulo) AS retido_pelo_canal
FROM PEDIDO p
JOIN NF_SAIDA n ON n.id_pedido = p.id_pedido
JOIN CONTA_RECEBER cr ON cr.id_nf_saida = n.id_nf_saida
WHERE p.tp_status_pedido = 'ENTREGUE'
GROUP BY p.tp_canal_venda
ORDER BY faturamento DESC;

-- A01: o valor total do pedido deve ser igual à soma dos seus itens
-- Verifica: RN01 (o total do pedido é a soma dos itens)
SELECT p.id_pedido, p.vl_total,
       SUM(i.qt_item * i.vl_unitario) AS soma_itens
FROM PEDIDO p
JOIN ITEM_PEDIDO i ON i.id_pedido = p.id_pedido
GROUP BY p.id_pedido, p.vl_total
HAVING p.vl_total <> SUM(i.qt_item * i.vl_unitario);

-- A02: só pedido ENTREGUE gera nota de saída e conta a receber
-- Verifica: RN02 (só pedido entregue gera nota e conta a receber)
SELECT p.id_pedido, p.tp_status_pedido, n.id_nf_saida, cr.id_conta_receber
FROM PEDIDO p
LEFT JOIN NF_SAIDA n ON n.id_pedido = p.id_pedido
LEFT JOIN CONTA_RECEBER cr ON cr.id_nf_saida = n.id_nf_saida
WHERE (p.tp_status_pedido = 'ENTREGUE'
       AND (n.id_nf_saida IS NULL OR cr.id_conta_receber IS NULL))
   OR (p.tp_status_pedido <> 'ENTREGUE'
       AND n.id_nf_saida IS NOT NULL);

-- A03: toda compra recebida deve ter nota fiscal de entrada
-- Verifica: RN03 (compra recebida tem nota fiscal de entrada)
SELECT c.id_compra, c.dt_emissao, c.dt_recebimento, f.nm_fornecedor
FROM COMPRA c
JOIN FORNECEDOR f ON f.id_fornecedor = c.id_fornecedor
LEFT JOIN NF_ENTRADA n ON n.id_compra= c.id_compra
WHERE c.dt_recebimento IS NOT NULL
  AND n.id_nf_entrada IS NULL
ORDER BY c.dt_recebimento, c.id_compra;

-- A04: todo insumo deve fazer parte da ficha técnica de ao menos um produto
-- Verifica: RN04 (todo insumo compõe ao menos um produto)
SELECT ing.id_ingrediente, ing.nm_ingrediente, ing.qt_estoque_atual
FROM INGREDIENTE ing
LEFT JOIN UTILIZA u ON u.id_ingrediente = ing.id_ingrediente
WHERE u.id_ingrediente IS NULL
ORDER BY ing.nm_ingrediente;

-- A05 (RN05): conta a pagar vencida e ainda não paga deve ser regularizada
-- Verifica: RN05 (conta vencida deve ser regularizada)
SELECT cp.id_conta_pagar, cp.ds_conta_pagar, cp.tp_despesa, cp.vl_titulo, cp.dt_vencimento,
       DATEDIFF(CURDATE(), cp.dt_vencimento) AS dias_atraso
FROM CONTA_PAGAR cp
WHERE cp.dt_pagamento IS NULL AND cp.dt_vencimento < CURDATE()
ORDER BY dias_atraso DESC;

SELECT 'PEDIDO' AS tabela, COUNT(*) AS total FROM PEDIDO
UNION ALL SELECT 'ITEM_PEDIDO', COUNT(*) FROM ITEM_PEDIDO
UNION ALL SELECT 'ETAPA_PEDIDO', COUNT(*) FROM ETAPA_PEDIDO
UNION ALL SELECT 'NF_SAIDA', COUNT(*) FROM NF_SAIDA
UNION ALL SELECT 'CONTA_RECEBER', COUNT(*) FROM CONTA_RECEBER
UNION ALL SELECT 'CLIENTE', COUNT(*) FROM CLIENTE
UNION ALL SELECT 'TELEFONE_CLIENTE', COUNT(*) FROM TELEFONE_CLIENTE
UNION ALL SELECT 'EXECUCAO_TAREFA', COUNT(*) FROM EXECUCAO_TAREFA
UNION ALL SELECT 'COMPRA recebida', COUNT(*) FROM COMPRA WHERE dt_recebimento IS NOT NULL;
