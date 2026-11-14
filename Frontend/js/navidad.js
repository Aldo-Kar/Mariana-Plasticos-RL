
document.addEventListener("DOMContentLoaded", () => {

    // Evitar duplicar la decoración
    if (document.querySelector(".navidad-nieve")) return;

    // Crear guirnalda
    const guirnalda = document.createElement("div");
    guirnalda.className = "navidad-guirnalda";
    document.body.appendChild(guirnalda);

    // Crear capa de nieve
    const nieve = document.createElement("div");
    nieve.className = "navidad-nieve";
    document.body.appendChild(nieve);

    // No animar si el usuario lo ha solicitado
    if (window.matchMedia(
        "(prefers-reduced-motion: reduce)"
    ).matches) return;

    // Generar copos
    for (let i = 0; i < 55; i++) {
        const copo = document.createElement("span");

        copo.className = "copo";
        copo.textContent = "❄";

        copo.style.left = Math.random() * 100 + "%";
        copo.style.fontSize =
            (Math.random() * 12 + 8) + "px";

        copo.style.opacity =
            Math.random() * 0.55 + 0.25;

        copo.style.animationDuration =
            (Math.random() * 10 + 8) + "s";

        copo.style.animationDelay =
            -(Math.random() * 15) + "s";

        nieve.appendChild(copo);
    }
});
