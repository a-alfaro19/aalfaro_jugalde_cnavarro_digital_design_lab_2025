.cpu arm7tdmi
.syntax unified
.global _start

// Registros 
// r4: Y paleta J1
// r5: Y paleta J2
// r6: Posición Y bola
// r7: Posición X bola
// r8: Velocidad Y bola
// r9: Velocidad X bola
// r10: puntaje J1
// r11: puntaje J2

_start:
    BL init_game

main_loop:
    BL read_inputs
    BL update_paddles
    BL move_ball
    BL check_collision
    BL update_display
    B main_loop

// ---------------------------
// Inicializar juego
// ---------------------------
init_game:
    MOV r4, #60         // Y paleta J1
    MOV r5, #60         // Y paleta J2
    MOV r6, #60         // Y bola
    MOV r7, #80         // X bola
    MOV r8, #1          // Vel Y
    MOV r9, #1          // Vel X
    MOV r10, #0         // Puntaje J1
    MOV r11, #0         // Puntaje J2
    BX lr

// ---------------------------
// Leer botones
// ---------------------------
read_inputs:
    LDR r0, =0x00000000
    LDR r1, [r0]
    CMP r1, #1
    SUBEQ r4, r4, #2

    LDR r0, =0x00000004
    LDR r1, [r0]
    CMP r1, #1
    ADDEQ r4, r4, #2

    LDR r0, =0x00000008
    LDR r1, [r0]
    CMP r1, #1
    SUBEQ r5, r5, #2

    LDR r0, =0x0000000C
    LDR r1, [r0]
    CMP r1, #1
    ADDEQ r5, r5, #2
    BX lr

// ---------------------------
// Actualizar paletas
// ---------------------------
update_paddles:
    LDR r0, =0x00000010
    STR r4, [r0]
    LDR r0, =0x00000014
    STR r5, [r0]
    BX lr

// ---------------------------
// Mover bola
// ---------------------------
move_ball:
    ADD r6, r6, r8
    ADD r7, r7, r9

    CMP r6, #0
    BLT invert_velY
    CMP r6, #120
    BGT invert_velY
    BX lr

invert_velY:
    RSB r8, r8, #0
    BX lr

// ---------------------------
// Detección colisión y puntos
// ---------------------------
check_collision:
    CMP r7, #2
    BNE check_J2

    SUB r0, r6, r4
    CMP r0, #10
    MOVLE r9, #1
    BXLE lr

    ADD r11, r11, #1
    BL reset_ball
    BX lr

check_J2:
    CMP r7, #158
    BNE end_check

    SUB r0, r6, r5
    CMP r0, #10
    MOVLE r9, #-1
    BXLE lr

    ADD r10, r10, #1
    BL reset_ball
    BX lr

end_check:
    BX lr

// ---------------------------
// Resetear bola
// ---------------------------
reset_ball:
    MOV r6, #60
    MOV r7, #80
    MOV r8, #1
    MOV r9, #-1
    BX lr

// ---------------------------
// Mostrar en pantalla
// ---------------------------
update_display:
    LDR r0, =0x00000010
    STR r4, [r0]
    LDR r0, =0x00000014
    STR r5, [r0]

    LSL r1, r6, #16
    ORR r1, r1, r7

    LDR r0, =0x00000018
    STR r1, [r0]

    LDR r0, =0x0000001C
    STR r10, [r0]
    LDR r0, =0x00000020
    STR r11, [r0]
    BX lr
