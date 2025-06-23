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
    LDR r0, =0x40000000
    LDR r1, [r0]        // J1 arriba
    CMP r1, #1
    SUBEQ r4, r4, #2

    LDR r0, =0x40000004
    LDR r1, [r0]        // J1 abajo
    CMP r1, #1
    ADDEQ r4, r4, #2

    LDR r0, =0x40000008
    LDR r1, [r0]        // J2 arriba
    CMP r1, #1
    SUBEQ r5, r5, #2

    LDR r0, =0x4000000C
    LDR r1, [r0]        // J2 abajo
    CMP r1, #1
    ADDEQ r5, r5, #2
    BX lr

// ---------------------------
// Actualizar paletas
// ---------------------------
update_paddles:
    LDR r0, =0x40000010
    STR r4, [r0]
    LDR r0, =0x40000014
    STR r5, [r0]
    BX lr

// ---------------------------
// Mover bola
// ---------------------------
move_ball:
    ADD r6, r6, r8  // Y += velY
    ADD r7, r7, r9  // X += velX

    // Rebote vertical
    CMP r6, #0
    BLT invert_velY
    CMP r6, #120     // Supongamos altura 128
    BGT invert_velY
    BX lr

invert_velY:
    RSB r8, r8, #0
    BX lr

// ---------------------------
// Detección colisión y puntos
// ---------------------------
check_collision:
    // Colisión con J1 (x <= 2)
    CMP r7, #2
    BNE check_J2

    // Si Y de bola dentro de rango de paleta
    SUB r0, r6, r4
    CMP r0, #10
    MOVLE r9, #1   // Rebotar derecha
    BXLE lr

    // Si no, punto J2
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
// Resetear bola tras punto
// ---------------------------
reset_ball:
    MOV r6, #60
    MOV r7, #80
    MOV r8, #1
    MOV r9, #-1     // Cambiar dirección
    BX lr

// ---------------------------
// Mostrar en pantalla
// ---------------------------
update_display:
    LDR r0, =0x40000010
    STR r4, [r0]
    LDR r0, =0x40000014
    STR r5, [r0]

    // Escribir bola
    LSL r1, r6, #16   // Y << 16
    ORR r1, r1, r7
    LDR r0, =0x40000018
    STR r1, [r0]

    // Puntaje
    LDR r0, =0x4000001C
    STR r10, [r0]
    LDR r0, =0x40000020
    STR r11, [r0]
    BX lr
