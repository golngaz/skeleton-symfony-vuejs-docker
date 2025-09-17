<template>
    <div v-if="debugZone" class="debug-zone">
        <textarea v-model="html"></textarea>
        <button @click="debugZone = false">Cacher</button>
    </div>

    <div>
        <div v-html="html" />
    </div>
</template>

<script setup>
import {ref} from "vue";

const html = ref('<h1>Hello depuis Vue.js 3 🎉</h1>');

const debugZone = ref(true);

document.addEventListener("keydown", function(event) {
    if (event.key === "Escape") {
        debugZone.value = !debugZone.value;
    }
});

</script>

<style scoped lang="scss">
    .debug-zone {
        $height: 100px;
        display: flex;

        textarea {
            width: 1000px;
            height: $height;
        }

        button {
            width: 100%;
            height: $height
        }
    }
</style>
