<!-- Chess.vue -->
<template>
    <section class="section">
        <div class="container">
            <h1 class="title is-4">Échiquier (placement manuel)</h1>

            <!-- Controls -->
            <div class="box">
                <div class="columns is-vcentered is-multiline">
                    <div class="column is-narrow">
                        <label class="label">Colonne</label>
                        <div class="select">
                            <select v-model="selectedFile">
                                <option v-for="f in files" :key="f" :value="f">{{ f }}</option>
                            </select>
                        </div>
                    </div>

                    <div class="column is-narrow">
                        <label class="label">Rang</label>
                        <div class="select">
                            <select v-model="selectedRank">
                                <option v-for="r in ranks" :key="r" :value="r">{{ r }}</option>
                            </select>
                        </div>
                    </div>

                    <div class="column is-narrow">
                        <label class="label">Pièce</label>
                        <div class="select">
                            <select v-model="selectedPiece">
                                <option value="">— vide —</option>
                                <option v-for="p in pieceTypes" :key="p" :value="p">{{ capitalize(p) }}</option>
                            </select>
                        </div>
                    </div>

                    <div class="column is-narrow">
                        <label class="label">Couleur</label>
                        <div class="select">
                            <select v-model="selectedColor">
                                <option value="">— —</option>
                                <option value="white">Blanc</option>
                                <option value="black">Noir</option>
                            </select>
                        </div>
                    </div>

                    <div class="column is-narrow">
                        <label class="label">&nbsp;</label>
                        <div>
                            <button class="button is-primary" @click="placeSelected">Placer</button>
                            <button class="button is-light" @click="clearSquare">Effacer</button>
                        </div>
                    </div>

                    <div class="column">
                        <p class="is-size-7">
                            Exemple : colonne <strong>a</strong> — rang <strong>2</strong> place un pion blanc si tu choisis <strong>Pawn</strong> + <strong>Blanc</strong>.
                        </p>
                    </div>
                </div>
            </div>

            <!-- Board -->
            <div class="table-container">
                <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
                    <thead>
                    <tr>
                        <th></th>
                        <th v-for="f in files" :key="'h-'+f" class="has-text-centered">{{ f }}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="(row, rIndex) in board" :key="'row-'+rIndex">
                        <th class="has-text-weight-semibold">{{ displayRank(rIndex) }}</th>
                        <td
                            v-for="(cell, cIndex) in row"
                            :key="`cell-${rIndex}-${cIndex}`"
                            class="has-text-centered is-clickable"
                            @click="cellClicked(rIndex, cIndex)"
                            style="min-width:40px; cursor: pointer;"
                        >
                            <div class="cell-content">
                                <span v-if="cell" class="piece" v-html="pieceSymbol(cell)"></span>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th></th>
                        <th v-for="f in files" :key="'f-'+f" class="has-text-centered">{{ f }}</th>
                    </tr>
                    </tfoot>
                </table>
            </div>

            <!-- Utilities -->
            <div class="buttons">
                <button class="button is-danger" @click="resetBoard">Réinitialiser l'échiquier</button>
                <button class="button is-info" @click="dumpBoard = !dumpBoard">
                    {{ dumpBoard ? "Masquer" : "Afficher" }} état (JSON)
                </button>
            </div>

            <div v-if="dumpBoard" class="box">
                <pre>{{ board }}</pre>
            </div>
        </div>
    </section>
</template>

<script setup>
import { ref } from "vue";
// Bulma import for quick demo; in production prefer to import in main.js
import "bulma/css/bulma.css";

// fichiers et rangs
const files = ["a", "b", "c", "d", "e", "f", "g", "h"];
const ranks = ["8", "7", "6", "5", "4", "3", "2", "1"]; // affichage de haut vers bas

const pieceTypes = ["king", "queen", "rook", "bishop", "knight", "pawn"];

// board : tableau 8x8 ; chaque case = null ou { type: 'pawn', color: 'white' }
const board = ref(initBoard());

// contrôles
const selectedFile = ref("a");
const selectedRank = ref("2"); // valeur par défaut
const selectedPiece = ref("pawn");
const selectedColor = ref("white");

const dumpBoard = ref(false);

function initBoard() {
    // crée 8 rangées, chacune contenant 8 nulls
    const b = [];
    for (let r = 0; r < 8; r++) {
        const row = [];
        for (let c = 0; c < 8; c++) {
            row.push(null);
        }
        b.push(row);
    }
    return b;
}

function resetBoard() {
    const b = initBoard();
    // remplace référence entière pour forcer rafraîchissement propre
    board.value = b;
}

function capitalize(s) {
    if (!s) return "";
    return s.charAt(0).toUpperCase() + s.slice(1);
}

// conversion square -> indices dans board
function coordsToIndex(file, rank) {
    // file: 'a'..'h', rank: '1'..'8'
    const col = files.indexOf(file);
    // ranks array display is 8..1 top-to-bottom. Internally board[0] = rang 8
    const row = ranks.indexOf(rank); // ranks defined above so index 0 == rank 8
    return { row, col };
}

function placeSelected() {
    const file = selectedFile.value;
    const rank = selectedRank.value;
    const piece = selectedPiece.value;
    const color = selectedColor.value;

    const { row, col } = coordsToIndex(file, rank);
    if (row < 0 || col < 0) return;

    if (!piece || !color) {
        // if no piece or color selected, treat as clearing the square
        board.value[row][col] = null;
    } else {
        board.value[row][col] = { type: piece, color };
    }
}

function clearSquare() {
    const { row, col } = coordsToIndex(selectedFile.value, selectedRank.value);
    if (row < 0 || col < 0) return;
    board.value[row][col] = null;
}

function displayRank(rIndex) {
    // rIndex 0 -> '8', 7 -> '1'
    return ranks[rIndex];
}

function cellClicked(rIndex, cIndex) {
    // au clic on sélectionne la case dans les selects
    const file = files[cIndex];
    const rank = ranks[rIndex];
    selectedFile.value = file;
    selectedRank.value = rank;
    // si case contient une pièce on la préremplit dans les selects
    const cell = board.value[rIndex][cIndex];
    if (cell) {
        selectedPiece.value = cell.type;
        selectedColor.value = cell.color;
    } else {
        selectedPiece.value = "";
        selectedColor.value = "";
    }
}

function pieceSymbol(cell) {
    if (!cell) return "";
    // Unicode chess symbols
    const map = {
        king:   { white: "&#9812;", black: "&#9818;" },
        queen:  { white: "&#9813;", black: "&#9819;" },
        rook:   { white: "&#9814;", black: "&#9820;" },
        bishop: { white: "&#9815;", black: "&#9821;" },
        knight: { white: "&#9816;", black: "&#9822;" },
        pawn:   { white: "&#9817;", black: "&#9823;" },
    };
    const t = cell.type;
    const c = cell.color;
    if (map[t] && map[t][c]) return map[t][c];
    return "";
}
</script>

<style scoped>
.cell-content {
    font-size: 1.6rem;
    line-height: 1.6rem;
    min-height: 32px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.is-clickable:hover {
    background: #f5f5f5;
}
.piece {
    /* Laisser le style par défaut ; Unicode gère la couleur (noir/blanc) par glyph */
}
</style>
