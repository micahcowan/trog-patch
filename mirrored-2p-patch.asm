;JoyStickProbe
;                            ; 
;                            ;     buttons <- the currently pressed buttons, without clearing any already-recorded,
;                            ;                non-movement buttons.
;                            ;     mask    <- used to mask out any non-movement buttons;
;                            ;                we set it to the mask of buttons not found pressed in this frame.
;                            ; 
;	$85E0  48:          pha 			/* A(un)X(un)Y(un)MAP[0C:[0C],0D:[0D],0E:[0E],0F:[0F],mmc:(un)]s(0)Z*S**/
;                             ; Poll joystick 0, store state in $10
;	$85E1  A9 01:        lda #$01			/* A(01)<145E1>X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z0S0*/
;	$85E3  8D 16 40:     sta JOY1			/* A(01)<145E1>X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z0S0*/
;	$85E6  A9 00:        lda #$00			/* A(00)<145E6>X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z1S0*/
;	$85E8  8D 16 40:     sta JOY1			/* A(00)<145E6>X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z1S0*/
;	$85EB  85 10:        sta buttonScratch			/* A(00)<145E6>X(un)Y(un)MAP[0C:[0C],0D:[0D],0E:[0E],0F:[0F],mmc:(un)]s(1)Z1S0*/
;	$85ED  AD 16 40:     lda JOY1			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$85F0  4A:           lsr a			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$85F1  26 10:        rol buttonScratch			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$85F3  AD 16 40:     lda JOY1			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$85F6  4A:           lsr a			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$85F7  26 10:        rol buttonScratch			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$85F9  AD 16 40:     lda JOY1			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$85FC  4A:           lsr a			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$85FD  26 10:        rol buttonScratch			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$85FF  AD 16 40:     lda JOY1			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8602  4A:           lsr a			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8603  26 10:        rol buttonScratch			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8605  AD 16 40:     lda JOY1			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8608  4A:           lsr a			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8609  26 10:        rol buttonScratch			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$860B  AD 16 40:     lda JOY1			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$860E  4A:           lsr a			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$860F  26 10:        rol buttonScratch			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8611  AD 16 40:     lda JOY1			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8614  4A:           lsr a			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8615  26 10:        rol buttonScratch			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8617  AD 16 40:     lda JOY1			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$861A  4A:           lsr a			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$861B  26 10:        rol buttonScratch			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;                             ; End poll of joystick 0.
;	$861D  A5 2E:        lda playerOneButtons			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$861F  29 F0:        and #$F0			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8621  85 2E:        sta playerOneButtons			/* A(??)X(un)Y(un)MAP[04:[04],05:[05],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8623  A5 10:        lda buttonScratch			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8625  25 30:        and playerOneInputMask			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8627  05 2E:        ora playerOneButtons			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8629  85 2E:        sta playerOneButtons			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$862B  A5 10:        lda buttonScratch			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$862D  29 F0:        and #$F0			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$862F  49 FF:        eor #$FF			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/
;	$8631  85 30:        sta playerOneInputMask			/* A(??)X(un)Y(un)MAP[00:[00],01:[01],0E:[0E],0F:[0F],mmc:(un)]s(1)Z?S?*/

playerOneButtons = $2E
playerTwoButtons = $2F
buttonScratch = $10

* = $14643

; Poll joystick 1, store state in $10
        lda playerOneButtons
        and #$FC
        sta playerTwoButtons    ; save the buttons, up/down as-is
        lda playerOneButtons
        and #$01
        asl
        ora playerTwoButtons
        sta playerTwoButtons
        lda playerOneButtons
        and #$02
        lsr
        ora playerTwoButtons
        sta playerTwoButtons

;; this needs to be left at the end:
	pla
	rts

;;; Stuff below this line is to prevent P2 getting permanently stuck
;;; punching, in the event that P1's buttons aren't processed.


* = $1C93A
MyNewClearButtons
	                    ;lda playerOneButtons,x   ; Stoopid nescom doesn't make this zero-page
                            lda $2E,x
	                    and #$3F
	                    ;sta playerOneButtons,x
                            sta $2E,x

                            lda $035A
                            cmp #$01
                            beq +

	                    ;lda playerOneButtons
                            lda $2E
	                    and #$3F
	                    ;sta playerOneButtons
	                    sta $2E
+	                    rts

* = $1962B
ClearPlayerABButtons
                            jmp $C92A  ;; MyNewClearButtons
