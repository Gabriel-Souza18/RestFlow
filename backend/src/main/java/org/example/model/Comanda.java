package org.example.model;


import jakarta.persistence.*;
import lombok.Data;
import org.example.model.enums.StatusComanda;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "comandas")
public class Comanda {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long idMesa;

    @Column(nullable = false)
    private Long idGarcom;

    @Column(nullable = false)
    private StatusComanda status;

    @Column
    private Double total;

    @Column
    private int quantPessoas;

    @Column
    @CreationTimestamp
    private LocalDateTime abertura;

    @Column
    @UpdateTimestamp
    private LocalDateTime fechamento;

}
