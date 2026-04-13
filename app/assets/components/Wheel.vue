<template>
    <div class="wheel-container">
        <!-- Palette -->
        <div class="palette">
            <button
                v-for="c in colors"
                :key="c"
                :style="{ background: c }"
                :class="{ active: selectedColor === c }"
                @click="selectedColor = c"
            />
        </div>

        <!-- Roue -->
        <svg
            :width="size"
            :height="size"
            :viewBox="`0 0 ${size} ${size}`"
            class="wheel"
        >
            <!-- Sections -->
            <path
                v-for="(section, i) in sections"
                :key="i"
                :d="section.path"
                class="section"
                @click="placePoint(i)"
            />

            <!-- Points -->
            <circle
                v-for="(p, i) in points"
                :key="i"
                :cx="p.x"
                :cy="p.y"
                :r="pointRadius"
                :fill="p.color"
            />
        </svg>
    </div>
</template>

<script setup>
import { computed, ref } from "vue"

/* CONFIG */
const size = 300
const radius = 140
const center = size / 2
const sectionsCount = ref(8)
const pointRadius = 6

const colors = [
    "#e74c3c", "#e67e22", "#f1c40f", "#2ecc71", "#1abc9c",
    "#3498db", "#9b59b6", "#34495e", "#7f8c8d", "#000000"
]

/* STATE */
const selectedColor = ref(colors[0])
const points = ref([])

/* UTILS */
const polarToCartesian = (angle, r) => {
    const rad = (angle - 90) * Math.PI / 180
    return {
        x: center + r * Math.cos(rad),
        y: center + r * Math.sin(rad)
    }
}

/* SECTIONS */
const sections = computed(() => {
    const angle = 360 / sectionsCount.value
    return Array.from({ length: sectionsCount.value }, (_, i) => {
        const start = i * angle
        const end = start + angle

        const p1 = polarToCartesian(start, radius)
        const p2 = polarToCartesian(end, radius)

        return {
            path: `
        M ${center} ${center}
        L ${p1.x} ${p1.y}
        A ${radius} ${radius} 0 0 1 ${p2.x} ${p2.y}
        Z
      `
        }
    })
})

/* INTERACTION */
const placePoint = (sectionIndex) => {
    const sectionAngle = 360 / sectionsCount.value

    // bornes angulaires de la section (avec marge)
    const marginAngle = sectionAngle * 0.15
    const startAngle = sectionIndex * sectionAngle + marginAngle
    const endAngle = (sectionIndex + 1) * sectionAngle - marginAngle

    // angle aléatoire dans la section
    const angle =
        startAngle + Math.random() * (endAngle - startAngle)

    // rayon aléatoire (évite centre + bord)
    const minR = radius * 0.35
    const maxR = radius * 0.75
    const r = minR + Math.random() * (maxR - minR)

    const pos = polarToCartesian(angle, r)

    const existing = points.value.find(
        p => p.color === selectedColor.value
    )

    if (existing) {
        existing.x = pos.x
        existing.y = pos.y
        existing.sectionIndex = sectionIndex
    } else {
        points.value.push({
            color: selectedColor.value,
            sectionIndex,
            x: pos.x,
            y: pos.y
        })
    }
}


</script>

<style scoped>
.wheel-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 16px;
}

.palette {
    display: flex;
    gap: 8px;
}

.palette button {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    border: 2px solid transparent;
    cursor: pointer;
}

.palette button.active {
    border-color: #333;
}

.wheel {
    cursor: pointer;
}

.section {
    fill: #eee;
    stroke: #ccc;
    transition: fill 0.2s;
}

.section:hover {
    fill: #ddd;
}
</style>
