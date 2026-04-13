<template>
    <div ref="host">
        <div ref="slotContent">
            <slot />
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref, watch, nextTick } from "vue"

const host = ref(null)

// slot content
const slotContent = ref(null)

onMounted(async () => {
    const shadow = host.value.attachShadow({ mode: "open" })

    // container pour y injecter le slot
    const container = document.createElement("div")
    container.style.all = "initial"
    container.style.display = "block"
    container.style.width = "100%"
    container.style.height = "100%"
    container.style.boxSizing = "border-box"
    container.style.padding = "10px"
    container.style.backgroundColor = '#fff'

    shadow.appendChild(container)

    // créer un div temporaire pour y cloner le slot
    const temp = document.createElement("div")
    temp.appendChild(slotContent.value.cloneNode(true))

    // injecter le slot dans le shadow
    container.appendChild(temp)
})
</script>
