-- ============================================
-- POPULAÇÃO DO BANCO RESTOFLOW (TABELAS ORIGINAIS)
-- ============================================

-- Limpar dados existentes (se necessário)
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM pagamentos;
DELETE FROM pedidos;
DELETE FROM comandas;
DELETE FROM itens;
DELETE FROM mesas;
DELETE FROM usuarios;
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- 1. INSERIR USUÁRIOS
-- ============================================
INSERT INTO usuarios (nome, email, senha, tipo) VALUES
('João Silva', 'joao@restoflow.com', 'senha123', 'GARCOM'),
('Maria Santos', 'maria@restoflow.com', 'senha123', 'GARCOM'),
('Pedro Costa', 'pedro@restoflow.com', 'senha123', 'COZINHA'),
('Ana Lima', 'ana@restoflow.com', 'senha123', 'COZINHA'),
('Carlos Oliveira', 'carlos@restoflow.com', 'senha123', 'CAIXA'),
('Fernanda Rocha', 'fernanda@restoflow.com', 'senha123', 'SUPERVISOR');

-- ============================================
-- 2. INSERIR MESAS
-- ============================================
INSERT INTO mesas (numero, capacidade) VALUES
(1, 4), (2, 4), (3, 6), (4, 2), (5, 2),
(6, 8), (7, 4), (8, 6), (9, 4), (10, 2);

-- ============================================
-- 3. INSERIR ITENS DO CARDÁPIO
-- ============================================
INSERT INTO itens (nome, descricao, preco) VALUES
('Bruschetta', 'Pão italiano com tomate e manjericão', 18.90),
('Filé Mignon', '300g com batatas rústicas', 49.90),
('Risotto de Cogumelos', 'Arroz arbóreo com mix de cogumelos', 38.50),
('Refrigerante', 'Lata 350ml', 6.90),
('Suco Natural', '500ml - Laranja ou Limão', 12.90),
('Brownie', 'Com sorvete de creme', 16.90),
('Carpaccio', 'Finas fatias de carne crua', 32.50),
('Salmão Grelhado', 'Com legumes grelhados', 42.90),
('Cerveja Artesanal', 'Garrafa 500ml', 16.90),
('Cheesecake', 'Torta de queijo com calda', 19.90);

-- ============================================
-- 4. INSERIR COMANDA ABERTA
-- ============================================
INSERT INTO comandas (mesa_id, garcom_id, quantidade_pessoas) VALUES
(1, 1, 3),
(3, 2, 5),
(5, 1, 2);

-- Atualizar status das mesas para OCUPADA
UPDATE mesas SET status = 'OCUPADA' WHERE id IN (1, 3, 5);

-- ============================================
-- 5. INSERIR PEDIDOS
-- ============================================
-- Comanda 1
INSERT INTO pedidos (comanda_id, item_id, quantidade, preco_unitario, observacoes, status) VALUES
(1, 1, 1, 18.90, 'Sem manjericão', 'ENTREGUE'),
(1, 2, 2, 49.90, 'Um ponto e outro bem passado', 'SOLICITADO'),
(1, 4, 3, 6.90, '2 Coca e 1 Guaraná', 'ENTREGUE'),
(1, 6, 2, 16.90, 'Com sorvete de chocolate', 'SOLICITADO');

-- Comanda 2
INSERT INTO pedidos (comanda_id, item_id, quantidade, preco_unitario, status) VALUES
(2, 1, 1, 18.90, 'ENTREGUE'),
(2, 3, 3, 38.50, 'SOLICITADO'),
(2, 8, 2, 42.90, 'REPARANDO'),
(2, 5, 5, 12.90, 'ENTREGUE'),
(2, 10, 2, 19.90, 'SOLICITADO');

-- Comanda 3
INSERT INTO pedidos (comanda_id, item_id, quantidade, preco_unitario, observacoes, status) VALUES
(3, 7, 1, 32.50, 'Com molho extra', 'ENTREGUE'),
(3, 2, 1, 49.90, 'Sem farofa', 'REPARANDO'),
(3, 9, 1, 16.90, 'IPA', 'ENTREGUE'),
(3, 6, 1, 16.90, NULL, 'SOLICITADO');

-- ============================================
-- 6. COMANDA FECHADA (histórico)
-- ============================================
INSERT INTO comandas (mesa_id, garcom_id, status, quantidade_pessoas, aberta_em, fechada_em) VALUES
(2, 1, 'FECHADA', 2, NOW() - INTERVAL 2 HOUR, NOW() - INTERVAL 30 MINUTE);

INSERT INTO pedidos (comanda_id, item_id, quantidade, preco_unitario, status) VALUES
(4, 2, 1, 49.90, 'ENTREGUE'),
(4, 4, 2, 6.90, 'ENTREGUE'),
(4, 6, 2, 16.90, 'ENTREGUE'),
(4, 7, 1, 32.50, 'ENTREGUE');

-- ============================================
-- 7. COMANDA PAGA (histórico)
-- ============================================
INSERT INTO comandas (mesa_id, garcom_id, status, quantidade_pessoas, aberta_em, fechada_em) VALUES
(4, 2, 'PAGA', 2, NOW() - INTERVAL 3 HOUR, NOW() - INTERVAL 1 HOUR);

INSERT INTO pedidos (comanda_id, item_id, quantidade, preco_unitario, status) VALUES
(5, 2, 2, 49.90, 'ENTREGUE'),
(5, 3, 2, 38.50, 'ENTREGUE'),
(5, 8, 1, 42.90, 'ENTREGUE'),
(5, 5, 3, 12.90, 'ENTREGUE'),
(5, 9, 2, 16.90, 'ENTREGUE'),
(5, 10, 2, 19.90, 'ENTREGUE');

-- ============================================
-- 8. INSERIR PAGAMENTOS
-- ============================================
INSERT INTO pagamentos (comanda_id, forma, valor, caixa_id) VALUES
(5, 'CARTAO', 245.30, 5),
(4, 'DINHEIRO', 127.60, 5);

-- ============================================
-- 9. ATUALIZAR TOTAIS DAS COMANDA
-- ============================================
UPDATE comandas SET total = (
    SELECT SUM(quantidade * preco_unitario)
    FROM pedidos
    WHERE comanda_id = comandas.id
)
WHERE id IN (1, 2, 3, 4, 5);

-- ============================================
-- 10. VERIFICAÇÃO FINAL
-- ============================================
SELECT '=== DADOS INSERIDOS COM SUCESSO ===' AS mensagem;

SELECT 'Usuários:' AS tabela, COUNT(*) AS quantidade FROM usuarios
UNION ALL
SELECT 'Mesas:', COUNT(*) FROM mesas
UNION ALL
SELECT 'Itens:', COUNT(*) FROM itens
UNION ALL
SELECT 'Comandas:', COUNT(*) FROM comandas
UNION ALL
SELECT 'Pedidos:', COUNT(*) FROM pedidos
UNION ALL
SELECT 'Pagamentos:', COUNT(*) FROM pagamentos;