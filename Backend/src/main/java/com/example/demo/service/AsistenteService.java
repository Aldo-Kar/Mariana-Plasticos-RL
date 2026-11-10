package com.example.demo.service;

import com.example.demo.entity.*;
import com.example.demo.repository.ProductoRepository;
import com.example.demo.repository.InventarioRepository;
import com.example.demo.repository.MovimientoRepository;
import com.example.demo.repository.PedidoRepository;
import com.example.demo.repository.ClienteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AsistenteService {

    private final ProductoRepository productoRepository;
    private final InventarioRepository inventarioRepository;
    private final MovimientoRepository movimientoRepository;
    private final PedidoRepository pedidoRepository;
    private final ClienteRepository clienteRepository;

    public Map<String, Object> procesarConsulta(String consulta) {
        String resp = generarRespuesta(consulta.toLowerCase());
        
        Map<String, Object> resultado = new HashMap<>();
        resultado.put("success", true);
        resultado.put("message", resp);
        return resultado;
    }

    private String generarRespuesta(String q) {
        // ==============================================
        // 📊 RESUMEN GENERAL / DASHBOARD
        // ==============================================
        if (contiene(q, "total", "resumen", "general", "panel", "dashboard")) {
            long totalProductos = productoRepository.count();
            long totalUnidades = inventarioRepository.findAll().stream()
                    .mapToLong(i -> Optional.ofNullable(i.getCantidad()).orElse(0)).sum();
            long totalPedidos = pedidoRepository.count();
            long pedidosPendientes = pedidoRepository.findByEstadoNot("Entregado").size();
            long totalMov = movimientoRepository.count();

            return String.format("""
                📊 Resumen General — Mariana Plásticos
                
                📦 Productos registrados: %d
                📦 Unidades en inventario: %d
                🛒 Pedidos totales: %d
                ⏳ Pedidos pendientes: %d
                🔄 Movimientos registrados: %d
                """, totalProductos, totalUnidades, totalPedidos, pedidosPendientes, totalMov);
        }

        // ==============================================
        // 📦 PRODUCTOS
        // ==============================================
        if (contiene(q, "producto", "productos")) {
            if (contiene(q, "listar", "todos", "ver todos")) {
                List<Producto> lista = productoRepository.findAll();
                if (lista.isEmpty()) return "📦 No hay productos registrados.";
                
                StringBuilder sb = new StringBuilder("📦 Productos registrados:\n");
                lista.forEach(p -> sb.append(String.format("• %s — Precio: $%.2f — Stock: %d\n",
                    p.getNombre(), p.getPrecio(), p.getStockActual())));
                return sb.toString();
            }
        }

        // ==============================================
        // 📈 INVENTARIO / EXISTENCIAS / STOCK
        // ==============================================
        if (contiene(q, "existencia", "existencias", "stock", "inventario", "cantidad")) {
            if (contiene(q, "bajo", "poco", "minimo", "reabastecer", "reponer")) {
                List<Producto> bajoStock = productoRepository.findAll().stream()
                    .filter(p -> p.getStockActual() <= p.getStockMinimo())
                    .collect(Collectors.toList());
                if (bajoStock.isEmpty()) return "✅ Todos los productos tienen stock suficiente.";
                
                StringBuilder sb = new StringBuilder("⚠️ Productos con stock bajo:\n");
                bajoStock.forEach(p -> sb.append(String.format("• %s — Actual: %d / Mínimo: %d\n",
                    p.getNombre(), p.getStockActual(), p.getStockMinimo())));
                return sb.toString();
            }

            String nombreProd = extraerNombreProducto(q);
            if (!nombreProd.isEmpty()) {
                Optional<Producto> prod = productoRepository.findAll().stream()
                    .filter(p -> p.getNombre().toLowerCase().contains(nombreProd))
                    .findFirst();
                if (prod.isPresent()) {
                    Producto p = prod.get();
                    return String.format("""
                        📦 %s
                        ├─ Cantidad disponible: %d unidades
                        ├─ Stock mínimo: %d unidades
                        ├─ Precio unitario: $%.2f
                        └─ Estado: %s
                        """, p.getNombre(), p.getStockActual(), p.getStockMinimo(),
                            p.getPrecio(), p.getStockActual() <= p.getStockMinimo() ? "⚠️ Stock bajo" : "✅ Nivel suficiente");
                }
                return "❌ No encontré ese producto en el inventario.";
            }

            List<Inventario> inv = inventarioRepository.findAll();
            if (inv.isEmpty()) return "📦 El inventario está vacío.";
            
            StringBuilder sb = new StringBuilder("📋 Inventario completo:\n");
            inv.forEach(i -> sb.append(String.format("• %s — %d unidades\n",
                i.getProducto() != null ? i.getProducto().getNombre() : "Producto",
                i.getCantidad())));
            return sb.toString();
        }

        // ==============================================
        // 🔄 MOVIMIENTOS
        // ==============================================
        if (contiene(q, "movimiento", "movimientos", "entrada", "salida", "historial")) {
            LocalDate hoy = LocalDate.now();
            
            if (contiene(q, "hoy", "día de hoy", "día")) {
                List<Movimiento> mvs = movimientoRepository.findByFecha(hoy);
                if (mvs.isEmpty()) return "🔄 No hay movimientos registrados hoy.";
                
                StringBuilder sb = new StringBuilder("🔄 Movimientos de hoy:\n");
                mvs.forEach(m -> sb.append(String.format("• %s — %s ×%d\n",
                    m.getTipo(),
                    m.getProducto() != null ? m.getProducto().getNombre() : "Producto",
                    m.getCantidad())));
                return sb.toString();
            }

            if (contiene(q, "recientes", "ultimos", "últimos")) {
                List<Movimiento> todos = movimientoRepository.findAll();
                if (todos.isEmpty()) return "🔄 No hay movimientos registrados.";
                
                int desde = Math.max(0, todos.size() - 10);
                StringBuilder sb = new StringBuilder("🔄 Últimos movimientos:\n");
                for (int i = todos.size() - 1; i >= desde; i--) {
                    Movimiento m = todos.get(i);
                    sb.append(String.format("• %s | %s | ×%d\n",
                        m.getFecha(), m.getTipo(), m.getCantidad()));
                }
                return sb.toString();
            }

            return "🔄 Total de movimientos: " + movimientoRepository.count();
        }

        // ==============================================
        // 🛒 PEDIDOS
        // ==============================================
        if (contiene(q, "pedido", "pedidos")) {
            if (contiene(q, "pendiente", "pendientes", "en proceso")) {
                List<Pedido> pend = pedidoRepository.findByEstadoNot("Entregado");
                if (pend.isEmpty()) return "✅ No hay pedidos pendientes.";
                
                StringBuilder sb = new StringBuilder("⏳ Pedidos pendientes (" + pend.size() + "):\n");
                pend.forEach(p -> sb.append(String.format("• %s — $%.2f — %s\n",
                    p.getCliente(), p.getTotal(), p.getEstado())));
                return sb.toString();
            }

            if (contiene(q, "entregado", "entregados")) {
                return "✅ Pedidos entregados: " + pedidoRepository.findByEstado("Entregado").size();
            }

            if (contiene(q, "hoy", "día de hoy")) {
                List<Pedido> pedsHoy = pedidoRepository.findByFecha(LocalDate.now());
                if (pedsHoy.isEmpty()) return "🛒 No hay pedidos hoy.";
                
                StringBuilder sb = new StringBuilder("🛒 Pedidos de hoy:\n");
                pedsHoy.forEach(p -> sb.append(String.format("• %s — $%.2f — %s\n",
                    p.getCliente(), p.getTotal(), p.getEstado())));
                return sb.toString();
            }

            long totalP = pedidoRepository.count();
            long entregados = pedidoRepository.findByEstado("Entregado").size();
            return String.format("🛒 Total: %d | ✅ Entregados: %d | ⏳ Pendientes: %d",
                totalP, entregados, totalP - entregados);
        }

        // ==============================================
        // 👥 CLIENTES
        // ==============================================
        if (contiene(q, "cliente", "clientes")) {
            List<Cliente> clientes = clienteRepository.findAll();
            if (clientes.isEmpty()) return "👥 No hay clientes registrados.";
            
            StringBuilder sb = new StringBuilder("👥 Clientes (" + clientes.size() + "):\n");
            clientes.forEach(c -> sb.append("• ").append(c.getNombre()).append("\n"));
            return sb.toString();
        }

        // ==============================================
        // 📋 REPORTE DEL DÍA
        // ==============================================
        if (contiene(q, "reporte", "resumen del día", "actividad")) {
            LocalDate hoy = LocalDate.now();
            List<Movimiento> mvs = movimientoRepository.findByFecha(hoy);
            List<Pedido> peds = pedidoRepository.findByFecha(hoy);

            StringBuilder sb = new StringBuilder();
            sb.append("📋 Reporte — ").append(hoy.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))).append("\n\n");
            
            sb.append("🔄 Movimientos: ").append(mvs.size()).append("\n");
            if (mvs.isEmpty()) sb.append("→ Sin movimientos\n");
            else mvs.forEach(m -> sb.append("• ").append(m.getTipo()).append(" — ").append(m.getCantidad()).append(" u\n"));
            
            sb.append("\n🛒 Pedidos: ").append(peds.size()).append("\n");
            if (peds.isEmpty()) sb.append("→ Sin pedidos\n");
            else peds.forEach(p -> sb.append("• ").append(p.getCliente()).append(" — $").append(p.getTotal()).append(" — ").append(p.getEstado()).append("\n"));
            
            return sb.toString();
        }

        // ==============================================
        // ❓ AYUDA
        // ==============================================
        return """
            🤖 Claro, pregúntame sobre:
            
            📊 "resumen general" → datos del sistema
            📦 "lista de productos" → todos los productos
            📈 "existencias de [nombre]" → stock de un producto
            ⚠️ "productos con stock bajo" → qué reponer
            🔄 "movimientos de hoy" → entradas y salidas
            🛒 "pedidos pendientes" → pedidos en proceso
            👥 "lista de clientes" → todos los clientes
            📋 "reporte del día" → actividad completa
            
            Solo escribe tu pregunta y te respondo con datos reales ✅
            """;
    }

    private boolean contiene(String texto, String... palabras) {
        for (String p : palabras) {
            if (texto.contains(p)) return true;
        }
        return false;
    }

    private String extraerNombreProducto(String q) {
        String[] indicadores = {"de ", "del ", "existencias de ", "stock de ", "cantidad de "};
        for (String ind : indicadores) {
            if (q.contains(ind)) {
                return q.substring(q.indexOf(ind) + ind.length()).trim();
            }
        }
        return q.replaceAll("existencias|stock|cantidad|ver|dime", "").trim();
    }
}
