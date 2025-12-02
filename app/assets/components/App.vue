<template>
    <div v-if="debugZone" class="debug-zone">
        <div class="editors">
            <div class="editor">
                <h3>HTML</h3>
                <textarea v-model="html"></textarea>
            </div>

            <div class="editor">
                <h3>CSS</h3>
                <textarea v-model="css"></textarea>
            </div>

            <div class="editor">
                <h3>JS</h3>
                <textarea v-model="js"></textarea>
            </div>
        </div>

        <div class="actions">
            <button class="compile-button" @click="compile">Compiler</button>
            <button @click="debugZone = false">Cacher</button>
        </div>
    </div>

    <!-- Zone d'affichage -->
    <div ref="displayZone"></div>
</template>

<script setup>
import { ref } from "vue";

const html = ref('<h1>Hello depuis Vue.js 3 🎉</h1>');
const css = ref('h1 { color: red; }');
const js = ref('const el = document.querySelector(\'h1\');\n' +
    'el.innerHTML += \' INJECTION\';');

const debugZone = ref(true);
const displayZone = ref(null);

// Conteneur CSS global
const styleEl = document.createElement("style");
document.head.appendChild(styleEl);

// Fonction de compilation
function compile() {
    // 1️⃣ injecte le CSS
    styleEl.textContent = css.value;

    // 2️⃣ réinitialise la zone d'affichage avec le HTML original
    if (displayZone.value) {
        displayZone.value.innerHTML = html.value;
    }

    // 3️⃣ exécute le JS injecté
    try {
        // Fournir `displayZone` comme contexte
        new Function("displayZone", js.value)(displayZone.value);
    } catch (err) {
        console.error("Erreur dans le code JS :", err);
    }
}

// Toggle debugZone avec Échap
document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") {
        debugZone.value = !debugZone.value;
    }
});
</script>

<style scoped lang="scss">
.debug-zone {
    display: flex;
    flex-direction: column;
    gap: 10px;

    .editors {
        display: flex;
        gap: 10px;

        .editor {
            flex: 1;
            display: flex;
            flex-direction: column;

            textarea {
                flex: 1;
                min-height: 120px;
                font-family: monospace;
            }
        }
    }

    .actions {
        display: flex;
        gap: 10px;

        button {
            height: 40px;
            line-height: 15px;

            &.compile-button {
                flex-grow: 1;
            }
        }


    }
}
</style>
