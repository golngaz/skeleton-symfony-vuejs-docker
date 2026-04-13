<template>
    <div class="columns is-fullheight p-4">
        <!-- Menu -->
        <div class="column is-2">
            <Menu v-model:page="page" />
        </div>

        <!-- Contenu -->
        <div class="column content-area">
            <CheatSheetBulma v-if="page === 'cheat-sheet'" />
            <Sandbox v-if="page === 'sandbox'" />
            <Wheel v-if="page === 'wheel'" />
        </div>
    </div>
</template>

<script setup>
import Sandbox from "./Sandbox.vue";
import Menu from "./Menu.vue";
import { ref } from "vue";
import Wheel from "./Wheel.vue";
import CheatSheetBulma from "./CheatSheetBulma.vue";

const page = ref('cheat-sheet');

</script>

