; cc65 feature needed for ggsound, treats ".byte -1" as ".byte 255"
.feature force_range

; include ggsound and our music tracks
.include "../lib/ggsound.asm"
.include "../lib/ggsound.inc"
.include "music/songs.asm"
.include "music/songs_dpcm.asm"

; very basic ines header
.segment "INES"
.byte "NES",$1a, $02, $00, $01, $00

.segment "CODE"

soundsystem_init:
    ;initialize modules
    lda #0
    tax
    sta sound_param_byte_0
    lda #<song_list
    sta sound_param_word_0
    lda #>song_list
    sta sound_param_word_0+1
    lda #<sfx_list
    sta sound_param_word_1
    lda #>sfx_list
    sta sound_param_word_1+1
    lda #<instrument_list
    sta sound_param_word_2
    lda #>instrument_list
    sta sound_param_word_2+1
    lda #<dpcm_list
    sta sound_param_word_3
    lda #>dpcm_list
    sta sound_param_word_3+1
    jsr sound_initialize
    rts

soundsystem_update:
    soundengine_update
    rts

; call this to start playing a song.
soundsystem_playsong:
    lda #4 ; id of the song, change this to play another tune!
    sta sound_param_byte_0
    jsr play_song
    rts

; call this to play a sound effect.
soundsystem_playsfx:
    lda #1 ; id of the sound effect, change this to play another!
    sta sound_param_byte_0
    lda #2 ; sound channel
    sta sound_param_byte_1
    jsr play_sfx
    rts

; Reset Interrupt
reset:
    ; set startup state
    sei
    cld
    ldx #$FF
    txs
    
    ; enable NMI
    lda #%10000000
    sta $2000

    jsr soundsystem_init
    jsr soundsystem_playsong
:   jmp :-


; NMI Interrupt
nmi:
    jsr soundsystem_update ; play any active sounds

    ; every 255 frames, play a sound effect.
    dec $00
    bne @skip
    jsr soundsystem_playsfx
@skip:
    rti

.segment "VECTORS"
.word nmi
.word reset
.word $ff00
