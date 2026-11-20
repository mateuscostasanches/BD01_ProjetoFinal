
-- PROJETO FINAL DA DISCIPLINA DE BANCO DE DADOS I
-- DOCENTE: MATEUS COSTA SANCHES 
-- PRONTUÁRIO: BI3032558

-- ALTERAÇÕES NAS TABELAS DO BANCO DE DADOS
-- \c projeto_final;

-- #region ALTER TABLES
    -- #region ALTER TABLE TABELAS USUARIO
        -- ALTER TABLES usuario
        ALTER TABLE usuario ADD CONSTRAINT check_usuario_privacidade CHECK (privacidade_perfil IN ('publico', 'privado'));
        ALTER TABLE usuario ADD CONSTRAINT check_usuario_status CHECK (status_perfil IN ('ativo', 'inativo', 'banido'));
        ALTER TABLE usuario ADD CONSTRAINT check_usuario_saldo CHECK (saldo_carteira >= 0);
    -- #endregion

    -- #region ALTER TABLE TABELAS JOGO
        -- ALTER TABLES jogo     
        ALTER TABLE jogo ADD CONSTRAINT fk_jogo_desenvolvedor FOREIGN KEY (id_desenvolvedor) REFERENCES desenvolvedor (id_desenvolvedor);
        ALTER TABLE jogo ADD CONSTRAINT fk_jogo_base FOREIGN KEY (id_jogo_base) REFERENCES jogo (id_jogo);
        ALTER TABLE jogo ADD CONSTRAINT check_jogo_tipo CHECK (tipo_jogo IN ('jogo_base', 'dlc', 'trilha_sonora'));
        ALTER TABLE jogo ADD CONSTRAINT check_jogo_preco CHECK (preco_jogo >= 0);
        ALTER TABLE jogo ADD CONSTRAINT check_jogo_base_coerente CHECK ((tipo_jogo = 'jogo_base' AND id_jogo_base IS NULL) OR 
                                                        (tipo_jogo IN ('dlc', 'trilha_sonora') AND id_jogo_base IS NOT NULL));
        ALTER TABLE jogo ADD CONSTRAINT check_jogo_nao_base_de_si CHECK (id_jogo_base <> id_jogo);
        ALTER TABLE jogo ADD COLUMN classificacao_etaria INTEGER NOT NULL;
        ALTER TABLE jogo ADD CONSTRAINT check_jogo_classificacao CHECK (classificacao_etaria IN (0, 10, 12, 14, 16, 18));

        -- ALTER TABLES biblioteca
        ALTER TABLE biblioteca ADD CONSTRAINT fk_biblioteca_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE;
        ALTER TABLE biblioteca ADD CONSTRAINT fk_biblioteca_jogo FOREIGN KEY (id_jogo) REFERENCES jogo(id_jogo);
        ALTER TABLE biblioteca ADD CONSTRAINT check_biblioteca_horas CHECK (horas_jogadas >= 0); 

        -- ALTER TABLES jogo_genero
        ALTER TABLE jogo_genero ADD CONSTRAINT fk_jogo_genero_jogo FOREIGN KEY (id_jogo) REFERENCES jogo(id_jogo) ON DELETE CASCADE;
        ALTER TABLE jogo_genero ADD CONSTRAINT fk_jogo_genero_genero FOREIGN KEY (id_genero) REFERENCES genero (id_genero) ON DELETE CASCADE;

        -- ALTER TABLES sessao_jogo
        ALTER TABLE sessao_jogo ADD CONSTRAINT fk_sessao_jogo_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE;
        ALTER TABLE sessao_jogo ADD CONSTRAINT fk_sessao_jogo_jogo FOREIGN KEY (id_jogo) REFERENCES jogo(id_jogo);
        ALTER TABLE sessao_jogo ADD CONSTRAINT check_sessao_periodo CHECK (data_fim IS NULL OR data_fim >= data_inicio);

        -- ALTER TABLES conquista
        ALTER TABLE conquista ADD CONSTRAINT fk_conquista_jogo FOREIGN KEY (id_jogo) REFERENCES jogo(id_jogo) ON DELETE CASCADE;
        ALTER TABLE conquista ADD CONSTRAINT unique_conquista_jogo_nome UNIQUE (id_jogo, nome_conquista);

        -- ALTER TABLE usuario_conquista
        ALTER TABLE usuario_conquista ADD CONSTRAINT fk_usuario_conquista_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE;
        ALTER TABLE usuario_conquista ADD CONSTRAINT fk_usuario_conquista_conquista FOREIGN KEY (id_conquista) REFERENCES conquista(id_conquista) ON DELETE CASCADE;
    -- #endregion

    -- #region ALTER TABLE TABELAS COMPRA
        -- ALTER TABLES compra
        ALTER TABLE compra ADD CONSTRAINT fk_compra_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);
        ALTER TABLE compra ADD CONSTRAINT check_compra_status CHECK (status_compra IN ('pendente', 'aprovada', 'recusada', 'cancelada', 'reembolsada'));
        ALTER TABLE compra ADD CONSTRAINT check_compra_valor CHECK (valor_total >= 0.00);

        -- ALTER TABLES item_compra
        ALTER TABLE item_compra ADD CONSTRAINT fk_itemcompra_compra FOREIGN KEY (id_compra) REFERENCES compra (id_compra) ON DELETE CASCADE;
        ALTER TABLE item_compra ADD CONSTRAINT fk_itemcompra_jogo FOREIGN KEY (id_jogo) REFERENCES jogo (id_jogo);
        ALTER TABLE item_compra ADD CONSTRAINT chk_itemcompra_preco CHECK (preco_pago >= 0.00);

        -- ALTER TABLES pagamento
        ALTER TABLE pagamento ADD CONSTRAINT fk_pagamento_compra FOREIGN KEY (id_compra) REFERENCES compra (id_compra);
        ALTER TABLE pagamento ADD CONSTRAINT check_pagamento_metodo CHECK (metodo_pagamento IN ('cartao_debito', 'cartao_credito', 'pix', 'boleto', 'carteira'));
        ALTER TABLE pagamento ADD CONSTRAINT check_pagamento_status CHECK (status_pagamento IN ('pendente', 'aprovado', 'recusado', 'cancelado', 'reembolsado'));
        ALTER TABLE pagamento ADD CONSTRAINT check_pagamento_valor CHECK (valor_pago >= 0.00);

        -- ALTER TABLES promocao
        ALTER TABLE promocao ADD CONSTRAINT check_promocao_desconto CHECK (desconto_pct BETWEEN 0 AND 100);
        ALTER TABLE promocao ADD CONSTRAINT check_promocao_periodo CHECK (data_fim >= data_inicio);

        -- ALTER TABLE promocao_jogo
        ALTER TABLE promocao_jogo ADD CONSTRAINT fk_promocaojogo_promocao FOREIGN KEY (id_promocao) REFERENCES promocao (id_promocao) ON DELETE CASCADE;
        ALTER TABLE promocao_jogo ADD CONSTRAINT fk_promocaojogo_jogo FOREIGN KEY (id_jogo) REFERENCES jogo (id_jogo) ON DELETE CASCADE;

        -- ALTER TABLE lista_desejos
        ALTER TABLE lista_desejos ADD CONSTRAINT fk_desejos_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE CASCADE;
        ALTER TABLE lista_desejos ADD CONSTRAINT fk_desejos_jogo FOREIGN KEY (id_jogo) REFERENCES jogo (id_jogo) ON DELETE CASCADE;
    -- #endregion

    -- #region ALTER TABLE TABELAS SOCIAL
        -- ALTER TABLES avaliacao
        ALTER TABLE avaliacao ADD CONSTRAINT fk_avaliacao_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario);
        ALTER TABLE avaliacao ADD CONSTRAINT fk_avaliacao_jogo FOREIGN KEY (id_jogo) REFERENCES jogo(id_jogo);

        -- ALTER TABLES amizade
        ALTER TABLE amizade ADD CONSTRAINT fk_amizade_usuario1 FOREIGN KEY (id_usuario1) REFERENCES usuario(id_usuario) ON DELETE CASCADE;
        ALTER TABLE amizade ADD CONSTRAINT fk_amizade_usuario2 FOREIGN KEY (id_usuario2) REFERENCES usuario(id_usuario) ON DELETE CASCADE;
        ALTER TABLE amizade ADD CONSTRAINT status_amizade CHECK (status IN ('pendente', 'aceita', 'recusada'));
        ALTER TABLE amizade ADD CONSTRAINT check_amizade_diferentes CHECK (id_usuario1 <> id_usuario2);

        -- ALTER TABLES familia & familia_usuario
        ALTER TABLE familia ADD CONSTRAINT fk_familia_dono FOREIGN KEY (id_dono) REFERENCES usuario(id_usuario);
        ALTER TABLE familia_usuario ADD CONSTRAINT fk_familia_usuario_familia FOREIGN KEY (id_familia) REFERENCES familia(id_familia) ON DELETE CASCADE;
        ALTER TABLE familia_usuario ADD CONSTRAINT fk_familia_usuario_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE;
        ALTER TABLE familia_usuario ADD CONSTRAINT unique_familia_usuario UNIQUE (id_usuario);
    -- #endregion   
-- #endregion