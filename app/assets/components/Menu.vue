<template>
    <aside class="menu">
        <p class="menu-label">Outils</p>
        <ul class="menu-list">

            <li><a :class="classFor('sandbox')" @click="page = 'sandbox'">Sandbox</a></li>
            <li><a :class="classFor('wheel')" @click="page = 'wheel'">Roue personnages</a></li>
        </ul>
        <p class="menu-label">Autres</p>
        <ul class="menu-list">
            <li><a :class="classFor('cheat-sheet')" @click="page = 'cheat-sheet'">Cheat Sheet bulma</a></li>
        </ul>
    </aside>
</template>

<script setup>


const page = defineModel('page');

function classFor(pageMenu) {
    return pageMenu === page.value ? 'is-active' : '';
}

</script>

<style scoped lang="css">
@import 'bulma/css/bulma.css';
</style>
