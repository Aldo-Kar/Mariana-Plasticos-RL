package com.example.demo.repository;

import com.example.demo.entity.Pedido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PedidoRepository extends JpaRepository<Pedido, Integer> {
    List<Pedido> findByEstado(String estado);
    List<Pedido> findByIdCliente(Integer idCliente);
}

public interface PedidoRepository extends JpaRepository<Pedido, Long> {
    List<Pedido> findByFecha(LocalDate fecha);
    List<Pedido> findByEstado(String estado);
    List<Pedido> findByEstadoNot(String estado);
}


