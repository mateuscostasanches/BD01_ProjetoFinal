
-- PROJETO FINAL DA DISCIPLINA DE BANCO DE DADOS I
-- DOCENTE: MATEUS COSTA SANCHES 
-- PRONTUÁRIO: BI3032558

-- DEFINIÇÃO DO BANCO DE DADOS
-- DROP DATABASE IF EXISTS projeto_final;
CREATE DATABASE projeto_final;
\c projeto_final;

-- tabelas: usuario, desenvolvedor
-- #region TABELAS USUARIO
CREATE TABLE usuario
(
    id_usuario          INTEGER       UNIQUE NOT NULL,
    nome_usuario        VARCHAR(100)  UNIQUE NOT NULL,
    email               VARCHAR(100)  UNIQUE NOT NULL,
    senha               VARCHAR(100)         NOT NULL,
    data_nascimento     DATE                 NOT NULL,
    data_cadastro       DATE                 NOT NULL DEFAULT CURRENT_DATE,
    pais                VARCHAR(50),
    saldo_carteira      DECIMAL(10,2)        NOT NULL DEFAULT      0.00,
    status_perfil       VARCHAR(10)          NOT NULL DEFAULT   'ativo',
    privacidade_perfil  VARCHAR(10)          NOT NULL DEFAULT 'publico',
    PRIMARY KEY (id_usuario)
);

CREATE TABLE desenvolvedor
(
    id_desenvolvedor   INTEGER             UNIQUE NOT NULL,
    nome_desenvolvedor VARCHAR(100)        UNIQUE NOT NULL,
    pais               VARCHAR(50),
    PRIMARY KEY (id_desenvolvedor)
);
-- #endregion

-- tabelas: jogo, biblioteca, sessao_jogo, genero, conquista, usuario_conquista
-- #region TABELAS JOGO
CREATE TABLE jogo
(
    id_jogo            INTEGER             UNIQUE NOT NULL,
    id_desenvolvedor   INTEGER                    NOT NULL,
    id_jogo_base       INTEGER,
    nome_jogo          VARCHAR(100)        UNIQUE NOT NULL,
    descricao          VARCHAR(5000)              NOT NULL,
    data_lancamento    DATE                       NOT NULL,
    preco_jogo         DECIMAL(10,2)              NOT NULL,
    tipo_jogo          VARCHAR(20)                NOT NULL,
    PRIMARY KEY (id_jogo)
);

CREATE TABLE biblioteca -- TABELA ASSOCIATIVA
(
    id_usuario      INTEGER       NOT NULL,
    id_jogo         INTEGER       NOT NULL,
    data_aquisicao  DATE          NOT NULL DEFAULT CURRENT_DATE,
    horas_jogadas   DECIMAL(10,1) NOT NULL DEFAULT 0.0,
    PRIMARY KEY (id_usuario, id_jogo)
);

CREATE TABLE genero
(
    id_genero    INTEGER      UNIQUE NOT NULL,
    nome_genero  VARCHAR(50)  UNIQUE NOT NULL,
    PRIMARY KEY (id_genero)
);

CREATE TABLE jogo_genero -- TABELA ASSOCIATIVA
(
    id_jogo    INTEGER   NOT NULL,
    id_genero  INTEGER   NOT NULL,
    PRIMARY KEY (id_jogo, id_genero)
);

CREATE TABLE sessao_jogo
(
    id_sessao      INTEGER             UNIQUE NOT NULL,
    id_usuario     INTEGER                    NOT NULL,
    id_jogo        INTEGER                    NOT NULL,
    data_inicio    TIMESTAMP                  NOT NULL,
    data_fim       TIMESTAMP,
    PRIMARY KEY (id_sessao)
);

CREATE TABLE conquista
(
    id_conquista   INTEGER             UNIQUE NOT NULL,
    id_jogo        INTEGER                    NOT NULL,
    nome_conquista VARCHAR(50)                NOT NULL,
    descricao      VARCHAR(5000)              NOT NULL,
    tipo           VARCHAR(20)                NOT NULL,
    PRIMARY KEY (id_conquista)
);

