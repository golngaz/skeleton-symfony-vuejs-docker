<template>
    <section class="section">
        <div class="container">
            <h1 class="title">
                Hello World
            </h1>
            <p class="subtitle">
                My first website with <strong>Bulma</strong>!
            </p>
            <div class="columns is-mobile is-multiline">
                <div class="column is-half-desktop is-full-mobile">
                    <button @click="modalOpen = true" class="button is-primary is-fullwidth">Test d'une modale</button>
                </div>
                <div class="column is-half-desktop is-full-mobile">
                    <button @click="isLoading = true" class="button is-danger is-link is-fullwidth" :class="isLoading ? 'is-loading' : ''">Charge moi</button>
                </div>
            </div>
            <div class="columns">
                <div class="column is-half-desktop is-full-mobile">
                    <button @click="modalOpen = true" class="button is-primary is-fullwidth">Test d'une modale</button>
                </div>
            </div>

            <div class="columns">
                <div class="column block is-half-desktop is-full-mobile">
                    <button @click="modalOpen = true" class="button is-primary is-fullwidth">Test d'une modale</button>
                </div>
            </div>


        </div>
    </section>
    <section class="section">
        <div class="container">
            <div class="columns">
                <div class="column">Colonne 1</div>
                <div class="column">Colonne 2</div>
                <div class="column">Colonne 3</div>
                <div class="column">Colonne 4</div>
                <div class="column">Colonne 5</div>
            </div>

            <hr>

            <div :class="isLoading ? 'skeleton-lines' : ''">
                <div>bonjour</div>
                <div></div>
                <div></div>
                <div></div>
                <div></div>
            </div>

            <hr>

            <div :class="isLoading ? 'skeleton-block' : ''">
                Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.
                Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
                ut fermentum massa justo sit amet risus. Donec sed odio dui.
                Nullam quis risus eget urna mollis ornare vel eu leo.
                Cum sociis natoque penatibus et magnis dis parturient montes,
                nascetur ridiculus mus. Nullam id dolor id
                nibh ultricies vehicula ut id elit.
            </div>
        </div>
    </section>
    <section class="section">
        <div class="container">
            <div class="columns">
                <div class="column is-one-third">
                    <div class="card">
                        <div class="card-image">
                            <figure class="image is-4by3">
                                <img
                                    src="https://bulma.io/assets/images/placeholders/1280x960.png"
                                    alt="Placeholder image"
                                />
                            </figure>
                        </div>
                        <div class="card-content">
                            <div class="media">
                                <div class="media-left">
                                    <figure class="image is-48x48">
                                        <img
                                            src="https://bulma.io/assets/images/placeholders/96x96.png"
                                            alt="Placeholder image"
                                        />
                                    </figure>
                                </div>
                                <div class="media-content">
                                    <p class="title is-4">John Smith</p>
                                    <p class="subtitle is-6">@johnsmith</p>
                                </div>
                            </div>

                            <div class="content">
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec
                                iaculis mauris. <a>@bulmaio</a>. <a href="#">#css</a>
                                <a href="#">#responsive</a>
                                <br />
                                <time datetime="2016-1-1">11:09 PM - 1 Jan 2016</time>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="column">

        <p class="title">With block</p>
        <div class="block">
            <div class="field is-grouped">
                <div class="control is-expanded">
                    <input class="input" type="text" placeholder="Text input">
                </div>
                <div class="control">
                    <button class="button is-primary">Button</button>
                </div>
            </div>
        </div>
        <nav class="pagination" role="navigation" aria-label="pagination">
            <a class="pagination-previous" title="This is the first page" disabled="">Previous</a>
            <a class="pagination-next">Next page</a>
            <ul class="pagination-list">
                <li>
                    <a class="pagination-link is-current" aria-label="Page 1" aria-current="page">1</a>
                </li>
                <li>
                    <a class="pagination-link" aria-label="Goto page 2">2</a>
                </li>
                <li>
                    <a class="pagination-link" aria-label="Goto page 3">3</a>
                </li>
            </ul>
        </nav>
        <progress class="progress is-success" value="30" max="100">30%</progress>
        <div class="notification is-warning">
            <button class="delete"></button>
            Primar lorem ipsum dolor sit amet, consectetur adipiscing elit lorem ipsum dolor.
        </div>
        <article class="message is-danger">
            <div class="message-header">
                <p>Error</p>
                <button class="delete" aria-label="delete"></button>
            </div>
            <div class="message-body">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. <strong>Pellentesque risus mi</strong>, tempus quis placerat ut, porta nec nulla. Vestibulum rhoncus ac ex sit amet fringilla. Nullam gravida purus diam, et dictum <a>felis venenatis</a> efficitur.
            </div>
        </article>
    </div>
    <div class="modal" :class="modalOpen ? 'is-active' : ''">
        <div class="modal-background"></div>
        <div class="modal-card">
            <header class="modal-card-head">
                <p class="modal-card-title">Modal title</p>
                <button class="delete" aria-label="close" @click="modalOpen = false"></button>
            </header>
            <section class="modal-card-body">
                <div class="content">
                    <h1>Hello World</h1>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla accumsan, metus ultrices eleifend gravida, nulla nunc varius lectus, nec rutrum justo nibh eu lectus. Ut vulputate semper dui. Fusce erat odio, sollicitudin vel erat vel, interdum mattis neque.</p>
                    <h2>Second level</h2>
                    <p>Curabitur accumsan turpis pharetra <strong>augue tincidunt</strong> blandit. Quisque condimentum maximus mi, sit amet commodo arcu rutrum id. Proin pretium urna vel cursus venenatis. Suspendisse potenti. Etiam mattis sem rhoncus lacus dapibus facilisis. Donec at dignissim dui. Ut et neque nisl.</p>
                    <ul>
                        <li>In fermentum leo eu lectus mollis, quis dictum mi aliquet.</li>
                        <li>Morbi eu nulla lobortis, lobortis est in, fringilla felis.</li>
                        <li>Aliquam nec felis in sapien venenatis viverra fermentum nec lectus.</li>
                        <li>Ut non enim metus.</li>
                    </ul>
                    <h3>Third level</h3>
                    <p>Quisque ante lacus, malesuada ac auctor vitae, congue <a href="#">non ante</a>. Phasellus lacus ex, semper ac tortor nec, fringilla condimentum orci. Fusce eu rutrum tellus.</p>
                    <ol>
                        <li>Donec blandit a lorem id convallis.</li>
                        <li>Cras gravida arcu at diam gravida gravida.</li>
                        <li>Integer in volutpat libero.</li>
                        <li>Donec a diam tellus.</li>
                        <li>Aenean nec tortor orci.</li>
                        <li>Quisque aliquam cursus urna, non bibendum massa viverra eget.</li>
                        <li>Vivamus maximus ultricies pulvinar.</li>
                    </ol>
                </div>
            </section>
            <footer class="modal-card-foot">
                <div class="buttons">
                    <button class="button is-success">Save changes</button>
                    <button class="button" @click="modalOpen = false">Cancel</button>
                </div>
            </footer>
        </div>
    </div>
</template>

<script setup>

import { ref, watch } from "vue";

const isLoading = ref(false);

const modalOpen = ref(false);

watch(isLoading, (newValue, oldValue) => {
    if (newValue === true && newValue !== oldValue) {
        setTimeout(() => {
            isLoading.value = false;
        }, 1000);
    }
})
</script>
