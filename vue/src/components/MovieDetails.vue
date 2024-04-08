<template>
  <header>
    <h1>{{ movie.titleText }}</h1>
  </header>
  <img src="{{ movie.primaryImage }}" alt="">
  <div>
    {{ movie.plot }}
  </div>
  <div>
    {{ movie.genres }}
    <div>
      {{ movie.rating }}
    </div>
  </div>
</template> */

<script>
import { computed } from 'vue';


export default {
  props: {
    movie: Object
  }
}

</script>


