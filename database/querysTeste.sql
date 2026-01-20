-- ========================================
-- QUERIES DE EXEMPLO - RESTFLOW
-- ========================================

-- ========================================
-- 1. CONSULTAS BÁSICAS
-- ========================================

-- Listar todos os usuários ativos
SELECT id, nome, email, tipo 
FROM usuarios 
WHERE ativo = true;

-- Listar todas as mesas disponíveis
SELECT numero, capacidade 
FROM mesas 
WHERE status = 'LIVRE'
ORDER BY numero;

-- Listar itens do cardápio disponíveis
SELECT nome, descricao, preco 
FROM itens 
WHERE disponivel = true
ORDER BY preco;

-- ========================================
-- 2. CONSULTAS COM JOINS
-- ========================================

-- Ver comandas abertas com informações da mesa e garçom
SELECT 
    c.id AS comanda_id,
    m.numero AS mesa,
    u.nome AS garcom,
    c.quantidade_pessoas,
    c.total,
    c.aberta_em
FROM comandas c
INNER JOIN mesas m ON c.mesa_id = m.id
INNER JOIN usuarios u ON c.garcom_id = u.id
WHERE c.status = 'ABERTA';

-- Ver todos os pedidos de uma comanda específica
SELECT 
    p.id,
    i.nome AS item,
    p.quantidade,
    p.preco_unitario,
    (p.quantidade * p.preco_unitario) AS subtotal,
    p.observacoes,
    p.status
FROM pedidos p
INNER JOIN itens i ON p.item_id = i.id
WHERE p.comanda_id = 1;

-- ========================================
-- 3. CONSULTAS COM AGREGAÇÃO
-- ========================================

-- Calcular o total de uma comanda
SELECT 
    c.id AS comanda_id,
    SUM(p.quantidade * p.preco_unitario) AS total_comanda
FROM comandas c
INNER JOIN pedidos p ON c.comanda_id = p.id
WHERE c.id = 1
GROUP BY c.id;

-- Itens mais pedidos
SELECT 
    i.nome,
    COUNT(p.id) AS total_pedidos,
    SUM(p.quantidade) AS quantidade_total
FROM itens i
INNER JOIN pedidos p ON i.id = p.item_id
GROUP BY i.id, i.nome
ORDER BY quantidade_total DESC;

-- Garçons e quantidade de comandas
SELECT 
    u.nome AS garcom,
    COUNT(c.id) AS total_comandas,
    SUM(c.total) AS valor_total
FROM usuarios u
INNER JOIN comandas c ON u.id = c.garcom_id
WHERE u.tipo = 'GARCOM'
GROUP BY u.id, u.nome
ORDER BY valor_total DESC;

-- ========================================
-- 4. ATUALIZAÇÕES
-- ========================================

-- Atualizar status de um pedido
UPDATE pedidos 
SET status = 'PREPARANDO', atualizado_em = NOW()
WHERE id = 1;

-- Marcar mesa como ocupada
UPDATE mesas 
SET status = 'OCUPADA'
WHERE id = 1;

-- Atualizar total da comanda
UPDATE comandas 
SET total = (
    SELECT SUM(p.quantidade * p.preco_unitario)
    FROM pedidos p
    WHERE p.comanda_id = 1
)
WHERE id = 1;

-- ========================================
-- 5. RELATÓRIOS
-- ========================================

-- Vendas por forma de pagamento
SELECT 
    forma,
    COUNT(*) AS quantidade,
    SUM(valor) AS total_arrecadado
FROM pagamentos
GROUP BY forma;

-- Comandas fechadas hoje
SELECT 
    c.id,
    m.numero AS mesa,
    u.nome AS garcom,
    c.total,
    c.fechada_em
FROM comandas c
INNER JOIN mesas m ON c.mesa_id = m.id
INNER JOIN usuarios u ON c.garcom_id = u.id
WHERE DATE(c.fechada_em) = CURDATE()
  AND c.status IN ('FECHADA', 'PAGA')
ORDER BY c.fechada_em DESC;

-- Pedidos em preparo na cozinha
SELECT 
    p.id,
    i.nome AS item,
    p.quantidade,
    p.observacoes,
    c.id AS comanda,
    m.numero AS mesa,
    p.criado_em
FROM pedidos p
INNER JOIN itens i ON p.item_id = i.id
INNER JOIN comandas c ON p.comanda_id = c.id
INNER JOIN mesas m ON c.mesa_id = m.id
WHERE p.status IN ('SOLICITADO', 'REPARANDO')
ORDER BY p.criado_em;

-- ========================================
-- 6. OPERAÇÕES DE FECHAMENTO
-- ========================================

-- Registrar pagamento
INSERT INTO pagamentos (comanda_id, forma, valor, caixa_id) VALUES
(1, 'CARTAO', 84.70, 3);

-- Fechar comanda
UPDATE comandas 
SET status = 'PAGA', fechada_em = NOW()
WHERE id = 1;

-- Liberar mesa
UPDATE mesas 
SET status = 'LIVRE'
WHERE id = 1;
