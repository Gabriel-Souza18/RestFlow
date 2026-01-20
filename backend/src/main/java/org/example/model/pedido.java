package org.example.model;


import jakarta.persistence.*;
import lombok.Data;
import org.example.model.enums.StatusPedido;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "pedidos")
@Data
public class pedido {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false, unique = true)
    private Long id;

    @Column(nullable = false)
    private Long idComanda;

    @Column(nullable = false)
    private Long idProduto;

    @Column(nullable = false)
    private int quantidade;

    @Column(nullable = false)
    private Double precoUnitario;

    @Column(nullable = false)
    private String Observacoes;

    @Column(nullable = false)
    private StatusPedido status;

    @CreationTimestamp
    @Column(nullable = false)
    private java.time.LocalDateTime criadoEm;

    @UpdateTimestamp
    @Column
    private java.time.LocalDateTime atualizadoEm;

}
