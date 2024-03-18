#!/usr/bin/env nextflow

params.greeting = 'Hello world!' 
params.caracters = 6
greeting_ch = Channel.of(params.greeting) 
caracters_ch = Channel.of(params.caracters) 

process SPLITLETTERS { 
    input: 
    val x 
    val caracters

    output: 
    path 'fatia_*' 

    script: 
    """
<<<<<<< HEAD
    printf '$x' | split -b 6 - fatia_
=======
    printf '$x' | split -b $caracters - chunk_
>>>>>>> 90002aa (Adiciona parametro de numero de caracteres)
    """
} 

process CONVERTTOUPPER { 
    input: 
    path y 

    output: 
    stdout 

    script: 
    """
    cat $y | tr '[a-z]' '[A-Z]'
    """
} 

workflow { 
    letters_ch = SPLITLETTERS(greeting_ch, caracters_ch) 
    results_ch = CONVERTTOUPPER(letters_ch.flatten()) 
    results_ch.view { it } 
}
