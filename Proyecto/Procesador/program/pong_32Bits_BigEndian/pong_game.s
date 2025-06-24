.cpu arm7tdmi
.syntax unified
.global _start

// r4 = Y paleta J1
// r5 = Y paleta J2
// r6 = Y bola
// r7 = X bola
// r8 = Vel Y bola
// r9 = Vel X bola
// r10 = puntaje J1
// r11 = puntaje J2

_start:
    // ---------- init_game ----------
    MOV r4, #60
    MOV r5, #60
    MOV r6, #60
    MOV r7, #80
    MOV r8, #1
    MOV r9, #1
    MOV r10, #0
    MOV r11, #0

main_loop:
    // ---------- read_inputs ----------
    LDR r0, =0x00000000
    LDR r1, [r0]
    CMP r1, #1
    BNE ri1
    SUB r4, r4, #2
ri1:
    LDR r0, =0x00000004
    LDR r1, [r0]
    CMP r1, #1
    BNE ri2
    ADD r4, r4, #2
ri2:
    LDR r0, =0x00000008
    LDR r1, [r0]
    CMP r1, #1
    BNE ri3
    SUB r5, r5, #2
ri3:
    LDR r0, =0x0000000C
    LDR r1, [r0]
    CMP r1, #1
    BNE update_paddles
    ADD r5, r5, #2

update_paddles:
    LDR r0, =0x00000010
    STR r4, [r0]
    LDR r0, =0x00000014
    STR r5, [r0]

move_ball:
    ADD r6, r6, r8
    ADD r7, r7, r9
    CMP r6, #0
    BLT invert_velY
    CMP r6, #120
    BGT invert_velY
    B check_collision

invert_velY:
    RSB r8, r8, #0

check_collision:
    CMP r7, #2
    BNE check_J2
    SUB r0, r6, r4
    CMP r0, #10
    MOVLE r9, #1
    BLE update_display
    ADD r11, r11, #1
    B reset_ball

check_J2:
    CMP r7, #158
    BNE update_display
    SUB r0, r6, r5
    CMP r0, #10
    MOVLE r9, #-1
    BLE update_display
    ADD r10, r10, #1
    B reset_ball

reset_ball:
    MOV r6, #60
    MOV r7, #80
    MOV r8, #1
    MOV r9, #-1

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

    B main_loop
