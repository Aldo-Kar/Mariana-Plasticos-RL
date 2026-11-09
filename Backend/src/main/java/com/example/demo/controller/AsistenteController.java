package com.example.demo.controller;

import com.example.demo.service.AsistenteService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;  // ✅ Asegúrate de que esta línea esté

@RestController
@RequestMapping("/api/asistente")
@RequiredArgsConstructor
public class AsistenteController {

    private final AsistenteService asistenteService;

    @PostMapping("/consultar")
    public ResponseEntity<Map<String, Object>> consultar(@RequestBody Map<String, String> solicitud) {
        String consulta = solicitud.get("consulta");
        return ResponseEntity.ok(asistenteService.procesarConsulta(consulta));
    }
}


