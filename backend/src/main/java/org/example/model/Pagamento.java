package org.example.model;


import jakarta.persistence.*;
import lombok.Data;
import org.example.model.enums.FormaPagamento;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "pagamentos")
public class Pagamento {

    @Id
    @GeneratedValue(strategy = jakarta.persistence.GenerationType.IDENTITY)
    private Long Id;

    @Column(nullable = false)
    private Long idComanda;

    @Column(nullable = false)
    private Double valor;

    @Column(nullable = false)
    private FormaPagamento formaPagamento;

    @Column(nullable = false)
    private Long CaixaId;

    @Column(nullable = false)
    private LocalDateTime PagoEm;

}
