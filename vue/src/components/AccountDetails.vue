
<template>
    <div class="main-block">
        <div id="name"> {{ Account.username }} </div>


    </div>
</template> 
  
<script>
import { computed } from 'vue';


export default {
    props: {
        Account: Object
    }
}

</script>
  
<style scoped>
#name {

    font-size: 75px;
    font-weight: bold;
    color: #7b3911;
}

.movie-img {
    /* max-width: 14%;
    max-height: 14%;
    margin: 5px; */
}

.main-block {
    display: flex;
    flex-direction: row;

    width: 30%;
    /* margin-left: 5%; */
}

.column {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    justify-content: start;
}

.movie-title {
    font-weight: bold;
    color: #890304;
    font-size: 1.5rem;

}

.release-genres {
    color: gray;
    margin-bottom: .8rem;
    font-size: .8REM;
}

.description {
    color: #890304;
    margin-bottom: 5px;
    font-size: 1rem;
    width: 70%;
}

.rating {
    color: #890304;
    font-size: 13px;
}
</style>
  
  
  
  