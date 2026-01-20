package org.example;

import org.example.model.*;
import org.example.model.enums.*;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class Main {

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    @Bean
    CommandLineRunner run() {
        return args -> {
            System.out.println("=== Testando Models ===\n");

            // Testando Usuario
            Usuario usuario = new Usuario();
            usuario.setNome("João Silva");
            usuario.setEmail("joao@restaurante.com");
            usuario.setSenha("senha123");
            usuario.setTipo(TipoUsuario.GARCOM);
            System.out.println("Usuario criado: " + usuario.getNome() + " - Tipo: " + usuario.getTipo());

            // Testando StatusComanda
            System.out.println("\nStatus de Comanda disponíveis:");
            for (StatusComanda status : StatusComanda.values()) {
                System.out.println("  - " + status);
            }

            // Testando StatusMesa
            System.out.println("\nStatus de Mesa disponíveis:");
            for (StatusMesa status : StatusMesa.values()) {
                System.out.println("  - " + status);
            }

            // Testando StatusPedido
            System.out.println("\nStatus de Pedido disponíveis:");
            for (StatusPedido status : StatusPedido.values()) {
                System.out.println("  - " + status);
            }

            // Testando FormaPagamento
            System.out.println("\nFormas de Pagamento disponíveis:");
            for (FormaPagamento forma : FormaPagamento.values()) {
                System.out.println("  - " + forma);
            }

            System.out.println("\n=== Testes concluídos com sucesso! ===");
        };
    }
}