CREATE TABLE usuario_conquista -- TABELA ASSOCIATIVA
(
    id_usuario      INTEGER    NOT NULL,
    id_conquista    INTEGER    NOT NULL,
    data_conquista  DATE       NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_usuario, id_conquista)
);
-- #endregion

-- tabelas: compra, item_compra, pagamento, promocao, promocao_jogo, lista_desejos
-- #region TABELAS COMPRA
CREATE TABLE compra
(
    id_compra      INTEGER  UNIQUE NOT NULL,
    id_usuario     INTEGER         NOT NULL,
    valor_total    DECIMAL(10,2)   NOT NULL,
    status_compra  VARCHAR(15)     NOT NULL DEFAULT 'pendente',
    data_compra    TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_compra)
);

CREATE TABLE item_compra -- TABELA ASSOCIATIVA 
(
    id_compra INTEGER         NOT NULL,
    id_jogo   INTEGER         NOT NULL,
    preco_pago DECIMAL(10,2)  NOT NULL,
    PRIMARY KEY (id_compra, id_jogo)
);

CREATE TABLE pagamento
(
    id_pagamento       INTEGER  UNIQUE NOT NULL,
    id_compra          INTEGER         NOT NULL,
    metodo_pagamento   VARCHAR(20)     NOT NULL,
    valor_pago         DECIMAL(10,2)   NOT NULL,
    status_pagamento   VARCHAR(15)     NOT NULL DEFAULT 'pendente',
    data_pagamento     TIMESTAMP,
    PRIMARY KEY (id_pagamento)
);

CREATE TABLE promocao
(
    id_promocao        INTEGER  UNIQUE NOT NULL,
    nome_promocao      VARCHAR(100)     NOT NULL,
    desconto_pct       DECIMAL(5,2)    NOT NULL,
    data_inicio        DATE            NOT NULL,
    data_fim           DATE            NOT NULL,
    PRIMARY KEY (id_promocao)
);

CREATE TABLE promocao_jogo -- TABELA ASSOCIATIVA
(
    id_promocao  INTEGER  NOT NULL,
    id_jogo      INTEGER  NOT NULL,
    PRIMARY KEY (id_promocao, id_jogo)
);

CREATE TABLE lista_desejos -- TABELA ASSOCIATIVA
(
    id_usuario  INTEGER  NOT NULL,
    id_jogo     INTEGER  NOT NULL,
    data_adicao DATE     NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_usuario, id_jogo)
);
-- #endregion

-- TABELAS: avaliação, amizade, familia, familia_usuario
-- #region TABELAS SOCIAL
CREATE TABLE avaliacao
(
    id_usuario      INTEGER        NOT NULL,
    id_jogo         INTEGER        NOT NULL,
    recomendacao    BOOLEAN        NOT NULL,
    data_avaliacao  DATE           NOT NULL DEFAULT CURRENT_DATE,
    comentario      VARCHAR(5000),
    PRIMARY KEY (id_usuario, id_jogo)
);

CREATE TABLE amizade
(
    id_usuario1       INTEGER       NOT NULL,
    id_usuario2       INTEGER       NOT NULL,
    data_solicitacao  DATE          NOT NULL DEFAULT CURRENT_DATE,
    status_amizade    VARCHAR(10)   NOT NULL DEFAULT 'pendente',
    PRIMARY KEY (id_usuario1, id_usuario2)
);

CREATE TABLE familia
(
    id_familia    INTEGER     UNIQUE NOT NULL,
    id_dono       INTEGER            NOT NULL,
    nome_familia  VARCHAR(50)        NOT NULL,
    data_criacao  DATE               NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_familia)
);

CREATE TABLE familia_usuario -- TABELA ASSOCIATIVA 
(
    id_familia    INTEGER       NOT NULL,
    id_usuario    INTEGER       NOT NULL,
    data_entrada  DATE          NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_familia, id_usuario)
);
-- #endregion