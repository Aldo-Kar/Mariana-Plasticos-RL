
document.addEventListener("DOMContentLoaded", () => {

    // Evitar que se agregue más de una vez
    if (document.querySelector(".revolucion-decoracion")) {
        return;
    }

    // Crear capa decorativa
    const decoracion = document.createElement("div");

    decoracion.className = "revolucion-decoracion";

    document.body.appendChild(decoracion);

    // Agregar pequeños detalles tricolores
    const colores = [
        "#087443",
        "#bd3035",
        "#d8bd82"
    ];

    for (let i = 0; i < 12; i++) {

        const detalle = document.createElement("span");

        detalle.className = "revolucion-confeti";

        detalle.style.backgroundColor =
            colores[i % colores.length];

        detalle.style.left =
            Math.random() * 100 + "%";

        detalle.style.top =
            Math.random() * 100 + "%";

        detalle.style.transform =
            `rotate(${Math.random() * 90}deg)`;

        decoracion.appendChild(detalle);
    }

});
