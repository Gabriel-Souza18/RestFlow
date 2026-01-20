package org.example.model;

import jakarta.persistence.*;
import lombok.Data;
import org.example.model.enums.TipoUsuario;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String nome;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String senha;

    @Column(nullable = false)
    private TipoUsuario tipo;

    @Column(nullable = false)
    private boolean ativo;

    @Column
    @CreationTimestamp
    private LocalDateTime criadoEm;

}
