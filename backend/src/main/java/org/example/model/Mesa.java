package org.example.model;

import jakarta.persistence.*;
import lombok.Data;
import org.example.model.enums.StatusMesa;

import java.time.LocalDateTime;

@Entity
@Table(name = "mesas")
@Data
public class Mesa {

    @Id
    @GeneratedValue(strategy = jakarta.persistence.GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private int numero;

    @Column(nullable = false)
    private int capacidade;

    @Column(nullable = false)
    private StatusMesa status;

    @Column(nullable = false)
    private LocalDateTime criadoEm;

}
