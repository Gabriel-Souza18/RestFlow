CREATE TABLE `usuarios` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) UNIQUE NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` enum('GARCOM','COZINHA','CAIXA','SUPERVISOR') NOT NULL,
  `ativo` boolean DEFAULT true,
  `criado_em` timestamp DEFAULT (now())
);

CREATE TABLE `mesas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `numero` int UNIQUE NOT NULL,
  `capacidade` int NOT NULL,
  `status` enum('LIVRE','OCUPADA') DEFAULT 'LIVRE',
  `criado_em` timestamp DEFAULT (now())
);

CREATE TABLE `itens` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(200),
  `preco` decimal(10,2) NOT NULL,
  `disponivel` boolean DEFAULT true,
  `tempo_preparo` int DEFAULT 15,
  `criado_em` timestamp DEFAULT (now())
);

CREATE TABLE `comandas` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `mesa_id` int NOT NULL,
  `garcom_id` int NOT NULL,
  `status` enum('ABERTA','FECHADA','PAGA') DEFAULT 'ABERTA',
  `total` decimal(10,2) DEFAULT 0,
  `quantidade_pessoas` int DEFAULT 1,
  `aberta_em` timestamp DEFAULT (now()),
  `fechada_em` timestamp
);

CREATE TABLE `pedidos` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `comanda_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantidade` int NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `observacoes` varchar(200),
  `status` enum('SOLICITADO','REPARANDO','PRONTO','ENTREGUE') DEFAULT 'SOLICITADO',
  `criado_em` timestamp DEFAULT (now()),
  `atualizado_em` timestamp DEFAULT (now())
);

CREATE TABLE `pagamentos` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `comanda_id` int NOT NULL,
  `forma` enum('DINHEIRO','CARTAO','PIX') NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `caixa_id` int NOT NULL,
  `pago_em` timestamp DEFAULT (now())
);

ALTER TABLE `comandas` ADD FOREIGN KEY (`mesa_id`) REFERENCES `mesas` (`id`);

ALTER TABLE `comandas` ADD FOREIGN KEY (`garcom_id`) REFERENCES `usuarios` (`id`);

ALTER TABLE `pedidos` ADD FOREIGN KEY (`comanda_id`) REFERENCES `comandas` (`id`);

ALTER TABLE `pedidos` ADD FOREIGN KEY (`item_id`) REFERENCES `itens` (`id`);

ALTER TABLE `pagamentos` ADD FOREIGN KEY (`comanda_id`) REFERENCES `comandas` (`id`);

ALTER TABLE `pagamentos` ADD FOREIGN KEY (`caixa_id`) REFERENCES `usuarios` (`id`);