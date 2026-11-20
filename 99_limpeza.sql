
-- PROJETO FINAL DA DISCIPLINA DE BANCO DE DADOS I
-- DOCENTE: MATEUS COSTA SANCHES 
-- PRONTUÁRIO: BI3032558

-- DROP DO BANCO DE DADOS
-- \c projeto_final

-- AVISO: Execução opcional, O script abaixo é considerado destrutivo ao banco de dados
--                            e deve ser mantido restrito apenas ao ambiente de testes.

-- #region limpeza
    -- TABELAS SOCIAL
    DROP TABLE IF EXISTS familia_usuario;
    DROP TABLE IF EXISTS familia;
    DROP TABLE IF EXISTS amizade;
    DROP TABLE IF EXISTS avaliacao;

    -- TABELAS COMPRA
    DROP TABLE IF EXISTS lista_desejos;
    DROP TABLE IF EXISTS promocao_jogo;
    DROP TABLE IF EXISTS promocao;
    DROP TABLE IF EXISTS pagamento;
    DROP TABLE IF EXISTS item_compra;
    DROP TABLE IF EXISTS compra;

    -- TABELAS JOGO
    DROP TABLE IF EXISTS usuario_conquista;
    DROP TABLE IF EXISTS conquista;
    DROP TABLE IF EXISTS sessao_jogo;
    DROP TABLE IF EXISTS jogo_genero;
    DROP TABLE IF EXISTS genero;
    DROP TABLE IF EXISTS biblioteca;
    DROP TABLE IF EXISTS jogo;

    -- TABELAS USUARIO
    DROP TABLE IF EXISTS desenvolvedor;
    DROP TABLE IF EXISTS usuario;   
-- #endregion 